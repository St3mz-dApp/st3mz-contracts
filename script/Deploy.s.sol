// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

/* solhint-disable */
import { St3mz } from "../src/St3mz.sol";
import { St3mzUtil } from "../src/St3mzUtil.sol";
import { ISt3mz } from "../src/ISt3mz.sol";
import "forge-std/Script.sol";

contract Deploy is Script {
	function run() public {
		vm.startBroadcast();
		St3mz st3mz = new St3mz();
		new St3mzUtil(ISt3mz(address(st3mz)));
		vm.stopBroadcast();
	}
}
