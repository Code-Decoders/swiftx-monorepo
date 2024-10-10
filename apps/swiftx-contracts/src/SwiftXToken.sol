// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../lib/wormhole-solidity-sdk/src/WormholeRelayerSDK.sol";

/**
 * @title SwiftXToken
 * @dev ERC20 Token with minting and burning capabilities, integrated with Wormhole for cross-chain transfers.
 */
contract SwiftXToken is ERC20, Ownable, TokenSender, TokenReceiver {
    address public parentContract;
    uint16 public parentChainId;
    uint8 public tokenId;

    // Event declarations
    event TokensBurned(address indexed burner, uint256 amount);
    event TokensMinted(address indexed recipient, uint256 amount, uint8 tokenId);
    
    uint256 GAS_LIMIT = 250_000;

    /**
     * @dev Initializes the token with Wormhole parameters.
     * @param name_ Token name.
     * @param symbol_ Token symbol.
     * @param _wormholeRelayer Address of the deployed Wormhole Relayer contract.
     * @param _tokenBridge Address of the deployed Token Bridge contract.
     * @param _wormhole Address of the deployed Wormhole contract.
     * @param _parentContract Address of the SwiftX parent contract on the parent chain.
     */

    constructor(
        string memory name_,
        string memory symbol_,
        uint8,
        address _wormholeRelayer,
        address _tokenBridge,
        address _wormhole,
        address _parentContract,
        uint16 
    )
        ERC20(name_, symbol_)
        Ownable(msg.sender)
        TokenBase(_wormholeRelayer, _tokenBridge, _wormhole)
    {
        require(_wormholeRelayer != address(0), "Invalid Wormhole Relayer address");
        require(_tokenBridge != address(0), "Invalid Token Bridge address");
        require(_wormhole != address(0), "Invalid Wormhole address");
        require(_parentContract != address(0), "Invalid Parent Contract address");
    }

    /**
     * @notice Handles incoming Wormhole messages and mints tokens to recipients.
     * @dev Overrides the receivePayloadAndTokens from TokenReceiver.
     * @param payload The incoming message payload.
     * @param receivedTokens Array of tokens received.
     * @param sourceAddress Address of the sender contract on the source chain.
     * @param sourceChain Chain ID of the source chain.
     */
    function receivePayloadAndTokens(
        bytes memory payload,
        TokenReceived[] memory receivedTokens,
        bytes32 sourceAddress,
        uint16 sourceChain,
        bytes32
    ) internal override onlyWormholeRelayer isRegisteredSender(sourceChain, sourceAddress) {
        require(receivedTokens.length == 1, "Expected 1 token transfer");

        // Decode the payload
        // Expected format: (tokenId, amount, recipient)
        (uint8 receivedTokenId, uint256 amount, address recipient) = abi.decode(payload, (uint8, uint256, address));

        // Validate token address
        address tokenAddress = receivedTokens[0].tokenAddress;
        require(tokenAddress == address(this), "Unsupported token");

        // Mint tokens to the recipient
        _mint(recipient, amount);


    }

    /**
     * @notice Burns tokens from the caller's account and notifies the parent contract via Wormhole.
     * @param amount Amount of tokens to burn.
     */
    function sendCrossChainDeposit(uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance to burn");

        uint256 cost = quoteCrossChainDeposit(parentChainId);

        _mint(address(this), amount);

        // Encode the payload: (amount, sender)
        bytes memory payload = abi.encode(
            amount,
            msg.sender
        );


        wormholeRelayer.sendPayloadToEvm{value: cost}(
            parentChainId,
            parentContract,
            payload,
            0,
            GAS_LIMIT
        );

        // uint64 nonce = sendTokenWithPayloadToEvm(
        //     targetChain,
        //     targetReceiver,
        //     payload,
        //     0,
        //     gasLimit,
        //     address(this),
        //     amount
        // );

        // require(nonce != 0, "Wormhole sendTokenWithPayloadToEvm failed");

    }

    function burnForExchange(address erc20Address, uint256 amount) external onlyOwner {
        require(erc20Address != address(0), "Invalid account address");
        require(balanceOf(erc20Address) >= amount, "Insufficient balance to burn");

        _burn(erc20Address, amount);

        bytes memory payload = abi.encode(
            amount,
            msg.sender
        );

        uint256 cost = quoteCrossChainDeposit(parentChainId);


        wormholeRelayer.sendPayloadToEvm{value: cost}(
            parentChainId,
            parentContract,
            payload,
            0,
            GAS_LIMIT
        );

        emit TokensBurned(erc20Address, amount);
    }

    /**
     * @notice Allows the owner to mint tokens to a specified address.
     * @dev Can only be called by the owner (typically the parent contract).
     * @param recipient Address to mint tokens to.
     * @param amount Amount of tokens to mint.
     */
    function mintTokens(address recipient, uint256 amount) external onlyOwner {
        _mint(recipient, amount);
        emit TokensMinted(recipient, amount, tokenId);
    }

    /**
     * @notice Allows the owner to update the Parent Contract address.
     * @param _newParent Address of the new Parent Contract.
     */
    function updateParentContract(address _newParent) external onlyOwner {
        require(_newParent != address(0), "Invalid Parent Contract address");
        parentContract = _newParent;
    }

    /**
     * @notice Allows the owner to update the Parent Chain ID.
     * @param _newParentChainId The new Parent Chain identifier.
     */
    function updateParentChainId(uint16 _newParentChainId) external onlyOwner {
        parentChainId = _newParentChainId;
    }

    function quoteCrossChainDeposit(uint16 targetChain) public view returns (uint256 cost) {
        uint256 deliveryCost;
        (deliveryCost,) = wormholeRelayer.quoteEVMDeliveryPrice(
            targetChain,
            0,
            GAS_LIMIT
        );

        cost = deliveryCost + wormhole.messageFee();
    }
}
