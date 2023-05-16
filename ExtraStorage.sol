// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;// version of solidity this changes constantly

//when we wanna  use functions from another contract but with some modifications
//WE USE INHERITENCE -> parent-child relation
//we can add additional functions to this new contract

import "./SimpleStorage.sol";

contract ExtraStorage is SimpleStorage  {

//overriding functions -modifying original functions
//in order to a function to be overridable you need to add virtual keyword in original contract -this case SimpleStorage.sol

 function store(uint256 _favoriteNumber) public override  {
        favoriteNumber = _favoriteNumber +5;
    }
}