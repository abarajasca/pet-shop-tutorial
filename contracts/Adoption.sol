pragma solidity ^0.5.0;

contract Adoption {
    address[16] public adopters;

    // Adoption a pet
    function adopt(uint petId) public returns (uint){
        require(petId >= 0 && petId <= 15,"Pet selected is not available");

        adopters[petId] = msg.sender;

        return petId;
    }

    // Retrieve the adopters
    function getAdopters() public view returns (address[16] memory) {
        return adopters;
    }

    // Enabled give in adoption
    function giveInAdoption(uint petId) public returns (uint){
        require(petId >= 0 && petId <= 15 && adopters[petId] != address(0),"Current pet is not in adoption");

        adopters[petId] = address(0);   // Release the adoption.

        return petId;
    }
}