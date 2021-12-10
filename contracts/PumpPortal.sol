pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract PumpPortal {
    uint256 totalPumps;

    event NewPump(address indexed from, uint256 timestamp, string message);

    struct Pump {
        address pumper;
        string message;
        uint256 timestamp;
    }

    Pump[] pumps;

    constructor() {
        console.log("Yo yo, I am a contract and I am smart");
    }

    function pump(string memory _message) public {
        totalPumps += 1;
        console.log("%s has a pump!", msg.sender);
        pumps.push(Pump(msg.sender, _message, block.timestamp));
        emit NewPump(msg.sender, block.timestamp, _message);
    }

    function getAllPumps() public view returns (Pump[] memory) {
        return pumps;
    }

    function getTotalPumps() public view returns (uint256) {
        console.log("We have %d total pumps!", totalPumps);
        return totalPumps;
    }
}
