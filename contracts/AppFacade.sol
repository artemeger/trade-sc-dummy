pragma solidity ^0.8.4;

import "./gateway/StoragePort.sol";

contract AppFacade {

    address private storageAddress;
    StoragePort private storagePort;

    constructor (address _storageAddress){
        setStorageAddress(_storageAddress);
    }

    function setStorageAddress(address _storageAddress) public {
        storageAddress = _storageAddress;
        storagePort = StoragePort(storageAddress);
    }

    function addTodo(address addr, string memory todoItemName, string memory todoItemValue) public {
        storagePort.addTodo(addr, todoItemName, todoItemValue);
    }

    function getTodo(address addr, uint256 index) public view returns(StoragePort.Todo memory todoItem) {
        try storagePort.getTodo(addr, index) returns (StoragePort.Todo memory todoItem){
            return todoItem;
        } catch (bytes memory) {
            todoItem = StoragePort.Todo("", "");
        }
    }
}