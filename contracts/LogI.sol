pragma solidity ^0.5.8;

contract LogI {
  struct Message {
    address Sender;
    string  Data;
    uint Val;
    uint  Time;
  }

  Message[] public History;

  Message LastMsg;

  function addMessage(address _adr,uint _val,string memory _data) public;
}
