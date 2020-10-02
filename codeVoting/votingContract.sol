// the goal of this contract is to create an inexpensive, binary system of voting. Votes will be counted upon a function execution by the poll creator. Two Thirds of total votes will determine whether a vote passes or fails.
import "./ownable.sol";
import "./destroyable.sol";
pragma solidity 0.7.2;

contract codeVoting is Ownable, Destroyable{


    uint[] polls;


    mapping (poll => ballotBox) public ballotBoxes;




    struct poll{
        string proposition;
        string dateOfCount;
        address creator;
        uint timeStamp;
    }

    struct ballot{
        uint propIndex;
        address voterAddress;
        bool iVoteYes;
    }




    event pollCreated(address);
    event ballotSubmitted(uint propIndex, address);




    function createPoll(string memory proposition, string memory dateOfCount) public {

        newPoll.proposition = proposition;
        newPoll.dateOfCount = dateOfCount;
        newPoll.creator = msg.sender;
        newPoll.timeStamp = block.timestamp;

        postPoll(newPoll);


    }

    function postPoll() public {
        polls.push(newPoll);
    }



    function createBallot(uint propIndex, bool iVoteYes) public {

        newBallot.voterAddress = msg.sender;
        newBallot.iVoteYes = iVoteYes;

        submitBallot(propIndex);
        emit ballotSubmitted(newBallot.propIndex, msg.sender);
    }




    function submitBallot(i) public{
        pollMapping[i].push(newBallot);
    }


    function getPropositions() public returns(uint propIndex, string proposition, string dateOfCount, string dateOfCreation){
    }
}
