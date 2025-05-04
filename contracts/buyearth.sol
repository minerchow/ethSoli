// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract BuyEarth {
    uint256 private constant PRICE = 0.001 ether;
    address private owner;
    uint [100] private squares;
    constructor() {
        owner = msg.sender; // 部署合约的地址
    }

    function getSquares() public view  returns (uint[] memory) {
        uint[] memory _squares = new uint[](100);
        for(uint i = 0; i < 100; i++){
            _squares[i] = squares[i];
        }
        return _squares;
    }

    function buySquare(uint index,uint color) public payable {
        require(index >= 0 && index < 100, "Invalid index");
        require(msg.value >= PRICE, "Insufficient funds");
        (bool sent, ) = owner.call{value:msg.value}("");
        require(sent,"failed to send ether");
        squares[index] = color;
    }
}