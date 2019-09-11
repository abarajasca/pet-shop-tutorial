pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol";

contract TestAdoption {
    // The address of the adoption contract to be tested
    Adoption adoption = Adoption(DeployedAddresses.Adoption());
    // id that will be used for test it
    uint expectedPetId = 8;
    // The expecte owner of the adopted pet in this contact
    address expectedAdopter = address(this);


    //Testing the adopt function
    function testUserCanAdoptPet() public {
        uint returnedId = adoption.adopt(expectedPetId);

        Assert.equal(returnedId,expectedPetId,"Adoption of the expected ped should match what is returned.");
    }

    // Testing retrieval of a single pet's owner
    function testGetAdopterAddressByPetId() public {
        address adopter = adoption.adopters(expectedPetId);

        Assert.equal(adopter,expectedAdopter,"Owner of the expected adopter should be this contract");
    }

    // Testing retrieval of all pet owners
    function testGetAdopterAddressByPedInArray() public {
        // store adopters in memory rather than contract's storage
        address[16] memory adopters = adoption.getAdopters();

        Assert.equal(adopters[expectedPetId],expectedAdopter,"Owner of the expected pet should be this contract.");
    }

    function testGiveInAdoption() public {
        address[16] memory adopters = adoption.getAdopters();
        // First adopt a pet.
        uint returnedId = adoption.adopt(expectedPetId);

        // Now give in adoption.
        returnedId = adoption.giveInAdoption(expectedPetId);

        // Assert results.
        Assert.equal(returnedId,expectedPetId,"Give in adoption of the expected ped should match what is returned.");
        Assert.equal(adopters[expectedPetId],address(0),"Pet must be available for adoption after give in Adoption.");
    }    
    
}


