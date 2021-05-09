const Migrations = artifacts.require("../contracts/Migrations");

contract("MigrationsAnd", function() {
  it("should assert true", async () => {
    const instance = await Migrations.deployed();
    const value = await instance.getName();
    assert.equal("Migrations-Contract", value);
  });
});
