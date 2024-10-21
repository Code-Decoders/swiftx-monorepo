// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title SwiftX
 * @dev Parent contract managing cross-chain transactions via Wormhole.
 */
contract SwiftX is Ownable {
    struct SwiftXMetadata {
        address sender;
        address agency;
        uint256 amount;
    }

    mapping(uint256 => SwiftXMetadata) public ledger;

    event LedgerUpdated(uint256 indexed nonce, SwiftXMetadata txn);

    constructor() Ownable(msg.sender){}

    /**
     * @notice Updates the ledger.
     * @param payload The incoming message payload.
     */
    function updateLedger(
        bytes memory payload
    ) external {                 
        // Expected format: (tokenId, amount, recipient)
        (uint256 txId, uint256 amount, address agency, address sender) = abi
            .decode(payload, (uint256, uint256, address, address));

        SwiftXMetadata memory txn = SwiftXMetadata({
            sender: sender,
            agency: agency,
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
