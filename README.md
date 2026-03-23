# Locus Authority Payments

> Authority Ledger with Locus USDC payments on Base - Real-world agent payments with credit limits

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

```bash
# Install dependencies
npm install

# Compile
npx hardhat compile

# Deploy to Base Sepolia
npx hardhat run scripts/deploy.js --network base-sepolia
```

## Usage

### Grant Authority with Credit

```javascript
// Grant EXECUTE level with 100 USDC credit limit
await contract.grantAuthorityWithCredit(
  agentAddress,
  3, // EXECUTE level
  100000000, // 100 USDC (6 decimals)
  86400 // 24 hours
);
```

### Authorize Payment

```javascript
// Agent authorizes a payment
await contract.authorizePayment(
  recipientAddress,
  1000000 // 1 USDC
);
```

### Execute Payment

```javascript
// Owner executes the payment
await contract.executePayment(
  paymentId,
  authorityRef
);
```

## 🌐 Live Demo

**GitHub Pages**: [https://hardbrick21.github.io/Locus-Authority-Payments/](https://hardbrick21.github.io/Locus-Authority-Payments/)

### Demo Features

The live demo allows you to:
- 🔗 **Connect Wallet** - Connect your MetaMask wallet to Base Sepolia
- 📝 **Grant Authority** - Grant authority with USDC credit limits
- 💳 **Authorize Payment** - Authorize USDC payments
- 🔍 **Check Credit** - View remaining credit for an agent
- ⚠️ **Revoke Authority** - Revoke agent authority

### How to Use the Demo

1. Open the [demo page](https://hardbrick21.github.io/Locus-Authority-Payments/)
2. Click "Connect Wallet" and approve the connection
3. Use the forms to interact with the smart contract
4. View transaction logs in real-time

---

*Authority Ledger + Locus = Real-world agent payments.*