# DegenToken

DegenToken is an ERC20 token smart contract deployed on the Avalanche blockchain. This contract includes functionalities for minting, burning, transferring, and redeeming tokens for in-game items. The contract is designed to be used in gaming applications to enhance player engagement and reward loyalty.

## Description

This Solidity contract defines a custom ERC20 token named "Degen" with the symbol "DGN". The contract includes:
- Minting tokens by the owner
- Burning tokens by any token holder
- Redeeming tokens for specific in-game items
- Transferring tokens between accounts
- Checking token balances

## Getting Started

### Prerequisites

To interact with this smart contract, you will need:
- MetaMask wallet with some AVAX tokens for gas fees
- Remix IDE, an online Solidity IDE

### Executing Program

#### Compile the Contract

1. Open [Remix](https://remix.ethereum.org/).
2. Create a new file named `DegenToken.sol` and paste the following code into the file:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract DegenToken is ERC20, Ownable {
    using SafeMath for uint256;

    event TokensMinted(address indexed to, uint256 amount);
    event TokensBurned(address indexed from, uint256 amount);
    event TokensRedeemed(address indexed from, uint256 amount, uint256 gameItem);

    constructor() ERC20("Degen", "DGN") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
        emit TokensMinted(to, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
        emit TokensBurned(msg.sender, amount);
    }

    function redeem(address to, uint256 amount, uint256 gameItem) public {
        // Ensure the amount to redeem does not exceed the balance
        require(amount <= balanceOf(to), "Amount exceeds balance");

        // Redeem the tokens for the specified game item
        if (gameItem == 1) {
            // Check if enough tokens for Game Item 1
            require(amount >= 50, "Insufficient tokens for Game Item 1");
            _burn(to, amount);
        } else if (gameItem == 2) {
            // Check if enough tokens for Game Item 2
            require(amount >= 100, "Insufficient tokens for Game Item 2");
            _burn(to, amount);
        } else if (gameItem == 3) {
            // Check if enough tokens for Game Item 3
            require(amount >= 200, "Insufficient tokens for Game Item 3");
            _burn(to, amount);
        } else {
            // Invalid game item
            revert("Invalid game item");
        }

        emit TokensRedeemed(to, amount, gameItem);
    }

    function transferTokens(address to, uint256 amount) public {
        transfer(to, amount);
    }

    function checkBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }
}
```
3. In Remix, navigate to the "Solidity Compiler" tab on the left sidebar.
4. Ensure the compiler version is set to 0.8.18.
5. Click the "Compile DegenToken.sol" button.
6. Deploy the Contract
7 Switch to the "Deploy & Run Transactions" tab on the left sidebar.
8. Set the environment to "Injected Web3" to connect to your MetaMask wallet.
9. Ensure your MetaMask wallet is connected to the Avalanche Fuji Testnet.
10. Select the DegenToken contract from the dropdown menu.
11. Click the "Deploy" button.
12. Confirm the transaction in MetaMask.

## Interacting with the Contract
Once the contract is deployed, you can interact with it directly in Remix:

1. Mint Tokens:
-Call the 'mint' function with the address and amount of tokens to mint.
2. Burn Tokens:
-Call the 'burn' function with the amount of tokens to burn from your account.
3. Redeem Tokens:
-Call the 'redeem' function with the address, amount of tokens, and game item identifier to redeem tokens for an in-game item.
4. Transfer Tokens:
-Call the 'transferTokens' function with the recipient's address and amount of tokens to transfer.
5. Check Balance:
-Call the 'checkBalance' function with the account address to check the token balance.

