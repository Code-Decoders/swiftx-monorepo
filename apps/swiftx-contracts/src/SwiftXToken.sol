// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title SwiftXToken
 * @dev ERC20 Token with minting and burning capabilities, integrated with Wormhole for cross-chain transfers.
 */

interface ISwiftXContract {
    function updateLedger(bytes memory payload) external;
}

contract SwiftXToken is ERC20 {
    ISwiftXContract public swiftX;

    
    uint256 GAS_LIMIT = 250_000;

    /**
     * @dev Initializes the token with Wormhole parameters.
     * @param name_ Token name.
     * @param symbol_ Token symbol.
     */

    constructor(
        string memory name_,
        string memory symbol_,
        address swiftXAddress
    ) ERC20(name_, symbol_) {
        swiftX = ISwiftXContract(swiftXAddress);
    }

    /**
     * @notice Burns tokens from the caller's account and notifies the parent contract via Wormhole.
     * @param amount Amount of tokens to burn.
     */
    function initTransfer(uint256 amount, uint256 txId, address agency) public payable {
        require(amount > 0, "Amount must be greater than zero");

        _mint(address(this), amount);

        // Encode the payload: (amount, sender)
        bytes memory payload = abi.encode(
            txId,
            amount,
            agency,
            msg.sender
        );

        swiftX.updateLedger(payload);
    }

    function confirmTransfer(uint256 amount, uint256 txId, address sender) public payable {
        require(balanceOf(address(this)) >= amount, "Insufficient balance to burn");

        _burn(address(this), amount);

        bytes memory payload = abi.encode(
            txId,
            0,
            msg.sender,
            sender
        );

        swiftX.updateLedger(payload);
    }

    /**
     * @notice Allows the owner to update the Parent Contract address.
     * @param _swiftX Address of the new SwiftX Contract.
     */
    function updateSwiftX(address _swiftX) public {
        swiftX = ISwiftXContract(_swiftX);
    }
}
