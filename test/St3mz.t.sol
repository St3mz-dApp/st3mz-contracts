// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

/* solhint-disable */
import { St3mz } from "../src/St3mz.sol";
import { Test } from "forge-std/Test.sol";

contract St3mzTest is Test {
	address private alice = address(0x1);
	address private bob = address(0x2);
	St3mz private st3mz;

	function setUp() public {
		st3mz = new St3mz();
	}

	function test_contractData() public {
		assertEq(st3mz.name(), "St3mz NFT");
		assertEq(st3mz.symbol(), "ST3MZ");
		assert(st3mz.supportsInterface(0x01ffc9a7));
	}

	function test_mint() public {
		assertEq(st3mz.totalTokens(), 0);

		vm.prank(alice);
		st3mz.mint("ipfs://0x1", 10, 5 ether);

		assertEq(st3mz.totalTokens(), 1);
		assertEq(st3mz.uri(1), "ipfs://0x1");
		assertEq(st3mz.minter(1), alice);
		assertEq(st3mz.price(1), 5 ether);
		assertEq(st3mz.supply(1), 10);
		assertEq(st3mz.available(1), 10);
	}

	function test_buy() public {
		vm.prank(alice);
		st3mz.mint("ipfs://0x1", 10, 5 ether);
		vm.deal(alice, 100 ether);
		uint256 aliceInitialBalance = alice.balance;

		assertEq(st3mz.available(1), 10);
		assertEq(st3mz.balanceOf(address(bob), 1), 0);

		vm.deal(bob, 50 ether);
		uint256 bobInitialBalance = bob.balance;
		vm.prank(bob);
		st3mz.buy{ value: 15 ether }(1, 3);

		assertEq(st3mz.available(1), 7);
		assertEq(st3mz.balanceOf(address(bob), 1), 3);
		assertEq(bob.balance, bobInitialBalance - 15 ether);
		assertEq(alice.balance, aliceInitialBalance + 15 ether);
	}
}
