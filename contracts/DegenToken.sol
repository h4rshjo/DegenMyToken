// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

// DegenToken is an ERC20 token with minting, burning, and redeeming functionalities
contract DegenToken is ERC20, Ownable {
    using SafeMath for uint256;

    // Events for logging actions on the blockchain
    event TokensMinted(address indexed to, uint256 amount);
    event TokensBurned(address indexed from, uint256 amount);
    event TokensRedeemed(address indexed from, uint256 amount, uint256 gameItem);

    // Mapping to track redeemed items for each player
    mapping(address => mapping(uint256 => uint256)) public redeemedItems;

    // Constructor to initialize the token with name "Degen" and symbol "DGN"
    constructor() ERC20("Degen", "DGN") {}

    // Function to mint new tokens, callable only by the contract owner
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
        emit TokensMinted(to, amount); // Emit an event to log the minting action
    }

    // Function to burn tokens from the caller's account
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
        emit TokensBurned(msg.sender, amount); // Emit an event to log the burning action
    }

    // Function to redeem tokens for game items
    // `to` is the address to redeem tokens from
    // `amount` is the number of tokens to redeem
    // `gameItem` is the identifier for the game item being redeemed
    function redeem(address to, uint256 amount, uint256 gameItem) public {
        // Ensure the amount to redeem does not exceed the balance
        require(amount <= balanceOf(to), "Amount exceeds balance");

        // Redeem the tokens for the specified game item
        if (gameItem == 1) {
            // Check if enough tokens for Game Item 1
            require(amount >= 50, "Insufficient tokens for Game Item 1");
            _burn(to, amount);
            redeemedItems[to][1] = redeemedItems[to][1].add(1); // Increment the count of Game Item 1
        } else if (gameItem == 2) {
            // Check if enough tokens for Game Item 2
            require(amount >= 100, "Insufficient tokens for Game Item 2");
            _burn(to, amount);
            redeemedItems[to][2] = redeemedItems[to][2].add(1); // Increment the count of Game Item 2
        } else if (gameItem == 3) {
            // Check if enough tokens for Game Item 3
            require(amount >= 200, "Insufficient tokens for Game Item 3");
            _burn(to, amount);
            redeemedItems[to][3] = redeemedItems[to][3].add(1); // Increment the count of Game Item 3
        } else {
            // Invalid game item
            revert("Invalid game item");
        }

        emit TokensRedeemed(to, amount, gameItem); // Emit an event to log the redeem action
    }

    // Function to transfer tokens from the caller's account to another account
    function transferTokens(address to, uint256 amount) public {
        transfer(to, amount);
    }

    // Function to check the balance of a specific account
    function checkBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }
}
