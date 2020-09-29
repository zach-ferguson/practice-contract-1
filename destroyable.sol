import "./ownable.sol";
pragma solidity 0.5.12;

contract Destroyable is Ownable {


    function destroyContract() public onlyOwner{
        selfdestruct(address(uint160(owner)));
    }


}
