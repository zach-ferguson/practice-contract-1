pragma solidity 0.5.12;

contract mappingPractice{

    uint contractBalance = 0;

    struct Workout{
        string liftName;
        uint weight;
        uint reps;
        uint sets;
        bool strengthEx;
    }

    event workoutCreated(string liftName, uint sets, uint reps, address);
    event workoutDeleted(string liftName, address);

    address public owner;

    modifier costs(uint cost){
        require(msg.value >= cost);
        _;
    }


    modifier onlyOwner(){
        require(msg.sender == owner, "This address is not authorized to execute the task.");
        _;
    }

    constructor() public{
        owner = msg.sender;
    }

    mapping(address => Workout) public workouts;
    address[] private workoutCreators;

    function createWorkout(string memory liftName, uint weight, uint sets, uint reps) payable costs(1 ether) public{
        contractBalance += msg.value;
        Workout memory newWorkout;
        newWorkout.liftName = liftName;
        newWorkout.weight = weight;
        newWorkout.sets = sets;
        newWorkout.reps = reps;
        if(newWorkout.reps<=7){
            newWorkout.strengthEx = true;
        }
        else{
            newWorkout.strengthEx = false;
        }
        insertWorkout(newWorkout);
        workoutCreators.push(msg.sender);
        assert(
            keccak256(
                abi.encodePacked(
                    workouts[msg.sender].liftName,
                    workouts[msg.sender].weight,
                    workouts[msg.sender].reps,
                    workouts[msg.sender].sets,
                    workouts[msg.sender].strengthEx)
                    ) ==
                    keccak256(
                        abi.encodePacked(
                            newWorkout.liftName,
                            newWorkout.weight,
                            newWorkout.reps,
                            newWorkout.sets,
                            newWorkout.strengthEx)));
        emit workoutCreated(newWorkout.liftName, newWorkout.sets, newWorkout.reps, msg.sender);
    }

  function insertWorkout(Workout memory newWorkout) private{
      address creator = msg.sender;
      workouts[creator] = newWorkout;
  }

  function getWorkout() public view returns(string memory liftName, uint weight, uint sets, uint reps, bool strengthEx){
     address creator = msg.sender;
     return(workouts[creator].liftName, workouts[creator].weight, workouts[creator].sets, workouts[creator].reps, workouts[creator].strengthEx);
  }
  function deleteWorkout(address creator, string memory liftName) public onlyOwner{

      delete workouts[creator];
      assert(workouts[creator].weight==0);
      emit workoutDeleted(liftName, msg.sender);
  }
  function getCreator(uint index)public view onlyOwner returns(address){
      return workoutCreators[index];
  }
  function getContractBalance()public view onlyOwner returns(uint){
      return contractBalance;
  }
  function withdrawContractBalance()public onlyOwner returns (uint){
      uint toTransfer = contractBalance;
      contractBalance = 0;
      msg.sender.transfer(toTransfer);
      return toTransfer;
  }
}
