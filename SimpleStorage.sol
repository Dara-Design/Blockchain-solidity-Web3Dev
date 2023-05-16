// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;// version of solidity this changes constantly

contract SimpleStorage {
    //This gets initialized to zero!
    uint256  public favoriteNumber;

    People[] public people;

   

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    mapping(string => uint256) public nameToFavoriteNumber;//na svaki string lepi vrednost uinta  //something like a dictionary

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }
    
    
     function retrieve() public view returns(uint256){
        return favoriteNumber;
     }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        // people.push(People(_favoriteNumber, _name)); //capitilised People is reffeing to to struct, the lowercase people is reffering to lowercase array

        // People memory newPerson = People({favoriteNumber: _favoriteNumber, name: _name});
        // people.push(newPerson);
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

    //view,pure 

    //a view function- were just goint to read something from this contract(function)
    //View and pure function disallow modificato of state- so YOU CAN'T UPDATE BLOCHAIN AT ALL WITH THE VIEW FUNCTION
    //pure function EVEN DISALLOW READING FROM BLOCHAIN STATE -NO READING STORAGE , like return favorite number etc
    
}

//0xd9145CCE52D386f254917e481eB44e9943F39138

