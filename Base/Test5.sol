// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
* @title FavoriteRecords
* @dev Contract to manage a list of approved music records and allow users to add them to their favorites
*/
contract FavoriteRecords {

mapping(string => bool) private approvedRecords;
string[] private approvedRecordsIndex;

mapping(address => mapping(string => bool)) public userFavorites;
mapping(address => string[]) private userFavoritesIndex;

error NotApproved(string albumName);

/**
* @dev Constructor that initializes the approved records list
*/
constructor() {
approvedRecordsIndex = ["Thriller","Back in Black","The Bodyguard","The Dark Side of the Moon","Their Greatest Hits (1971-1975)","Hotel California","Come On Over","Rumours","Saturday Night Fever"];
for (uint i = 0; i < approvedRecordsIndex.length; i++)
{
approvedRecords[approvedRecordsIndex[i]] = true;
}
}

/**
* @dev Returns the list of approved records
* @return An array of approved record names
*/
function getApprovedRecords() public view returns (string[] memory) {
return approvedRecordsIndex;
}

/**
* @dev Adds an approved record to the user's favorites
* @param _albumName The name of the album to be added
*/
function addRecord(string memory _albumName) public {
if (!approvedRecords[_albumName]) {
revert NotApproved({albumName: _albumName});
}
if (!userFavorites[msg.sender][_albumName]) {
userFavorites[msg.sender][_albumName] = true;
userFavoritesIndex[msg.sender].push(_albumName);
}
}

/**
* @dev Returns the list of a user's favorite records
* @param _address The address of the user
* @return An array of user's favorite record names
*/
function getUserFavorites(address _address) public view returns (string[] memory) {
return userFavoritesIndex[_address];
}

/**
* @dev Resets the caller's list of favorite records
*/
function resetUserFavorites() public {
for (uint i = 0; i < userFavoritesIndex[msg.sender].length; i++) {
delete userFavorites[msg.sender][userFavoritesIndex[msg.sender][i]];
}
delete userFavoritesIndex[msg.sender];
}
}