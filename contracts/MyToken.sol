// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract XiaomingToken {
    mapping(address=>uint) balance;
    string name;
    string symbol;
    constructor(string memory _name,string memory _symbol){
        _name = name;
        _symbol = symbol;
        _mint(msg.sender,10000 * 10 **18); // 10000枚
    }

    function _mint(address owner, uint amount) private{

    }

    function transform(address to,uint amount) public returns(bool){

    }
}
