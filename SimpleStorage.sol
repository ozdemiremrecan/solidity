//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SimpleStorage{
    //Adress-> uint e sahip bir sözlük oluşturdum
    mapping(address => uint)public balance;
    // Para yükleme
    function receiveAmount()public payable{
        balance[msg.sender]+=msg.value;
    }
    //Para çekme
    function withdraw(uint _amount) public payable{
        require(balance[msg.sender] > _amount,"Not enough have a money");
        balance[msg.sender]-=_amount;
        payable(msg.sender).transfer(_amount);
    }
    //Hesabımızı görüntüleme
    function viewBalance()public view returns(uint){
        return balance[msg.sender];
    }
}
