// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";
import "../lib/wormhole-solidity-sdk/src/WormholeRelayerSDK.sol";

/**
 * @title SwiftX
 * @dev Parent contract managing cross-chain transactions via Wormhole.
 */
contract SwiftX is TokenReceiver, Ownable {

    struct SwiftXMetadata {
        address sender;
        address recipient;
        uint256 amount;
        uint8 tokenId;
        uint16 sourceChain;
        uint64 nonce;
    }

    mapping(uint64 => SwiftXMetadata) public ledger;

    uint64 public currentNonce;

    event LedgerUpdated(uint64 indexed nonce, SwiftXMetadata txn);
    event TokensExchanged(address indexed sender, address indexed recipient, uint256 amount, uint8 tokenId, uint16 sourceChain);

    /**
     * @dev Initializes the contract with Wormhole parameters.
     * @param _wormholeRelayer Address of the deployed Wormhole Relayer contract.
     * @param _tokenBridge Address of the deployed Token Bridge contract.
     * @param _wormhole Address of the deployed Wormhole contract.
     */
    constructor(address _wormholeRelayer, address _tokenBridge, address _wormhole)
    TokenBase(_wormholeRelayer, _tokenBridge, _wormhole)
    Ownable(msg.sender)
    {
        require(_wormholeRelayer != address(0), "Invalid Wormhole Relayer address");
        require(_tokenBridge != address(0), "Invalid Token Bridge address");
        require(_wormhole != address(0), "Invalid Wormhole address");

    }

    /**
     * @notice Handles incoming Wormhole messages and updates the ledger.
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

        // Expected format: (tokenId, amount, recipient)
        (uint8 receivedTokenId, uint256 amount, address recipient) = abi.decode(payload, (uint8, uint256, address));

        SwiftXMetadata memory txn = SwiftXMetadata({
            sender: address(0),
            recipient: recipient,
            amount: amount,
            tokenId: receivedTokenId,
            sourceChain: sourceChain,
            nonce: currentNonce
        });

        ledger[currentNonce] = txn;

        emit LedgerUpdated(currentNonce, txn);
        emit TokensExchanged(txn.sender, recipient, amount, receivedTokenId, sourceChain);

        currentNonce += 1;
    }
}
