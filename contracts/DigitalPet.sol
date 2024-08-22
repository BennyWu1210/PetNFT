// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract DigitalPet is ERC721, Ownable {
    uint256 private _tokenIds; // Manual counter

    struct Pet {
        string name;
        uint256 level;
        uint256 experience;
        uint256 hunger;
    }

    mapping(uint256 => Pet) public pets;

    constructor() ERC721("DigitalPet", "DPET") Ownable(msg.sender) {
        _tokenIds = 0; // Initialize the counter
    }

    function createPet(string memory name) public returns (uint256) {
        _tokenIds += 1; // Manually increment the counter
        uint256 newPetId = _tokenIds;
        _mint(msg.sender, newPetId);

        Pet memory newPet = Pet({
            name: name,
            level: 1,
            experience: 0,
            hunger: 100 // Hunger starts full (100%)
        });

        pets[newPetId] = newPet;

        return newPetId;
    }

    function feedPet(uint256 petId) public {
        require(ownerOf(petId) == msg.sender, "You are not the owner of this pet.");
        Pet storage pet = pets[petId];
        require(pet.hunger < 100, "Pet is already fully fed.");
        pet.hunger = 100; // Reset hunger to full
        pet.experience += 10; // Increase experience

        if (pet.experience >= pet.level * 100) {
            pet.level += 1; // Level up the pet
            pet.experience = 0; // Reset experience after leveling up
        }
    }

    function getPetDetails(uint256 petId) public view returns (string memory name, uint256 level, uint256 experience, uint256 hunger) {
        Pet memory pet = pets[petId];
        return (pet.name, pet.level, pet.experience, pet.hunger);
    }
}