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

    constructor() payable {
        console.log("Yo yo, I am a contract and I am smart");
    }

    function pump(string memory _message) public {
        totalPumps += 1;
        console.log("%s has a pump!", msg.sender);
        pumps.push(Pump(msg.sender, _message, block.timestamp));
        emit NewPump(msg.sender, block.timestamp, _message);

        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance,
            "Trying to withdraw more money than the contract has."
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
    }

    function getAllPumps() public view returns (Pump[] memory) {
        return pumps;
    }

    function getTotalPumps() public view returns (uint256) {
        console.log("We have %d total pumps!", totalPumps);
        return totalPumps;
    }
}
