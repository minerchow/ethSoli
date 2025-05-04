// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
contract Bank {
    mapping(address => uint) public deposit;
    address public  immutable token;
    constructor(address _token){
        token = _token;
        
    }

    modifier requireBalance(uint amount){
        amount = amount * 10 ** 18;
        uint balance = deposit[msg.sender];
        require(amount<= balance,"the amount more than balance  ");
        _;
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

    //取款 external 内部外部都可调用
    function withDraw(uint amount) external {
        amount = amount * 10 ** 18;
      // require(IERC20(token).transfer(msg.sender,amount),"transfer error");
       require(amount <= deposit[msg.sender],"amount error");
       SafeERC20.safeTransfer(IERC20(token),msg.sender,amount);
       deposit[msg.sender] -= amount;
    }

    //转帐
    function bankTransfer(address to,uint amount) public requireBalance(amount){
        amount = amount * 10 ** 18;
       // require(amount<=deposit[msg.sender],"the amount more than balance  ");
        deposit[msg.sender] -= amount;
        deposit[to] += amount;
    }
}