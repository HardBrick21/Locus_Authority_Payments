// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title LocusAuthorityPayments
 * @notice Authority Ledger with Locus USDC payments on Base
 * @dev Integrates Locus payment protocol for real-world agent payments
 */
contract LocusAuthorityPayments {
    
    // USDC on Base
    address public constant USDC = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913;
    
    // Locus payment router (placeholder - replace with actual address)
    address public locusRouter;
    
    enum AuthorityLevel {
        REVOKED,
        OBSERVE,
        SUGGEST,
        EXECUTE
    }
    
    struct AuthorityState {
        AuthorityLevel level;
        uint256 usdcCreditLimit;  // USDC credit limit (6 decimals)
        uint256 usdcSpent;
        uint256 expiresAt;
        bool isActive;
    }
    
    struct Payment {
        bytes32 id;
        address from;
        address to;
        uint256 amount;
        bytes32 authorityRef;
        uint256 timestamp;
    }
    
    // State
    mapping(address => AuthorityState) public authorities;
    mapping(bytes32 => Payment) public payments;
    mapping(address => bytes32[]) public paymentHistory;
    
    address public owner;
    uint256 public totalPayments;
    
    event AuthorityGrantedWithCredit(address indexed agent, AuthorityLevel level, uint256 usdcCreditLimit);
    event PaymentAuthorized(bytes32 indexed paymentId, address indexed from, address to, uint256 amount);
    event PaymentExecuted(bytes32 indexed paymentId, bytes32 authorityRef);
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }
    
    modifier onlyAgentWithExecute() {
        require(authorities[msg.sender].level == AuthorityLevel.EXECUTE, "Need EXECUTE level");
        require(authorities[msg.sender].isActive, "Agent not active");
        _;
    }
    
    constructor(address _locusRouter) {
        owner = msg.sender;
        locusRouter = _locusRouter;
    }
    
    /**
     * @notice Grant authority with USDC credit limit
     * @dev Uses Locus for real-world payments on Base
     */
    function grantAuthorityWithCredit(
        address agent,
        AuthorityLevel level,
        uint256 usdcCreditLimit,
        uint256 duration
    ) external onlyOwner {
        AuthorityState storage state = authorities[agent];
        
        state.level = level;
        state.usdcCreditLimit = usdcCreditLimit;
        state.usdcSpent = 0;
        state.expiresAt = duration > 0 ? block.timestamp + duration : 0;
        state.isActive = true;
        
        emit AuthorityGrantedWithCredit(agent, level, usdcCreditLimit);
    }
    
    /**
     * @notice Authorize a USDC payment
     * @dev Agent with EXECUTE level can authorize payments up to credit limit
     */
    function authorizePayment(
        address to,
        uint256 amount
    ) external onlyAgentWithExecute returns (bytes32 paymentId) {
        AuthorityState storage state = authorities[msg.sender];
        
        require(state.usdcSpent + amount <= state.usdcCreditLimit, "Exceeds credit limit");
        
        paymentId = keccak256(abi.encodePacked(msg.sender, to, amount, block.timestamp, totalPayments));
        
        payments[paymentId] = Payment({
            id: paymentId,
            from: msg.sender,
            to: to,
            amount: amount,
            authorityRef: bytes32(0),
            timestamp: block.timestamp
        });
        
        paymentHistory[msg.sender].push(paymentId);
        totalPayments++;
        
        state.usdcSpent += amount;
        
        emit PaymentAuthorized(paymentId, msg.sender, to, amount);
    }
    
    /**
     * @notice Execute a USDC payment via Locus
     * @dev In production, this would integrate with Locus router
     */
    function executePayment(
        bytes32 paymentId,
        bytes32 authorityRef
    ) external onlyOwner returns (bool) {
        Payment storage payment = payments[paymentId];
        require(payment.id == paymentId, "Payment not found");
        require(payment.authorityRef == bytes32(0), "Already executed");
        
        // Execute USDC transfer
        // In production: Locus router would handle this
        IERC20(USDC).transfer(payment.to, payment.amount);
        
        payment.authorityRef = authorityRef;
        
        emit PaymentExecuted(paymentId, authorityRef);
        
        return true;
    }
    
    /**
     * @notice Check if agent can make a payment
     */
    function canMakePayment(address agent, uint256 amount) external view returns (bool) {
        AuthorityState storage state = authorities[agent];
        return state.level == AuthorityLevel.EXECUTE 
            && state.isActive 
            && state.usdcSpent + amount <= state.usdcCreditLimit;
    }
    
    /**
     * @notice Get agent's remaining credit
     */
    function getRemainingCredit(address agent) external view returns (uint256) {
        AuthorityState storage state = authorities[agent];
        return state.usdcCreditLimit - state.usdcSpent;
    }
    
    /**
     * @notice Get payment history for an agent
     */
    function getPaymentHistory(address agent) external view returns (bytes32[] memory) {
        return paymentHistory[agent];
    }
}