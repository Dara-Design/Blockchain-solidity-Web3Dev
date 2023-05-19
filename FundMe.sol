//SPDF-License-Identifier: MIT

pragma solidity ^0.8.8;

//We are creating fund me function for sending donations and withdraw function for withdrawing donations

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; //importing npm package from github

contract FundMe {
    uint public minimumUsd = 50 * 1e18; //1 * 10** 18

    address[] public funders; //creating array list of funders
    mapping (address => uint256) public  adressToAmountFunded;  //mapping adress of funder to amount of money they funded

    function fund() public payable {  //function must have 'payable' keyword to be payable

    require(getConversionRate(msg.value) >= minimumUsd, "Didn't send enough");
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

 
 
    function getPrice() public view returns(uint256) {
        //ovo funkcija vraca trenutnu cenu eth u usd
        //posto je broj sa osam decimala, mnozimo ga sa jos 10 decimala
     
        //we need ABI and adress
        //    0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419   this is the adress from https://docs.chain.link/data-feeds/price-feeds/addresses
        
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);

    (,int256 price,,,)= priceFeed.latestRoundData();  //latestRoundData function from interface is returning so many differnt variables, butt we can remove them, we only need int price
    return uint256(price * 1e10);  //typecasting int256 and uint256 can easily be converted between the two //this is ETH /USD PRICE

     }


    function getVersion() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        uint ethAmountInUsd = (ethPrice * ethAmount)/ 1e18; //da ne delimo sa 18 decimala imali bismo 36 decimala
        return ethAmountInUsd;


    }

    //function withdraw();

  }