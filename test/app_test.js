const AppFacade = artifacts.require("../contracts/AppFacade");
const StorageAdapter = artifacts.require("../contracts/adapter/StorageAdapter");

contract("AppFacade", async function() {

    let storageAddressInital;
    let storageAddressUpgrade;

    it("Todo String should be added to Storage", async () => {
        let accounts = await web3.eth.getAccounts();
        let app = await AppFacade.deployed();
        let storageInital = await StorageAdapter.deployed();
        storageAddressInital = storageInital.address;
        console.log("Initial storage at: " + storageAddressInital);
        await app.addTodo(accounts[1], "My first ToDo", "Write a Unit Test");
        let result = await app.getTodo(accounts[1], 0);
        assert.equal("My first ToDo", result.name);
        assert.equal("Write a Unit Test", result.value);
    });

    it("Todo String should not be present after we switch the Storage Port, but after we switch" +
        " back to the initial one the values are present", async () => {
        let accounts = await web3.eth.getAccounts();
        let app = await AppFacade.deployed();
        let storageUpgrade = await StorageAdapter.new();
        storageAddressUpgrade = storageUpgrade.address;
        await app.setStorageAddress(storageAddressUpgrade);
        console.log("New storage at: " + storageAddressUpgrade);
        let result = await app.getTodo(accounts[1], 0);
        assert.equal("", result.name);
        assert.equal("", result.value);
        await app.setStorageAddress(storageAddressInital);
        result = await app.getTodo(accounts[1], 0);
        assert.equal("My first ToDo", result.name);
        assert.equal("Write a Unit Test", result.value);
    });
});