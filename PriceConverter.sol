// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";//importing npm package from github

//this file is going to be a library which we are gonna atach to uint256,like it's an object that we created
//libraries  are similar to contact's but they can't have state variables and they can't send ether either, functions must be internal

  library PriceConverter {

  function getPrice() internal view returns(uint256) {
        
        //ovo funkcija vraca trenutnu cenu eth u usd
        //posto je broj sa osam decimala, mnozimo ga sa jos 10 decimala
     
        //we need ABI and adress
        //    0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419   this is the adress from https://docs.chain.link/data-feeds/price-feeds/addresses


    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);

    (,int256 price,,,)= priceFeed.latestRoundData();  //latestRoundData function from interface is returning so many differnt variables, butt we can remove them, we only need int price
    return uint256(price * 1e10);  //typecasting int256 and uint256 can easily be converted between the two //this is ETH /USD PRICE

     }


    function getVersion() internal view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) internal view returns (uint256){
        uint256 ethPrice = getPrice();
        uint ethAmountInUsd = (ethPrice * ethAmount)/ 1e18; //da ne delimo sa 18 decimala imali bismo 36 decimala
        return ethAmountInUsd;


    }


  }