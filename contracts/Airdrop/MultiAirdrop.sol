// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "../interfaces/ICloseYourEyesV0.sol";

contract MultiAirdrop {
	ICloseYourEyesV0 public V0;
	address public owner;

	modifier onlyOwner() {
		require(msg.sender == owner);
		_;
	}

	constructor(ICloseYourEyesV0 _v0) {
		V0 = _v0;
		owner = msg.sender;
	}

	function listAirdrip(
		address from,
		address[] memory user,
		uint256[] memory tokenId
	) public onlyOwner {
		for (uint256 i = 0; i < user.length; i++) {
			address reciever = user[i];
			V0.transferFrom(from, reciever, tokenId[i]);
		}
	}
}
