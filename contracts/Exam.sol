pragma solidity ^0.5.0;

import "hardhat/console.sol";

contract ExamContract {
    struct Exam {
        address walletAddress;
        string subject;
        string quest;
        string answ1;
        string answ2;
        string correctAnswer;
    }

    mapping (address => uint) public examsIds;

    Exam[] public examInfo;

    event newExamAdded(uint id);

    constructor() public
    {
        newExam(address(0x0), "", "", "", "", "");
        newExam(address(0x333333333333), "Android", "Com es diu la màquina virtual de Java", "JVM", "JNSIC", "1");

    }

    function registerExam(string memory subject, string memory quest, string memory answ1, string memory answ2, string memory correctAnswer) public
    returns(uint) 
    {
        return newExam(msg.sender, subject, quest, answ1, answ2, correctAnswer);
    }

    function newExam(address _wAddr, string memory subject, string memory quest, string memory answ1, string memory answ2, string memory correctAnswer) private
    returns(uint) 
    {
        // checking if the user is already registered
        uint userId = examsIds[_wAddr];
        require (userId == 0);

        // associating the user wallet address with the new ID
        examsIds[_wAddr] = examInfo.length;
        uint newUserId = examInfo.length++;

        // storing the new user details
        examInfo[newUserId] = Exam({
        	walletAddress: _wAddr,
            subject: subject,
            quest: quest,
            answ1: answ1,
            answ2: answ2,
            correctAnswer: correctAnswer
        });

        // emitting the event that a new user has been registered
        emit newExamAdded(newUserId);

        return newUserId;
    }

    function getExamById(uint _id) public view
    returns(
        address,
    	string memory,
    	string memory,
        string memory,
        string memory,
        string memory
    ) {
    	// checking if the ID is valid
    	require( (_id > 0) || (_id <= examInfo.length) );

    	Exam memory i = examInfo[_id];

    	return (
    		i.walletAddress,
    		i.subject,   		
    		i.quest,
    		i.answ1,
            i.answ2,
            i.correctAnswer
    	);
    }

    function totalExams() public view returns (uint)
    {
        // NOTE: the total registered user is length-1 because the user with
        // index 0 is empty check the contructor: addUser(address(0x0), "", "");
        return examInfo.length - 1;
    }
}