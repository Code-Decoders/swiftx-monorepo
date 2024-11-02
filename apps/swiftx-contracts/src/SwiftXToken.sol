// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./lib/wormhole-solidity-sdk/src/interfaces/IWormholeRelayer.sol";
import "./lib/wormhole-solidity-sdk/src/interfaces/IWormholeReceiver.sol";

/**
 * @title SwiftXToken
 * @dev ERC20 Token with minting and burning capabilities, integrated with Wormhole for cross-chain transfers.
 */
contract SwiftXToken is ERC20, Ownable, IWormholeReceiver {
    address public parentContract;
    uint16 public parentChainId;
    IWormholeRelayer public immutable wormholeRelayer;
    
    uint256 GAS_LIMIT = 250_000;

    // Events
    event CompleteTransaction(uint256 indexed amount, address indexed account, uint256 indexed txId);

    /**
     * @dev Initializes the token with Wormhole parameters.
     * @param name_ Token name.
     * @param symbol_ Token symbol.
     * @param _wormholeRelayer Address of the deployed Wormhole Relayer contract.
     * @param _parentContract Address of the SwiftX parent contract on the parent chain.
     * @param _parentChainId Id for the parent chain
     */

    constructor(
        string memory name_,
        string memory symbol_,
        address _wormholeRelayer,   
        address _parentContract,
        uint16 _parentChainId
    )
        ERC20(name_, symbol_)
        Ownable(msg.sender)
    {
        require(_wormholeRelayer != address(0), "Invalid Wormhole Relayer address");
        require(_parentContract != address(0), "Invalid Parent Contract address");
        wormholeRelayer = IWormholeRelayer(_wormholeRelayer);
        parentContract = _parentContract;
        parentChainId = _parentChainId; 
    }

    modifier onlyParent {
        require(msg.sender == parentContract);
        _;
    }

    /**
     * @notice Burns tokens from the caller's account and notifies the parent contract via Wormhole.
     * @param amount Amount of tokens to burn.
     */
    function initTransfer(uint256 amount, uint256 txId, address recipient) public payable {
        require(amount > 0, "Amount must be greater than zero");

        uint256 cost = quoteCrossChainDeposit(parentChainId);

        require(msg.value > cost, "msg.value must equal quoteCrossChainDeposit(targetChain)");

        // Encode the payload: (amount, sender)
        bytes memory payload = abi.encode(
            txId,
            amount,
            recipient,
            msg.sender,
            address(this)
        );

        wormholeRelayer.sendPayloadToEvm{value: cost}(
            parentChainId,
            parentContract,
            payload,
            0,
            GAS_LIMIT
        );
    }

        function receiveWormholeMessages(
        bytes memory payload,
        bytes[] memory,
        bytes32,        
        uint16,
        bytes32             
    ) public payable override {         
        (uint256 txId, uint256 amount, address recipient) = abi
            .decode(payload, (uint256, uint256, address));

        _completeTransfer(txId, amount, recipient);
    }

    function _completeTransfer(uint256 txId, uint256 amount, address recipient) internal {
        _mint(address(this), amount);
        emit CompleteTransaction(amount, recipient, txId);
    }

    function confirmTransfer(uint256 amount, uint256 txId, address sender) public payable {
        require(balanceOf(address(this)) >= amount, "Insufficient balance to burn");

        uint256 cost = quoteCrossChainDeposit(parentChainId);

        require(msg.value > cost, "msg.sender is less than quoteCrossChainDeposit(parentChainId)");

        _burn(address(this), amount);

        bytes memory payload = abi.encode(
            txId,
            -1,
            msg.sender,
            sender
        );

        wormholeRelayer.sendPayloadToEvm{value: cost}(
            parentChainId,
            parentContract,
            payload,
            0,
            GAS_LIMIT
        );  
    }

    /**
     * @notice Allows the owner to update the Parent Contract address.
     * @param _newParent Address of the new Parent Contract.
     */
    function updateParentContract(address _newParent) public  onlyOwner {
        require(_newParent != address(0), "Invalid Parent Contract address");
        parentContract = _newParent;
    }

    /**
     * @notice Allows the owner to update the Parent Chain ID.
     * @param _newParentChainId The new Parent Chain identifier.
     */
    function updateParentChainId(uint16 _newParentChainId) public onlyOwner {
        parentChainId = _newParentChainId;
    }

    function quoteCrossChainDeposit(uint16 targetChain) public view returns (uint256 cost) {
        uint256 deliveryCost;
        (deliveryCost,) = wormholeRelayer.quoteEVMDeliveryPrice(
            targetChain,
            0,
            GAS_LIMIT
        );
        return deliveryCost;
    }
}
