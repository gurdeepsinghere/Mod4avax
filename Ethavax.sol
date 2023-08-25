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
