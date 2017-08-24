pragma solidity ^0.4.11;

/*import './IPersonnel.sol';*/

contract IPersonnel {
	// Company-only
	function addEmployee(address accountAddress, uint initialYearlyUSDSalary);
	function setEmployeeSalary(uint employeeId, uint newYearlyUSDSalary);
	function resetEmployeeLatestTokenAllocation(uint employeeId);
	function removeEmployee(uint employeeId);
	function getEmployeeCount() constant returns (uint);
	function getEmployeeId(address employeeAddress) constant returns (uint);
	function getEmployee(uint employeeId) constant returns (
		address accountAddress,
		address[] allocatedTokens,
		address[] peggedTokens,
		uint latestTokenAllocation,
		uint latestPayday,
		uint yearlyUSDSalary
	);

	// Employee-only
	function determineAllocation(address[] tokens, uint[] distribution);
	function getAllocatedTokensCount() constant returns (uint);
	function getPeggedTokensCount() constant returns (uint);
	function getTokenAllocation(address tokenAddress) constant returns (uint);
	function getTokenPegging(address tokenAddress) constant returns (uint);
}