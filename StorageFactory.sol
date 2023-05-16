//SPDX-Licence-Identifier: MIT
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;




//need to import contact we wonna build
import "./SimpleStorage.sol";


//smart contracts are composable -they can easily interact with each other
//we can have contracts deploying other contracts for us



contract StorageFactory {
    //WE ARE CREATING A FUNCTION FOR DEPLOYING OF ANOTHER IMPORTED
    // CONTRACT AND SAVING IT TO THE GLOBAL VARIALBE

   SimpleStorage[] public simpleStorageArray;
    //creating an array for deploying multiple contracts -pravimo niz koji nam omogucava da napravimo vise ugovora i sacuvamo u varijablu 

    //funkcija za kreiranje ugovora iz drugog ugovora 
    function createSimpleStorageContract() public {
      SimpleStorage  simpleStorage = new SimpleStorage();
      simpleStorageArray.push(simpleStorage);
    }

  
  
  //we are creating a function that allows us to call store function from SimpleStorage contract

   function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
    // za svaku interakciju sa ugovorom trebace ti dve stvari : Adresa ugovora i ABI -interface koji ti prikazuje kako  mozes da vrsis interakciju sa njim
    //Adress
    //ABI -showing us all inputs and= outputs
    //kreiramo novi objekat koji sa nalazi u nizu simpleStorageArray na poziciji(indexu) _simpleStorageIndex
    SimpleStorage simpleStorage =  SimpleStorage(simpleStorageArray[_simpleStorageIndex]);
   // i iz tog objekta pozivamo funkciju store
   simpleStorage.store(_simpleStorageNumber); //simpleStorageNumber cuvas u toj funkciju store iz drugog ugovora

     }

     //dodajemo funkciju retrieve iz drugog ugovora, koja samo vraca vrednost, koja je u ovom slucaju jednaka vrednosti _simpleStorageNumber iz funkcije sfStore
     //funkciju public moze svako da pozove
     function sfGet(uint256 _simpleStorageIndex) public view returns (uint256){
      
       SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex]; //this is the same as SimpleStorage(simpleStorageArray[simpleStorageIndex]);
       return simpleStorage.retrieve();
     }

      }