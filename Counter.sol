//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Counter{
    uint public count;
    function increment(uint a)public{
        count+=a;
    }
    function decrement(uint b)public{
        count-=b;
    }
}
