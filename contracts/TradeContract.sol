pragma solidity >=0.4.21 <0.7.0;

import {Trade} from "./Trade.sol";
import {TradeEnums as E} from "../library/TradeEnums.sol";

contract TradeContract {

  address public owner;
  mapping (string => Trade.TradeState) openTrades;
  mapping (string => uint) balances;

  constructor() public {
    owner = msg.sender;
  }

  modifier restricted() {
    require((msg.sender == owner), "Sender is not owner");
    _;
  }

  modifier isValidAddress() {
    require((msg.sender != address(0)), "Sender address is invalid");
    _;
  }

  function registerTrade(string memory tradeId, uint amount) public returns (bool) {
    require(openTrades[tradeId].trade.owner == address(0), "TradeId already present");
    Trade.TradeStruct memory trade = Trade.TradeStruct(E.Status.INITIALIZED, amount, msg.sender);
    Trade.TradeState memory tradeState = Trade.TradeState(tradeId, trade, address(0));
    openTrades[tradeId] = tradeState;
    return true;
  }

  function takeTrade(string memory tradeId) public payable returns (bool) {
    require(balances[tradeId] == 0, "Balance of the trade was not 0");
    balances[tradeId] += msg.value; // Add transferred amount to balance
    if(openTrades[tradeId].trade.status == E.Status.INITIALIZED // Trade is not in status initialized
    && openTrades[tradeId].trade.owner != msg.sender // Cannot take own trade offer
    && openTrades[tradeId].trade.amount == msg.value){ // Transferred value does not match trade amount
      refund(msg.value, tradeId);
      return false;
    }
    openTrades[tradeId].taker = msg.sender;
    openTrades[tradeId].trade.status == E.Status.WAITING;
    return true;
  }

  function closeTrade(string memory tradeId) public returns (bool) {
    require(openTrades[tradeId].trade.owner == msg.sender, "Trade can only be closed by owner");
    require(openTrades[tradeId].trade.status == E.Status.INITIALIZED, "Trade must be in Status initialized");
    openTrades[tradeId].trade.status = E.Status.ABORTED;
    return true;
  }

  function refund(uint amountToRefund, string memory tradeId) private {
    require(amountToRefund > 0 && amountToRefund == balances[tradeId], "Refund balance not valid");
    msg.sender.transfer(amountToRefund); // Refund
    balances[tradeId] -= amountToRefund; // Remove transferred amount from balance
  }
}
