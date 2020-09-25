pragma solidity 0.5.12;

contract mappingPractice{

    struct Workout{
        string liftName;
        uint weight;
        uint reps;
        uint sets;
        bool strengthEx;
    }

    address public owner;

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    constructor() public{
        owner = msg.sender;
    }

    mapping(address => Workout) public workouts;
    address[] private workoutCreators;

    function createWorkout(string memory liftName, uint weight, uint sets, uint reps) public{
        require(reps > 1, "workout cannot be a 1RM");
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

    }

  function insertWorkout(Workout memory newWorkout) private{
      address creator = msg.sender;
      workouts[creator] = newWorkout;
  }

  function getWorkout() public view returns(string memory liftName, uint weight, uint sets, uint reps, bool strengthEx){
     address creator = msg.sender;
     return(workouts[creator].liftName, workouts[creator].weight, workouts[creator].sets, workouts[creator].reps, workouts[creator].strengthEx);
  }
  function deleteWorkout(address creator) public onlyOwner{
      delete workouts[creator];
      assert(workouts[creator].weight==0);
  }
  function getCreator(uint index)public view onlyOwner returns(address){
      return workoutCreators[index];
  }
}
