// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "@openzeppelin/contracts/interfaces/IERC20.sol";
contract Bank {
    mapping(address => uint) public deposit;
    address public  immutable token;
    constructor(address _token){
        token = _token;
    }

    //查询余额 view表示只能查看区块链上状态，不能修改  pure 查看修改都不能
    function myBalance() public view returns(uint){
        return deposit[msg.sender]/(10 ** 18);
    }

    //存款 不写 默认表示可以修改
    function depositeds(uint amount) public {
        amount = amount * 10 ** 18;
        require( IERC20(token).transferFrom(msg.sender,address(this),amount),"transfrom error");
        deposit[msg.sender] += amount;
    }
}