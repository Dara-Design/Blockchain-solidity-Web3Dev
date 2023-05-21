//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

//We are creating fund me function for sending donations and withdraw function for withdrawing donations
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";


error NotOwner(); //custom error goes outside the contract

contract FundMe {

    using PriceConverter for uint256; //must mention library

    uint public MINIMUM_USD = 1 * 1e18; //1 * 10** 18
    address public /*immutable*/ i_owner;
    //both constant and immutuable variables are more gas efficient that regular
    //immutuable can be declared also in constructor, constant only once

    constructor(){    //konstruktor se poziva odmah sa pozivanjem funkcije, podesava adresu vlasnika racuna
        i_owner = msg.sender;
    }

    address[] public funders; //creating array list of funders
    mapping (address => uint256) public  adressToAmountFunded;  //mapping adress of funder to amount of money they funded

    function fund() public payable {  //function must have 'payable' keyword to be payable


    //getConversionRate f-ja uzima jedan parametar- u ovom slucaju po defaultu msg.value
    require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough");
    funders.push(msg.sender); //msg.sender je adresa posaljioca
    adressToAmountFunded[msg.sender] = msg.value;
    //require predstavlja minimum wei koji moramo poslati da bi se transakcija obavila, ukoliko ne posaljemo dovoljno, sve prethodne akcije u funkciji se revertuju 

    
    
    /*kako proracunati koju vrednost wei da saljemo, tj. koja je dovoljna
    1.    https://data.chain.link/ethereum/mainnet/crypto-usd/eth-usd   -proveriti trenutnu cenu
    2.    koliko smo postavili dolara(minimumUsd varijabla)/trenutna cena ETH/USD  50/1820 = 0.0274
    3.Pretvoris tu vrednost eth u wei na eth-converter.com 
    4. 0.0276E = 27400000000000000 wei
    */

    }

   function getVersion() public view returns (uint256){
        // ETH/USD price feed address of Sepolia Network.
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }


    modifier onlyOwner{
        //require(msg.sender == owner)

        if(msg.sender != i_owner) revert NotOwner(); //if not owner we cast custom error
        
        _; //this means- the rest of the code
    }
    
    
    
    //funds can retrieve only owner of account 
    function withdraw() public onlyOwner{
        //we need to reset everything adressess , mapping, amounts
        for(uint256 funderIndex=0; funderIndex < funders.length;funderIndex++){
            address funder = funders[funderIndex];
            adressToAmountFunded[funder]=0;
        }
   
    funders = new address[](0);


       //postoji vise nacina da posaljemo ovu transakciju transfera, poslednja se trenutno koristi -call
        //  transfer
        // payable(msg.sender).transfer(address(this).balance);
        // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");
        
        // call

        (bool callSuccess, )= payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");

    }


//UKOLIKO SE DESI DA SE POSALJU PARE BEZ FUNKCIJE FUND- OPET PREUSMERAVAMO NA TU F-JU

     fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }

  }