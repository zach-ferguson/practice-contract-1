pragma solidity 0.7.2;

contract Ownable{

    address internal owner;

    modifier onlyOwner(){
        require(msg.sender == owner, "This address is not authorized to execute the task.");
        _;
    }

    constructor() {
        owner = msg.sender;
    }
}
