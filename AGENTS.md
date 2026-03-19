# AGENTS.md - Locus Authority Payments

## Overview

Locus Authority Payments integrates Locus payment protocol with Authority Ledger, enabling AI agents to make real-world USDC payments on Base with credit limits.

## What It Does

- **USDC Credit Limits**: Set spending limits for agents
- **Payment Authorization**: EXECUTE-level agents can authorize payments
- **Locus Integration**: Real-world payments via Locus protocol
- **Full Audit Trail**: Every payment has authority reference

## How to Interact

### Smart Contract Interface

**LocusAuthorityPayments** (deploy on Base)

```solidity
// Grant authority with USDC credit limit
function grantAuthorityWithCredit(
    address agent,
    AuthorityLevel level,
    uint256 usdcCreditLimit,
    uint256 duration
) external onlyOwner;

// Authorize a USDC payment
function authorizePayment(
    address to,
    uint256 amount
) external onlyAgentWithExecute returns (bytes32 paymentId);

// Execute payment via Locus
function executePayment(
    bytes32 paymentId,
    bytes32 authorityRef
) external onlyOwner returns (bool);

// Check if agent can make payment
function canMakePayment(address agent, uint256 amount) 
    external view returns (bool);

// Get remaining credit
function getRemainingCredit(address agent) 
    external view returns (uint256);
```

### Authority Levels

- `0` = REVOKED (no permissions)
- `1` = OBSERVE (read-only)
- `2` = SUGGEST (can suggest, human confirms)
- `3` = EXECUTE (can authorize payments up to credit limit)

## Network Information

| Network | Chain ID | RPC |
|---------|----------|-----|
| Base Mainnet | 8453 | https://mainnet.base.org |
| Base Sepolia | 84532 | https://sepolia.base.org |

## Contract Addresses

| Contract | Address |
|----------|---------|
| USDC (Base) | `0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913` |
| Locus Router | TBD |

## Integration Guide

### Grant Authority with Credit

```javascript
// Grant EXECUTE level with 100 USDC credit limit
await contract.grantAuthorityWithCredit(
  agentAddress,
  3, // EXECUTE level
  ethers.parseUnits('100', 6), // 100 USDC (6 decimals)
  86400 // 24 hours
);
```

### Authorize Payment

```javascript
// Agent authorizes a payment
const paymentId = await contract.authorizePayment(
  recipientAddress,
  ethers.parseUnits('10', 6) // 10 USDC
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

## Payment Flow

```
1. Owner grants authority with USDC credit limit
2. Agent (EXECUTE level) authorizes payment
3. Payment is recorded with paymentId
4. Owner executes payment via Locus
5. USDC transferred to recipient
6. Full audit trail on-chain
```

## Target Track

**Best Use of Locus** ($3,000)

---

*Locus Authority Payments - Real-world agent payments.*