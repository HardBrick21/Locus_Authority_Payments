const hre = require("hardhat");

async function main() {
  console.log("Deploying Locus Authority Payments to Base Sepolia");
  console.log("Chain ID: 84532\n");

  // Locus router placeholder (replace with actual address)
  const LOCUS_ROUTER = "0x0000000000000000000000000000000000000000";

  const LocusAuthorityPayments = await hre.ethers.getContractFactory("LocusAuthorityPayments");
  
  console.log("Deploying LocusAuthorityPayments...");
  const payments = await LocusAuthorityPayments.deploy(LOCUS_ROUTER);
  await payments.waitForDeployment();
  
  const address = await payments.getAddress();
  console.log(`✅ LocusAuthorityPayments deployed to: ${address}`);
  
  console.log("\n--- Deployment Summary ---");
  console.log(`Contract: ${address}`);
  console.log(`Network: Base Sepolia Testnet`);
  console.log(`USDC Address: 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913`);
  console.log(`Explorer: https://sepolia.basescan.org/address/${address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});