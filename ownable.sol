pragma solidity 0.5.12;

contract Ownable{

    address public owner;

    modifier onlyOwner(){
        require(msg.sender == owner, "This address is not authorized to execute the task.");
        _;
    }

    constructor() public{
        owner = msg.sender;
    }
}
