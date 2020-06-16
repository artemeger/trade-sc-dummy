pragma solidity >=0.4.21 <0.7.0;

import {TradeEnums as E} from "../library/TradeEnums.sol";

contract Trade {

    struct TradeStruct {
        E.Status status;
        uint amount;
        address owner;
    }

    struct TradeState {
        string id;
        TradeStruct trade;
        address taker;
    }
}
