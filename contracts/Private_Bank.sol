/* solhint-disable */
/* solium-disable */
pragma solidity ^0.5.8;

import "./Log.sol";

contract Private_Bank {
  mapping (address => uint) public balances;

  uint public MinDeposit = 1 ether;

  Log TransferLog;

  constructor(address _log) public {
    TransferLog = Log(_log);
  }

  function deposit() public payable {
    if(msg.value >= MinDeposit) {
      balances[msg.sender] += msg.value;
      TransferLog.addMessage(msg.sender, msg.value, "Deposit");
    }
  }

  function cashOut(uint _amount) public {
    if(_amount <= balances[msg.sender]) {
      bool success;
      (success, ) = msg.sender.call.value(_amount)("");
      if(success) {
        balances[msg.sender] -= _amount;
        TransferLog.addMessage(msg.sender, _amount, "CashOut");
      }
    }
  }

  function() external payable{} // fallback
}
