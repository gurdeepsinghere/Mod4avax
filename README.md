# DEGEN Token Smart Contract

This is a blockchain project made with Solidity on the Avalanche Network. This program creates an ERC20 Token that can be minted by the owner and transferred. The tokens can be used to redeem NFTs on the network 
## Description

Eth-Avax Int Module 4: In this module, I have created a game token named as Degen tokens which can be minted only by the owner of the contract and users would be able to burn, transfer and also redeem the token to purchase some in game items. The contract has been tested and deployed using Avalanche Fugi C chain testnet and in Remix IDE. All the functionalities of the contract has been explained in this Loom video.

## code
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; 

contract Degenvotingcontract {

    uint256 public totalSupplyofvotes;
    address public voter;
    string public name = "contributer";
    string public symbol = "CONT";

    constructor() {
        voter = msg.sender;
    }

    mapping(address => uint256) public votesinmachine;

    // Minting votes function
    function mint(address to, uint256 votes) public {
        require(msg.sender == voter, "Only the voter can mint token of votes.");
        require(votes > 0, "votes must be greater than 0.");

        votesinmachine[to] += votes;
        totalSupplyofvotes += votes;
    }

    // Burning votes function
    function burn(address from, uint256 votes) public {
        require(votes <=  votesinmachine[from], "Votes exceeds the existing votes in machine.");

        votesinmachine[from] -= votes;
        totalSupplyofvotes -= votes;
    }

    // Transfering vote function
    function transfer(address to, uint256 votes) public {
        require(votes <=  votesinmachine[msg.sender], "Votes exceeds the existing votes in machine.");
        require(to != address(0), "Cannot transfer votes to the zero address.");

         votesinmachine[msg.sender] -= votes;
         votesinmachine[to] += votes;
    }

    // Redeeming vote function
    function redeem(address to, uint256 votes, uint256 VoteRewardLevel) public { 
        require(votes <=  votesinmachine[to], "Votes exceeds the existing votes in machine.");

        if (VoteRewardLevel == 1) {
            require(votes >= 20 , "Insufficient token votes for Reward Level 1");
            burn(to, votes);
        } else if (VoteRewardLevel == 2) {
            require(votes >= 80 , "Insufficient token votes for Reward Level 2");
            burn(to, votes);
        } else if (VoteRewardLevel == 3) {
            require(votes >= 140 , "Insufficient token votes for Reward Level 3");
            burn(to, votes);
        } else {
            revert("Invalid Reward Level");
        }
    } 
}



## Authors
Gurdeep Singh  
