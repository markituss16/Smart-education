//SPDX-License-Identifier: Unlicense
pragma solidity ^0.5.0;

import "hardhat/console.sol";

contract UserContract {
    uint256 public number = 1;
    struct User {
        address walletAddress;
        string name;
        string username;
        string course;
        string emailAddress;
        string role;
        uint createdAt;
    }

    // it maps the user's wallet address with the user ID
    mapping (address => uint) public usersIds;

    User[] public userScores;

    event newUserScoreAdded(uint id);
    event updateUserScoreEvent(uint id);

    // Modifier: check if the caller of the smart contract is registered
    modifier checkSenderIsRegistered {
    	require(isRegistered());
    	_;
    }

    /**
     * Constructor function
     */
    constructor() public
    {
        // NOTE: the first user MUST be emtpy: if you are trying to access to an element
        // of the usersIds mapping that does not exist (like usersIds[0x12345]) you will
        // receive 0, that's why in the first position (with index 0) must be initialized
        newUserScore(address(0x0), "", "", "", "", "");
    }

    function registerScore(string memory _name, string memory _username, string memory _course, string memory _emailAddress, string memory _role) public
    returns(uint) 
    {
        return newUserScore(msg.sender, _name, _username, _course, _emailAddress, _role);
    }

    function newUserScore(address _wAddr, string memory _name, string memory _username, string memory _course, string memory _emailAddress, string memory _role) private
    returns(uint)
    {
        // checking if the user is already registered
        uint userId = usersIds[_wAddr];
        require (userId == 0);

        // associating the user wallet address with the new ID
        usersIds[_wAddr] = userScores.length;
        uint newUserId = userScores.length++;

        // storing the new user details
        userScores[newUserId] = User({
        	walletAddress: _wAddr,
            name: _name,
            username: _username,
            course: _course,
            emailAddress: _emailAddress,
            role: _role,
        	createdAt: block.timestamp
        });

        // emitting the event that a new user has been registered
        emit newUserScoreAdded(newUserId);

        return newUserId;
    }

    /*function updateUserScore(string memory _newUserName) checkSenderIsRegistered public
    returns(uint)
    {
    	// An user can modify only his own profile.
    	uint userId = usersIds[msg.sender];

    	User storage user = userScores[userId];

    	user.name = _newUserName;
    	user.score = _newScore;
    	user.updatedAt = block.timestamp;

    	emit updateUserScoreEvent(userId);

    	return userId;
    }*/

    /**
     * Get the user's profile information.
     *
     * @param _id 	The ID of the user stored on the blockchain.
     */
    function getUserById(uint _id) public view
    returns(
    	uint,
        address,
    	string memory,
        string memory,
        string memory,
        string memory,
        string memory,
    	uint
    ) {
    	// checking if the ID is valid
    	require( (_id > 0) || (_id <= userScores.length) );

    	User memory i = userScores[_id];

    	return (
    		_id,
    		i.walletAddress,
            i.name,
            i.username,
            i.course,
            i.emailAddress,
            i.role,
    		i.createdAt
    	);
    }

    /**
     * Return the profile information of the caller.
     */
    function getOwnProfile() checkSenderIsRegistered public view
    returns(
    	uint,
        address,
    	string memory,
        string memory,
        string memory,
        string memory,
        string memory,
    	uint
    ) {
    	uint id = usersIds[msg.sender];

    	return getUserById(id);
    }

    /**
     * Check if the user that is calling the smart contract is registered.
     */
    function isRegistered() public view returns (bool)
    {
    	return (usersIds[msg.sender] > 0);
    }

	
    /**
     * Return the number of total registered users.
     */
    function totalUsers() public view returns (uint)
    {
        // NOTE: the total registered user is length-1 because the user with
        // index 0 is empty check the contructor: addUser(address(0x0), "", "");
        return userScores.length - 1;
    }
}