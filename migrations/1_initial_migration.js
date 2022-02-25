// const Migrations = artifacts.require("Migrations");
const Market = artifacts.require("Market");
const NFT = artifacts.require("NFT");

module.exports = async function (deployer) {
  // await deployer.deploy(Migrations);
  await deployer.deploy(Market);
  await deployer.deploy(NFT);
  
};
