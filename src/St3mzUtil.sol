// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import { ISt3mz } from "./ISt3mz.sol";

/**
 * @title St3mzUtil
 * @notice Utility for retrieving data from St3mz contract.
 */
contract St3mzUtil {
	struct St3mzNft {
		uint256 id;
		address minter;
		string uri;
		uint256 supply;
		uint256 price;
		uint256 available;
	}

	ISt3mz public immutable st3mz;

	constructor(ISt3mz st3mz_) {
		st3mz = st3mz_;
	}

	function getTokens(
		uint256 pageSize,
		uint256 pageNum,
		bool reverse
	) external view returns (St3mzNft[] memory) {
		uint256 totalTokens = st3mz.totalTokens();
		uint256 start = --pageNum * pageSize;
		uint256 end = start + pageSize;
		if (end > totalTokens) {
			end = totalTokens;
		}
		if (end <= start) {
			return new St3mzNft[](0);
		}
		St3mzNft[] memory nfts = new St3mzNft[](end - start);
		for (uint256 i = start; i < end; i++) {
			uint256 id = reverse ? totalTokens - i : i + 1;
			nfts[i - start] = getToken(id);
		}
		return nfts;
	}

	function getToken(uint256 id) public view returns (St3mzNft memory) {
		return
			St3mzNft({
				id: id,
				minter: st3mz.minter(id),
				uri: st3mz.uri(id),
				supply: st3mz.supply(id),
				price: st3mz.price(id),
				available: st3mz.available(id)
			});
	}
}
