const MigrationsAnd = artifacts.require("MigrationsAnd");

contract("MigrationsAnd", function() {
  it("should assert true", async () => {
    const instance = await MigrationsAnd.deployed();
    const value = await instance.getName();
    assert.equal('my name', value);
  });
});
