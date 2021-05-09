const StorageAdapter = artifacts.require("../contracts/adapter/StorageAdapter");

const Migrations = artifacts.require("../contracts/Migrations");
const AppFacade = artifacts.require("../contracts/AppFacade");

module.exports = async function (deployer) {
  await deployer.deploy(Migrations);
  await deployer.deploy(StorageAdapter);
  let instanceStorage = await StorageAdapter.deployed();
  let appFacade = await deployer.deploy(AppFacade, instanceStorage.address);
};
