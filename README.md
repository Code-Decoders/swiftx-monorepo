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
- **Contracts**: Smart contracts for the SwiftX ecosystem deployed on Base.
- **Supabase Edge Functions**: Edge functions for Supabase.


## Tech Stack

The SwiftX ecosystem leverages a variety of technologies to ensure robust and scalable solutions:

- **Frontend**: Flutter for mobile applications.
- **Backend**: Next.js for API server and admin panel.
- **Blockchain**: Smart contracts written in Solidity and deployed on Base.
- **Database**: Supabase for edge functions and database management.
- **Deployment**: Vercel for deploying the Next.js API server.

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

## Smart Contract links
- [SwiftX Ledger]()
- [SwiftX Token ]()

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
