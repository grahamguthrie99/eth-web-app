pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract PumpPortal {
    uint256 totalPumps;

    uint256 private seed;

    event NewPump(address indexed from, uint256 timestamp, string message);

    struct Pump {
        address pumper;
        string message;
        uint256 timestamp;
    }

    Pump[] pumps;

    mapping(address => uint256) public lastGivenPump;

    constructor() payable {
        console.log("Yo yo, I am a contract and I am smart");
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function pump(string memory _message) public {
        require(
            lastGivenPump[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );

        lastGivenPump[msg.sender] = block.timestamp;

        totalPumps += 1;
        console.log("%s has a pump!", msg.sender);
        pumps.push(Pump(msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("Random # generated: %d", seed);

        if (seed <= 50) {
            console.log("%s won!", msg.sender);

            /*
             * The same code we had before to send the prize.
             */
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }
    }

    function getAllPumps() public view returns (Pump[] memory) {
        return pumps;
    }

    function getTotalPumps() public view returns (uint256) {
        console.log("We have %d total pumps!", totalPumps);
        return totalPumps;
    }
}
