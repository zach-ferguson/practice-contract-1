pragma solidity 0.7.2;

//  The goal of this project is to create a simple betting
//    contract where 2 users each bet a specified amount
//    and guess a number 1-100. A random number generator
//    will determine the winner (closest guesser),
//    who will recieve the betting pot.


contract mainContract is Destroyable{

uint contractBalance = 0;

address[] private gamblersArr;


modifier costs(uint cost){
  require(msg.value == cost);
}

function guessBet(uint numberGuess) payable costs(10000000000000000 wei) public{
  contractBalance += msg.value;
  gamblersArr.push(msg.sender)
}




}
