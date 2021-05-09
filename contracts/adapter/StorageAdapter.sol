pragma solidity ^0.8.4;

import "../gateway/StoragePort.sol";

contract StorageAdapter is StoragePort {

    mapping (address => Todo []) private toDoStorage;

    function addTodo(address addr, string memory todoItemName, string memory todoItemValue) public payable override {
            toDoStorage[addr].push(Todo(todoItemName, todoItemValue));
    }

    function getTodo(address addr, uint256 index) public view override returns (Todo memory todoItem) {
        return toDoStorage[addr][index];
    }
}
