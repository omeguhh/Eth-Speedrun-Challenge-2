pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {

  //event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

  YourToken public yourToken;
  uint256 public constant tokensPerEth = 100;

  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);


  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }

  function buyTokens() public payable {
    uint purchasedTokens = tokensPerEth * msg.value;
    yourToken.transfer(msg.sender, purchasedTokens);
    emit BuyTokens(msg.sender, msg.value, purchasedTokens);
  }
  // ToDo: create a payable buyTokens() function:

  // ToDo: create a withdraw() function that lets the owner withdraw ETH
  function withdraw() public onlyOwner {
    require(address(this).balance > 0);
    payable(msg.sender).transfer(address(this).balance);
  }

  // ToDo: create a sellTokens(uint256 _amount) function:
  function sellTokens(uint256 _amount) public {
    uint256 ethToTransfer = _amount / 100;
    yourToken.transferFrom(msg.sender, address(this), _amount);
    payable(msg.sender).transfer(ethToTransfer);
    
    }

}
