pragma solidity ^0.5.8;

contract Log {
  struct Message {
    address Sender;
    string  Data;
    uint Val;
    uint  Time;
  }
  
  Message[] public History;
  
  Message LastMsg;
  
  function addMessage(address _adr, uint _val, string memory _data) public {
    LastMsg.Sender = _adr;
    LastMsg.Time = now;
    LastMsg.Val = _val;
    LastMsg.Data = _data;
    History.push(LastMsg);
  }
}
