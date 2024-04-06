//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

 ///@author tekh.eth
 ///@notice base camp exercise 
 ///@notice https://docs.base.org/base-camp/docs/mappings/mappings-exercise


contract FavoriteRecords {

    mapping(address => mapping (string => bool)) public userFavorites;
    mapping(string => bool) public approvedRecords;
    string[] public albumIndex;
    uint public approvedAlbumCount; //+/- this when maintaining approved mapping;
    error NotApproved(string);
    constructor(string[] memory _albums){
        loadApprovedAlbums(_albums);
    }

    //Reset User Favorites
    function resetUserFavorites() public {
        //using the approved list get the total favorites by the user
        for(uint i = 0; i < albumIndex.length; i++) {
            if(userFavorites[msg.sender][albumIndex[i]]){
                userFavorites[msg.sender][albumIndex[i]] = false;
            }   
        }
    }

    //Add Record to User Favorite List
    function addRecord(string memory _album) public {
  
        if(approvedRecords[_album]){
            userFavorites[msg.sender][_album] = true;
        } else {
            revert NotApproved(_album);
        }
    }

    //Get Approved Records
    function getApprovedRecords() public view returns (string[] memory) {
        string[] memory approvedList = new string[](approvedAlbumCount);

        for(uint i = 0; i < albumIndex.length; i++) {
            if(approvedRecords[albumIndex[i]]){
                approvedList[i] = albumIndex[i];
            }
        }

        return approvedList;
    }

    //Get Approved Record 
    function IsRecordApproved(string memory _album) public view returns (bool){
        return approvedRecords[_album];
    }

    //Returns User Favorites
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

    //Load Approved Albums
    function loadApprovedAlbums(string[] memory _albums) private {
        for(uint i = 0; i< _albums.length; ++i){
            approvedRecords[_albums[i]] = true;
            albumIndex.push(_albums[i]);
            ++approvedAlbumCount;
        }
    }
}