pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract PumpPortal {
    uint256 totalPumps;

    constructor() {
        console.log("Yo yo, I am a contract and I am smart");
    }

    function pump() public {
        totalPumps += 1;
        console.log("%s has a pump!", msg.sender);
    }

    function getTotalPumps() public view returns (uint256) {
        console.log("We have %d total pumps!", totalPumps);
        return totalPumps;
    }
}
