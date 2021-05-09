pragma solidity ^0.8.4;

interface StoragePort {

    function addTodo(address addr, string memory todoItemName, string memory todoItemValue) external payable;

    function getTodo(address addr, uint256 index) external view returns(Todo memory todoItem);

    struct Todo {
        string name;
        string value;
    }
}
