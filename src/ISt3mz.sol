// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title ISt3mz
 * @notice Interface for St3mz contract.
 */
interface ISt3mz {
	function name() external view returns (string memory);

	function symbol() external view returns (string memory);

	function minter(uint256 id) external view returns (address);

	function price(uint256 id_) external view returns (uint256);

	function supply(uint256 id_) external view returns (uint256);

	function available(uint256 id_) external view returns (uint256);

	function balanceOf(address account_, uint256 id_)
		external
		view
		returns (uint256);

	function withdrawableBalance(address account)
		external
		view
		returns (uint256);

	function uri(uint256 id_) external view returns (string memory);

	function totalTokens() external view returns (uint256);

	function supportsInterface(bytes4 interfaceId_)
		external
		pure
		returns (bool);

	function mint(
		string calldata uri_,
		uint256 amount_,
		uint256 price_
	) external;

	function buy(uint256 id, uint256 amount_) external payable;

	function withdraw() external;
}
