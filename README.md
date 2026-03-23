# Locus Authority Payments

[![Synthesis Submission](https://img.shields.io/badge/Synthesis-Submit-blue?logo=gitbook)](https://synthesis.devfolio.co/projects/locus-authority-payments-xxx)

Authority Ledger with Locus USDC payments on Base - Real-world agent payments with credit limits

## 🏆 Synthesis Hackathon Submission

- **Track**: Best Use of Locus
- **Status**: ✅ Published
- **Demo**: https://hardbrick21.github.io/Locus-Authority-Payments/
- **GitHub**: https://github.com/HardBrick21/Locus-Authority-Payments

## 📋 Cover Image

![Locus Authority Payments Cover](https://raw.githubusercontent.com/HardBrick21/Locus-Authority-Payments/main/cover.svg)

## Overview

This project integrates **Locus** payment protocol with Authority Ledger, enabling AI agents to make real-world USDC payments on Base with credit limits and full audit trail.

## Why Locus?

- **Base USDC** - Stable, reliable stablecoin payments
- **Real-world payments** - Agents can pay for services, APIs, etc.
- **Credit limits** - Control how much an agent can spend
- **Full audit trail** - Every payment recorded on-chain

## Key Features

1. **USDC Credit Limits** - Set spending limits for agents
2. **Payment Authorization** - Agents with EXECUTE level can authorize payments
3. **Locus Integration** - Real-world payments via Locus protocol
4. **Full Audit Trail** - Every payment has authority reference

## Contract Addresses

| Contract | Address | Network |
|----------|---------|---------|
| LocusAuthorityPayments | TBD | Base Sepolia |
| USDC | `0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913` | Base |

## Quick Start

### Installation

```bash
npm install
```

### Compile

```bash
npx hardhat compile
```

### Test

```bash
npx hardhat test
```

### Deploy

```bash
npx hardhat run scripts/deploy.js --network <network>
```

## 🛠️ Tech Stack

- Solidity
- Hardhat
- Locus Protocol
- USDC (Base)

## 📁 Project Structure

- `contracts/` - Smart contracts
- `frontend/` - Frontend application
- `scripts/` - Deployment scripts
- `test/` - Test files

## 📖 Documentation

- [AGENTS.md](./AGENTS.md) - Agent documentation

## 🤝 Team

- **AI Agent**: Brick Locus
- **Human**: hardbrick

## 📅 Timeline

- Started: March 18, 2026
- Submitted: March 22, 2026
- Published: March 22, 2026

---

*Built with OpenClaw Agent Platform*
