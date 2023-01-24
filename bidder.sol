//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "./Products.sol";
contract Bidder{
    address public bidder;
    uint public highestBid;
    // uint public time;
    Products public products;
    struct Product{
        string productName;
        uint ID;
        uint price;
        address seller;
    }
    struct Log{
        address account;
        string transferIsDone;
        uint price;
    }
    Log[] public logs;
    constructor(address _productAddress){
        products=Products(_productAddress);
        createProduct("Elma",0,1000000000000000000);
    }
    mapping(uint => Product) public idToProduct;
    function createProduct(string memory _productName,uint _id,uint _price)private{
        Product memory product;
        product.productName=_productName;
        product.ID=_id;
        product.price=_price;
        product.seller=msg.sender;
        idToProduct[_id]=product;
    }
    function createLog() public payable{
        Log memory log;
        log.account=bidder;
        log.price=(msg.value)/1e18;
        log.transferIsDone="Success";
        logs.push(log);
    }
    function addProduct(uint _amount,uint _id)public {
        products.mint(msg.sender,_id,_amount,"");
    }
    function giveOffer()public payable{
        require(msg.value>highestBid,"Not smaller than highest bid");
        // require(time>block.timestamp);
        if(bidder!=idToProduct[0].seller){
            payable(bidder).transfer(highestBid);
        }
        bidder=msg.sender;
        highestBid=msg.value;
        createLog();
    }
    function endAuction() public {
        // require(block.timestamp >= time, "The auction has not yet ended.");
        require(bidder != idToProduct[0].seller, "The seller cannot end the auction.");
        idToProduct[0].price=highestBid;
        payable(idToProduct[0].seller).transfer(address(this).balance);
        products.burn(msg.sender,0,5);
        createLog();
    }
}
