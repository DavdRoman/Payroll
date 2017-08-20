pragma solidity ^0.4.11;

import '../Zeppelin/SafeMath.sol';
import '../Zeppelin/Ownable.sol';
import '../Tokens/IERC20Token.sol';
import './IExchange.sol';

contract USDExchange is Ownable, IExchange {
	address public exchangeRateOracle;
	mapping (address => uint) public exchangeRates; // 18 decimals

	function USDExchange(address usdExchangeRateOracle) {
		exchangeRateOracle = usdExchangeRateOracle;
	}

	function setExchangeRateOracle(address newOracle) onlyOwner {
		require(newOracle != 0x0);
		exchangeRateOracle = newOracle;
	}

	function peggedValue(address token, uint amount, uint rate) constant returns (uint) {
		if (amount == 0) return 0;
		require(token != 0x0);
		require(rate > 0);

		uint decimals = IERC20Token(token).decimals();
		return SafeMath.div(SafeMath.mul(amount, 10**decimals), rate);
	}

	// Oracle-only

	modifier onlyOracle() {
		require(msg.sender == exchangeRateOracle);
		_;
	}

	function setExchangeRate(address token, uint exchangeRate) onlyOracle {
		require(token != 0x0);
		exchangeRates[token] = exchangeRate;
	}
}
