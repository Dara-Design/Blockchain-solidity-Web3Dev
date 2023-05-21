// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract FallBackExample {

    uint256 public result;

    //Fallback function must be declared as external
    //no need for function keyword
    //fallback is triggered when there is no function that is recognized, but there are some data send
    fallback() external payable {
         result = 1;
    }
    

     //fallback is triggered when there is no function that is recognized, but there are NO some data send
    receive() external payable {
        result = 2;
    }
}
// Explainer from: https://solidity-by-example.org/fallback/
  // Ether is sent to contract
    //      is msg.data empty?
    //          /   \ 
    //         yes  no
    //         /     \
    //    receive()?  fallback() 
    //     /   \ 
    //   yes   no
    //  /        \
    //receive()  fallback()