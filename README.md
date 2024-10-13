# SwiftX Monorepo
![SwiftX Logo](https://i.imgur.com/aFCddFa.png)

Welcome to the SwiftX Monorepo! This repository contains all the projects and packages related to the SwiftX ecosystem.

## Table of Contents

- [Introduction](#introduction)
- [Projects](#applications)
- [Tech Stack](#tech-stack)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Live Link](#live-link)
- [Demo Video](#demo-video)

## Introduction

Because when we say “SWIFT”, we mean it…

> SwiftX is a dual-ledger-based SWIFT extension designed for enterprise-grade cross-border payments. 

> It enables individuals and businesses to make instant payouts by using blockchain tokens as guarantees in a pledge model, allowing receiving partners to pay out funds instantly before traditional settlement is completed. 

> SwiftX offers enhanced speed, reliability, and compliance with global financial regulations, making it a scalable solution ready for integration. Its unique approach reduces settlement times compared to conventional SWIFT systems, ensuring seamless and efficient financial transactions.

## Applications

This monorepo includes the following application:

- **Mobile App**: SwiftX mobile app for iOS and Android.
- **Next.js API Server**: API server built with Next.js.
- **Admin Panel**: Admin panel for managing SwiftX treasury and governance.
- **Contracts**: Smart contracts for the SwiftX ecosystem.
- **Supabase Edge Functions**: Edge functions for Supabase.
- **Network Monitor**: Network monitor for the SwiftX network for gas and congestion.
- **Wormhole Indexer**: Indexer for the Wormhole bridge for processing transactions.

## Tech Stack

The SwiftX ecosystem leverages a variety of technologies to ensure robust and scalable solutions:

- **Frontend**: Flutter for mobile applications.
- **Backend**: Next.js for API server and admin panel.
- **Blockchain**: Smart contracts written in Solidity.
- **Database**: Supabase for edge functions and database management.
- **Monitoring**: Custom network monitoring tools.
- **Deployment**: Vercel for deploying the Next.js API server.
- **Interoperability**: Wormhole SDK for cross-chain communication.
- **Wallet**: Circle Developer Programmable Wallet for managing digital assets.
- **Smart Contract Platform**: Circle Smart Contract Platform for deploying and managing smart contracts.

## Installation

To install the dependencies for all projects, run:

```bash
yarn install
```

## Scripts

Here are the commands you can use to manage and run the various applications in this monorepo:

- **Next.js API Server**:
    - `yarn dev:nextjs`: Navigate to the Next.js API server directory, install dependencies, and start the development server.
    - `yarn build:nextjs`: Build the Next.js API server for production.
    - `yarn test:nextjs`: Run tests for the Next.js API server.
    - `yarn lint:nextjs`: Lint the Next.js API server code.

- **Mobile App**:
    - `yarn dev:flutter`: Navigate to the SwiftX mobile app directory and run the app using Flutter.
    - `yarn build:flutter`: Build the SwiftX mobile app for production.

- **Deployment**:
    - `yarn deploy`: Deploy the Next.js API server to production using Vercel.

- **Supabase Edge Functions**:
    - `yarn supabase`: Navigate to the apps directory and deploy the Supabase edge function `ledger-trigger`.

- **Wormhole Indexer**:
    - `yarn wormhole`: Navigate to the Wormhole indexer directory and run the indexer script.

- **Network Monitor**:
    - `yarn monitor`: Navigate to the SwiftX network monitor directory and run the network monitor script.

## Smart Contract links
- [SwiftX Ledger Ethereum Sepolia](https://sepolia.etherscan.io/address/0x6a6da2f286e27bf8aabbfbfde3251dd02188c89d)
- [SwiftX Token Ethereum Sepolia](https://sepolia.etherscan.io/address/0x4648d6c6c3705d7bb85783d8f85570ba8a0ff23e)
- [SwiftX Token Arbitrum Sepolia](https://sepolia.arbiscan.io/address/0xa88e420bba06379bd7872939ff510e2e3ea62f4a)

## Usage

To start using the tools and libraries in this monorepo, refer to the documentation of each individual project.

To test the product in action:
- Download the APK from the releases section for the mobile app.
- Log in to the admin dashboard for the admin panel.

## Contributing

We welcome contributions! Please read our [contributing guidelines](CONTRIBUTING.md) to get started.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Live Link

Check out the live application [here](https://swiftx.codedecoders.io).

## Demo Video

Watch the demo video [here](https://youtu.be/WQyCmmNygOc).
