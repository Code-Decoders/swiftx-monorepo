// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./lib/wormhole-solidity-sdk/src/interfaces/IWormholeReceiver.sol";
import "./lib/wormhole-solidity-sdk/src/interfaces/IWormholeRelayer.sol";

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

    IWormholeRelayer wormholeRelayer;

    uint256 GAS_LIMIT = 250_000;

    mapping(uint256 => SwiftXMetadata) public ledger;
    mapping(address => uint16) public childTokenToChainId;

    event LedgerUpdated(uint256 indexed nonce, SwiftXMetadata txn);

    constructor(
        address _wormholeRelayer
    ) Ownable(msg.sender){
        wormholeRelayer = IWormholeRelayer(_wormholeRelayer);
    }

    /**
     * @notice Handles incoming Wormhole messages and updates the ledger.
     * @dev Overrides the receivePayloadAndTokens from TokenReceiver.
     * @param payload The incoming message payload.
     */
    function receiveWormholeMessages(
        bytes memory payload,
        bytes[] memory,
        bytes32 sourceAddress,        
        uint16,
        bytes32             
    ) public payable override {                 
        // Expected format: (tokenId, amount, recipient)
        (uint256 txId, uint256 amount, address recipient, address sender) = abi
            .decode(payload, (uint256, uint256, address, address));

        address childToken = address(uint160(uint256(sourceAddress)));

        SwiftXMetadata memory txn = SwiftXMetadata({
            sender: sender,
            recipient: recipient,
            amount: amount
        });

        // Encode the payload: (amount, sender)
        bytes memory tokenPayload = abi.encode(
            txId,
            amount,
            recipient
        );

        uint16 childChainId = childTokenToChainId[childToken];

        uint256 cost = quoteCrossChainDeposit(childChainId);

        wormholeRelayer.sendPayloadToEvm{value: cost}(
            childChainId,
            childToken,
            tokenPayload,
            0,
            GAS_LIMIT
        );
        
        ledger[txId] = txn;

        emit LedgerUpdated(txId, txn);
    }

    function addChildTokens(address tokenAddress, uint16 chainId) public onlyOwner {
        childTokenToChainId[tokenAddress] = chainId;
    }

    function getChildTokens(address tokenAddress) 
        public view returns (uint16 childChainId){
            return childTokenToChainId[tokenAddress];
    }

    function getTransaction(
        uint256 txId
    ) public view returns (SwiftXMetadata memory) {
        SwiftXMetadata memory metadata = ledger[txId];
        return metadata;
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
