//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract ExamContract {
    uint256 totalExams;

    struct Exam {
        string score;
        address from;
        uint256 datetime;
    }

    Exam[] allScores;

    // number of exams done
    mapping(address => uint256) examsSolved;

    event NewScore(address indexed from, uint256 timestamp, string score);

    constructor(string memory _score) {
        console.log("The score is ", _score);
    }

    function sendScore(string memory _newScore) public {
        console.log("%s has sent a message!", msg.sender);

        allScores.push(Exam(_newScore, msg.sender, block.timestamp));

        totalExams += 1;
        examsSolved[msg.sender] += 1;

        console.log(
            "Number of exams of %a %s >> ",
            msg.sender,
            examsSolved[msg.sender]
        );

        emit NewScore(msg.sender, block.timestamp, _newScore);
    }

    function getAllScores() public view returns (Exam[] memory) {
        return allScores;
    }
}
