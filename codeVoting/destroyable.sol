import "./ownable.sol";
pragma solidity 0.7.2;
contract Destroyable is Ownable {


    function destroyContract() public onlyOwner{
        selfdestruct(address(uint160(owner)));
    }


}
