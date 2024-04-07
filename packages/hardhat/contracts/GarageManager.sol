
//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/// ASCII art ///

//******////* Order of Layout *************/
//----------------------------------------//
//**////** Contract elements **************/
//----------------------------------------//
//***************/// Pragmas ///***********/
/// ASCII art /// is permitted ************/
//******* in the space between ************/
//**************the end of the ************/
//*************Pragmas and the ************/
//************beginning of the ************/
//*********************imports.************/
//***************/// Imports ///***********/
//***************/// Events ///************/
//***************/// Errors ///************/
//***************/// Interfaces ///********/
//***************/// Libraries ///*********/
//***************/// Contracts ///*********/
//----------------------------------------//
//**////** Inside each contract ***********/
//----------------------------------------//
//***************///- Type declarations -///
//***************///- State variables -///*/
//***************///- Events -///**********/
//***************///- Errors -///**********/
//***************///- Modifiers -///*******/
//***************///- Functions -///*******/
//******////*** Order of Functions <<<*****/
//**********>>> constructor        <<<*****/
//**********>>> receive function   <<<*****/
//**********>>> fallback function  <<<*****/
//**********>>> external           <<<*****/
//**********>>> public             <<<*****/
//**********>>> internal           <<<*****/
//**********>>> private            <<<*****/
///*********>>>********************<<<*****/

/// @author: tekh.eth
///
/// @notice: https://docs.base.org/base-camp/docs/structs/structs-exercise
/// @notice: https://github.com/OwlWilderness/scaffold-base/tree/GarageManager

/// Imports ///
/// Events ///
/// Errors ///

/// Contracts ///
contract GarageManager {

///- State variables -///
    string public Name = "GarageManager";
    string public Symbol = "GM";

    struct car {
        string make;
        string model;
        string color;
        uint numberOfDoors;
    }

    mapping(address => car[]) garage;

///- Events -///
///- Errors -///
///- Modifiers -///
///- Functions -///

}