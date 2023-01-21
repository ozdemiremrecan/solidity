//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract Storage{
    mapping(address => uint) public balance;
    address public owner;
    struct Log{
        address transferAddress;
        string transferLog;
        uint value;
    }
    Log[] public logs;
    constructor(){
        owner = msg.sender;
    }
    modifier ownable(){
        require(owner==msg.sender);
        _;
    }
    function createLog(uint _amount)public payable ownable{
        Log memory log;
        log.transferLog="Transfer is done.";
        log.transferAddress=owner;
        log.value=_amount;
        logs.push(log);
    }
    function receiveMoney() public payable ownable{
        balance[owner]+=msg.value;
        createLog(msg.value);
    }
    function withdraw(uint _amount) public payable ownable{
        require(balance[msg.sender] > _amount,"Not enough have a money");
        balance[msg.sender]-=_amount;
        createLog(_amount);
        payable(msg.sender).transfer(_amount);
    }
    function viewBalance() public view returns(uint){
        return balance[owner];
    }
}
