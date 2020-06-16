const Migrations = artifacts.require("MigrationsAnd");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
