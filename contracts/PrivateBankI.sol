pragma solidity ^0.5.8;

// Our PrivateBank interface for use in our `BadGuyContract`
contract PrivateBankI {
  mapping (address => uint) public balances;

  uint public MinDeposit = 1 ether;

  function deposit() public payable;

  function cashOut(uint _am) public;

  function() external payable;
}
