//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

 ///@author tekh.eth
 ///@notice base camp exercise 
 ///@notice https://docs.base.org/base-camp/docs/mappings/mappings-exercise

contract FavoriteRecords {

    /*
    State Variables
    The contract should have the following state variables.
     It is up to you to decide if any supporting variables are useful.

    A public mapping approvedRecords, which returns true if an album name
     has been added as described below, and false if it has not

    A mapping called userFavorites that indexes user addresses to a 
    mapping of string record names which returns true or false, 
    depending if the user has marked that album as a favorite
    */

    mapping(address => mapping (string => bool)) public userFavorites;
    mapping(string => bool) public approvedRecords;
    string[] public albumIndex;
    uint public approvedAlbumCount; //+/- this when maintaining approved mapping;

    /*
    Loading Approved Albums
        Using the method of your choice, load approvedRecords with the following:

        Thriller
        Back in Black
        The Bodyguard
        The Dark Side of the Moon
        Their Greatest Hits (1971-1975)
        Hotel California
        Come On Over
        Rumours
        Saturday Night Fever
    */
    function loadApprovedAlbums(string[] memory _albums) internal {
        for(uint i = 0; i< _albums.length; ++i){
            approvedRecords[_albums[i]] = true;
            albumIndex.push(_albums[i]);
            ++approvedAlbumCount;
        }
    }

    constructor(string[] memory _albums){
        loadApprovedAlbums(_albums);
    }

    /*Add Record to Favorites
    Create a function called addRecord that accepts an album name as a parameter. 
    If the album is on the approved list, add it to the list under the address of the sender.
    Otherwise, reject it with a custom error of NotApproved with the submitted name as an argument.*/
    error NotApproved(string);

    function addRecord(string memory _album) public {
  
        if(approvedRecords[_album]){
            userFavorites[msg.sender][_album] = true;
        } else {
            revert NotApproved(_album);
        }
    }

    /*Get Approved Records 
    Add a function called getApprovedRecords. 
    This function should return a list of all of the names 
    currently indexed in approvedRecords.*/

    function getApprovedRecords() public view returns (string[] memory) {
        string[] memory approvedList = new string[](approvedAlbumCount);

        for(uint i = 0; i < albumIndex.length; i++) {
            if(approvedRecords[albumIndex[i]]){
                approvedList[i] = albumIndex[i];
            }
        }

        return approvedList;
    }

    /* Get Approved Record */
    function IsRecordApproved(string memory _album) public view returns (bool){
        return approvedRecords[_album];
    }

    /*Users' Lists 
    Write a function called getUserFavorites 
    that retrieves the list of favorites for any address.*/
    function getUserFavorites(address _address) public view returns (string[] memory){
        
        uint userFavCount;

        //using the approved list get the total favorites by the user
        for(uint i = 0; i < albumIndex.length; i++) {
            if(userFavorites[_address][albumIndex[i]]){
                ++userFavCount;
            }
        }

        //init an array with the size of the user favorite count and add favs
        string[] memory userFavs = new string[](userFavCount);
        userFavCount = 0;
        for(uint i = 0; i < albumIndex.length; i++) {
            if(userFavorites[_address][albumIndex[i]]){
                userFavs[userFavCount] = albumIndex[i];
                ++userFavCount;
            }
        }
        return userFavs;
    }
}