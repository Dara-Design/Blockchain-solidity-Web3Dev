//SPDX-Licence-Identifier: MIT
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
//you need to have compatible versions of different contracts

//EVM -ETHEREUM VIRTUAL MACHINE


//need to import contract we wonna build
import "./SimpleStorage.sol";


contract StorageFactory {
    //WE ARE CREATING A FUNCTION FOR DEPLOYING OF ANOTHER IMPORTED
    // CONTRACT AND SAVING IT TO THE GLOBAL VARIALBE
     
    SimpleStorage[] public simpleStorageArray;
    //creating an array for deploying multiple contracts

    function createSimpleStorageContract() public {

      SimpleStorage  simpleStorage = new SimpleStorage();
      simpleStorageArray.push(simpleStorage);
    }

}