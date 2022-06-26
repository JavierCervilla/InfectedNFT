// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const Logic = await hre.ethers.getContractFactory("InfectedNFT");
  const Proxy = await hre.ethers.getContractFactory("Proxy");

  const logic = await Logic.deploy();
  await logic.deployed();
  console.log("Logic deployed to:", logic.address);

  const proxy = await Proxy.deploy(logic.address, "https://raw.githubusercontent.com/ImagiNFT/SampleTokensRewards/main/tokens/{id}.json", "https://raw.githubusercontent.com/ImagiNFT/SampleTokensRewards/main/contract.json");
  await proxy.deployed();
  console.log("Proxy deployed (and initialized) to:", proxy.address);


  // we wait for 5 confirmations blocks before verify to avoid propagation delays
  await proxy.deployTransaction.wait(5);
  await logic.deployTransaction.wait(5);

  // we use the task "verify:verify" to verify the contract programatically on etherscan
  await hre.run("verify:verify", {
    address: logic.address,
    constructorArguments: []
  });

  await hre.run("verify:verify", {
    address: proxy.address,
    constructorArguments: [
      logic.address,
      "https://raw.githubusercontent.com/ImagiNFT/SampleTokensRewards/main/tokens/{id}.json",
      "https://raw.githubusercontent.com/ImagiNFT/SampleTokensRewards/main/contract.json"
    ]
  });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });