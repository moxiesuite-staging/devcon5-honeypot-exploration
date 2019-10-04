pragma solidity ^0.5.8;

import "./PrivateBankI.sol";

contract BadGuyContract {
  address public _targetAddress;
  PrivateBankI private _target;

  constructor(address payable _targetContract) public payable {
    // _targetAddress is used for our tests
    _targetAddress = _targetContract;

    // TODO: set up target (hint: assign to `_target`)

  }

  function beBad() public payable {
    // TODO: attack the target




  }

  function () external payable {
    // TODO: reenter target
    // hint: don't forget to set a halting condition


  }

  // Helper function so we can checkout the contract's balance more easily
  function getBalance() public view returns (uint256) {
    return address(this).balance;
  }
}
