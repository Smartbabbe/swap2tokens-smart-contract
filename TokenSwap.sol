// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenSwap {
    address public tokenFromAddress;
    address public tokenToAddress;

    event TokensSwapped(address indexed sender, uint256 amountFrom, uint256 amountTo);

    constructor(address _tokenFromAddress, address _tokenToAddress) {
        tokenFromAddress = _tokenFromAddress;
        tokenToAddress = _tokenToAddress;
    }

    function swapTokens(uint256 _amountFrom) external {
        require(_amountFrom > 0, "Amount must be greater than 0");
        require(hasApproved(msg.sender, _amountFrom), "User has not approved the contract to spend tokens");

        // Transfer tokens from the sender to the contract
        IERC20(tokenFromAddress).transferFrom(msg.sender, address(this), _amountFrom);

        // Perform token swap logic (custom logic depending on your requirements)

        // Transfer swapped tokens to the sender
        IERC20(tokenToAddress).transfer(msg.sender, _amountFrom);

        emit TokensSwapped(msg.sender, _amountFrom, _amountFrom);
    }

    function hasApproved(address _owner, uint256 _amount) public view returns (bool) {
        uint256 allowance = IERC20(tokenFromAddress).allowance(_owner, address(this));
        return allowance >= _amount;
    }
}