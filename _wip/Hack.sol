pragma solidity ^0.5.8;

contract Hack {
  modifier isRegistered() {
    require(registeredAddresses[msg.sender], "You must be registered");
    _;
  }

  bytes32 private merkleRoot;
  // pretend this is the constructor...
  function init(bytes32 _merkleRoot) public {
    merkleRoot = _merkleRoot;
  }
  mapping(address => string) public registeredNames;
  mapping(bytes32 => address) public passwordHashes;
  mapping(string => address) usedPasswords;
  mapping(address => bool) registeredAddresses;

  function commitRegister(bytes32 passwordHash, string calldata friendlyName) external {
    address addr = passwordHashes[passwordHash];
    if (addr == address(0)) {
      passwordHashes[passwordHash] = msg.sender;
      registeredNames[msg.sender] = friendlyName;
    } else {
      require(addr == msg.sender, "Password already registered");
    }
  }

  function revealRegister(string calldata password, bytes32[] calldata proof) external {
    address addr = usedPasswords[password];
    if (addr == address(0)) {
      require(passwordHashes[keccak256(abi.encodePacked(password))] == msg.sender, "Password hash not registered to sender");
      require(verify(password, proof), "Invalid password");
      usedPasswords[password] = msg.sender;
      registeredAddresses[msg.sender] = true;
    } else {
      require(addr == msg.sender, "Password already registered");
    }
  }

  function verify(string memory password, bytes32[] memory proof) private view returns(bool){
    bytes32 computedHash = keccak256(abi.encodePacked(password));

    for (uint256 i = 0; i < proof.length; i++) {
      bytes32 proofElement = proof[i];
      if (computedHash < proofElement) {
        // Hash(current computed hash + current element of the proof)
        computedHash = keccak256(abi.encodePacked(computedHash, proofElement));
      } else {
        // Hash(current element of the proof + current computed hash)
        computedHash = keccak256(abi.encodePacked(proofElement, computedHash));
      }
    }

    return computedHash == merkleRoot;
  }

  function deposit() public isRegistered {

  }

  function withdraw() public isRegistered {
    
  }
}
