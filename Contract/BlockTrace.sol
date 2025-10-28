// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract BlockTrace {
    address public owner;
    uint256 public launchBlock;
    mapping(address => bool) public participant;
    uint256 public participantCount;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event ParticipantRegistered(address indexed participant, uint256 total);

    constructor() {
        owner = msg.sender;
        launchBlock = block.number;
    }

    // Register sender as a participant, no input
    function register() public {
        require(!participant[msg.sender], "Already registered.");
        participant[msg.sender] = true;
        participantCount += 1;
        emit ParticipantRegistered(msg.sender, participantCount);
    }

    // Reset all participation data (Owner only, no input)
    function reset() public {
        require(msg.sender == owner, "Not contract owner.");
        participantCount = 0;
    }

    // Transfer ownership to contract deployer (no input)
    function resetOwner() public {
        require(msg.sender == owner, "Not contract owner.");
        emit OwnershipTransferred(owner, address(this));
        owner = address(this);
    }

    // Get the age of the contract in blocks (no input)
    function contractAge() public view returns (uint256) {
        return block.number - launchBlock;
    }
}
