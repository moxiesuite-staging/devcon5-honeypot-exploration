/* solhint-disable */
/* solium-disable */
pragma solidity ^0.5.8;

import "./LogI.sol";

// our own version of the "Private Bank" Contract based on the one on EtherScan
contract PrivateBank {
  mapping (address => uint) public balances;

  uint public MinDeposit = 1 ether;

  LogI TransferLog;

  constructor(address _log) public {
    TransferLog = LogI(_log);
  }

  function deposit() public payable {
    if (msg.value >= MinDeposit) {
      balances[msg.sender] += msg.value;
      TransferLog.addMessage(msg.sender, msg.value, "Deposit");
    }
  }

  function cashOut(uint _amount) public {
    if(_amount <= balances[msg.sender]) {
      bool success;
      (success, ) = msg.sender.call.value(_amount)("");
      if (success) {
        balances[msg.sender] -= _amount;
        TransferLog.addMessage(msg.sender, _amount, "CashOut");
      }
    }
  }

  function() external payable{} // fallback
}
