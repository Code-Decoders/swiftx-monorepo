// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";
import "../lib/wormhole-solidity-sdk/src/interfaces/IWormholeReceiver.sol";

/**
 * @title SwiftX
 * @dev Parent contract managing cross-chain transactions via Wormhole.
 */
contract SwiftX is IWormholeReceiver, Ownable {
    struct SwiftXMetadata {
        address sender;
        address recipient;
        uint256 amount;
    }

    mapping(uint256 => SwiftXMetadata) public ledger;

    event LedgerUpdated(uint256 indexed nonce, SwiftXMetadata txn);

    constructor() Ownable(msg.sender){}

    /**
     * @notice Handles incoming Wormhole messages and updates the ledger.
     * @dev Overrides the receivePayloadAndTokens from TokenReceiver.
     * @param payload The incoming message payload.
     */
    function receiveWormholeMessages(
        bytes memory payload,
        bytes[] memory,
        bytes32,
        uint16,
        bytes32
    ) public payable override {

        // Expected format: (tokenId, amount, recipient)
        (uint256 txId, uint256 amount, address recipient, address sender) = abi
            .decode(payload, (uint256, uint256, address, address));

        SwiftXMetadata memory txn = SwiftXMetadata({
            sender: sender,
            recipient: recipient,
            amount: amount
        });

        ledger[txId] = txn;

        emit LedgerUpdated(txId, txn);
    }

    function getTransaction(
        uint256 txId
    ) public view returns (SwiftXMetadata memory) {
        SwiftXMetadata memory metadata = ledger[txId];
        return metadata;
    }
}
