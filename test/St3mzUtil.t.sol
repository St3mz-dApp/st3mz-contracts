// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

/* solhint-disable */
import { St3mzUtil } from "../src/St3mzUtil.sol";
import { St3mz } from "../src/St3mz.sol";
import { ISt3mz } from "../src/ISt3mz.sol";
import { Test } from "forge-std/Test.sol";

contract St3mzUtilTest is Test {
	address private alice = address(0x1);
	address private bob = address(0x2);
	St3mzUtil private st3mzUtil;
	St3mz private st3mz;

	function setUp() public {
		st3mz = new St3mz();
		st3mzUtil = new St3mzUtil(ISt3mz(address(st3mz)));
	}

	function test_st3mzAddress() public {
		assertEq(address(st3mzUtil.st3mz()), address(st3mz));
	}

	function test_getToken() public {
		vm.prank(alice);
		st3mz.mint("ipfs://0x1", 10, 5 ether);

		St3mzUtil.St3mzNft memory token = st3mzUtil.getToken(1);

		assertEq(token.id, 1);
		assertEq(token.uri, "ipfs://0x1");
		assertEq(token.minter, alice);
		assertEq(token.price, 5 ether);
		assertEq(token.supply, 10);
		assertEq(token.available, 10);
	}

	function mintTokens() private {
		vm.startPrank(alice);
		st3mz.mint("ipfs://0x1", 10, 5 ether);
		st3mz.mint("ipfs://0x2", 20, 10 ether);
		st3mz.mint("ipfs://0x3", 30, 15 ether);
		st3mz.mint("ipfs://0x4", 40, 20 ether);
		st3mz.mint("ipfs://0x5", 50, 25 ether);
		vm.stopPrank();
	}

	function test_getTokens() public {
		mintTokens();

		St3mzUtil.St3mzNft[] memory tokens = st3mzUtil.getTokens(5, 1, false);

		assertEq(tokens.length, 5);
		assertEq(tokens[0].id, 1);
		assertEq(tokens[0].uri, "ipfs://0x1");
		assertEq(tokens[0].minter, alice);
		assertEq(tokens[0].price, 5 ether);
		assertEq(tokens[0].supply, 10);
		assertEq(tokens[0].available, 10);
		assertEq(tokens[4].id, 5);
		assertEq(tokens[4].uri, "ipfs://0x5");
		assertEq(tokens[4].minter, alice);
		assertEq(tokens[4].price, 25 ether);
		assertEq(tokens[4].supply, 50);
		assertEq(tokens[4].available, 50);
	}

	function test_getTokensReverse() public {
		mintTokens();

		St3mzUtil.St3mzNft[] memory tokens = st3mzUtil.getTokens(5, 1, true);

		assertEq(tokens.length, 5);
		assertEq(tokens[4].id, 1);
		assertEq(tokens[4].uri, "ipfs://0x1");
		assertEq(tokens[4].minter, alice);
		assertEq(tokens[4].price, 5 ether);
		assertEq(tokens[4].supply, 10);
		assertEq(tokens[4].available, 10);
		assertEq(tokens[0].id, 5);
		assertEq(tokens[0].uri, "ipfs://0x5");
		assertEq(tokens[0].minter, alice);
		assertEq(tokens[0].price, 25 ether);
		assertEq(tokens[0].supply, 50);
		assertEq(tokens[0].available, 50);
	}

	function test_getTokensPageTwo() public {
		mintTokens();

		St3mzUtil.St3mzNft[] memory tokens = st3mzUtil.getTokens(3, 2, false);

		assertEq(tokens.length, 2);
		assertEq(tokens[0].id, 4);
		assertEq(tokens[0].uri, "ipfs://0x4");
		assertEq(tokens[0].minter, alice);
		assertEq(tokens[0].price, 20 ether);
		assertEq(tokens[0].supply, 40);
		assertEq(tokens[0].available, 40);
		assertEq(tokens[1].id, 5);
		assertEq(tokens[1].uri, "ipfs://0x5");
		assertEq(tokens[1].minter, alice);
		assertEq(tokens[1].price, 25 ether);
		assertEq(tokens[1].supply, 50);
		assertEq(tokens[1].available, 50);
	}

	function test_getTokensEmptyPage() public {
		vm.prank(alice);
		st3mz.mint("ipfs://0x1", 10, 5 ether);

		St3mzUtil.St3mzNft[] memory tokens = st3mzUtil.getTokens(1, 2, false);

		assertEq(tokens.length, 0);
	}
}
