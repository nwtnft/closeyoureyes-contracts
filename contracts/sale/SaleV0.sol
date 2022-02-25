// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "../openzeppelin/contracts/utils/Context.sol";
import "../openzeppelin/contracts/utils/math/SafeMath.sol";
import "../openzeppelin/contracts/utils/Counters.sol";
import "../interfaces/ICloseYourEyesV0.sol";

contract SaleV0 is Context {
	using SafeMath for uint256;
	using Counters for Counters.Counter;

	ICloseYourEyesV0 public CloseYourEyesV0;

	Counters.Counter internal sale1Tracker;
	Counters.Counter internal sale2Tracker;
	Counters.Counter internal whiteListTracker;

	uint256 public constant MAX_NFT_SUPPLY = 8888;
	uint256 public SALE1_MAX_SUPPLY = 1500;
	uint256 public SALE2_MAX_SUPPLY = 5000;

	uint256 public MAX_MINT_AMOUNT1 = 2;
	uint256 public MAX_MINT_AMOUNT2 = 3;

	uint256 public salePrice1 = 200 ether;
	uint256 public salePrice2 = 300 ether;

	bool public isSale1 = false;
	bool public isSale2 = false;

	address public C1;
	address public C2;
	address public C3;
	address public C4;
	address public devAddress;

	mapping(address => bool) public whiteList;
	mapping(address => uint256) public publicSaleBlockTracker;
	
	modifier saleRole(uint256 numberOfTokens, bool thisIsSale, Counters.Counter storage thisTracker, uint256 thisMaxSupply, uint256 thisSaleAmount, uint256 thisSalePrice) {
		require(thisIsSale, "Sale Not start");
		require(CloseYourEyesV0.totalSupply() < MAX_NFT_SUPPLY, "Total Sale has already ended");
		require(CloseYourEyesV0.totalSupply().add(numberOfTokens) <= MAX_NFT_SUPPLY, "Total Purchase would exceed max supply of NFT");
		require(thisTracker.current() < thisMaxSupply, "Sale has already ended");
		require(thisTracker.current().add(numberOfTokens) <= thisMaxSupply, "Purchase would exceed max supply of NFT 2");
		require(numberOfTokens <= thisSaleAmount, "overfolow mint amount");
		require(thisSalePrice.mul(numberOfTokens) <= msg.value, "Eth value sent is not correct");
		_;
	}

	modifier whiteListRole() {
		require(whiteList[_msgSender()], "This address is not on the whitelist");
		_;
	}

	modifier publicSaleRole() {
		require(publicSaleBlockTracker[_msgSender()].add(5) < block.number, "You can mint every 5 blocks.");
		_;
	}

	modifier onlyDev() {
		require(devAddress == _msgSender(), "only dev: caller is not the dev");
		_;
	}

	/*
    C1: Artist, C2: Developer, C3: CampJackson, C4: Team
  */

	constructor(
		address _NFT,
		address _C1,
		address _C2,
		address _C3,
		address _C4,
		address _dev
	) {
		CloseYourEyesV0 = ICloseYourEyesV0(_NFT);
		C1 = _C1;
		C2 = _C2;
		C3 = _C3;
		C4 = _C4;
		devAddress = _dev;
	}

	function sale1(uint256 numberOfTokens) public payable whiteListRole saleRole(numberOfTokens, isSale1, sale1Tracker, SALE1_MAX_SUPPLY, MAX_MINT_AMOUNT1, salePrice1) {
		for (uint256 i = 0; i < numberOfTokens; i++) {
			CloseYourEyesV0.mint(_msgSender());
			sale1Tracker.increment();
		}
		whiteList[_msgSender()] = false;
	}

	function sale2(uint256 numberOfTokens) public payable publicSaleRole saleRole(numberOfTokens, isSale2, sale2Tracker, SALE2_MAX_SUPPLY, MAX_MINT_AMOUNT2, salePrice2) {
		for (uint256 i = 0; i < numberOfTokens; i++) {
			CloseYourEyesV0.mint(_msgSender());
			sale2Tracker.increment();
		}
		publicSaleBlockTracker[_msgSender()] = block.number;
	}

	function resetTracker1() public onlyDev {
		sale1Tracker.reset();
	}

	function setIsSale1() public onlyDev {
		isSale1 = !isSale1;
	}

	function setIsSale2() public onlyDev {
		isSale2 = !isSale2;
	}

	function setSale2MaxSupply(uint256 supply) public onlyDev {
		SALE2_MAX_SUPPLY = supply;
	}

	function setWhiteList(address[] memory wl) public onlyDev {
		for (uint256 i = 0; i < wl.length; i++) {
			whiteList[wl[i]] = true;
			whiteListTracker.increment();
		}
	}

	function deleteWhiteList(address[] memory wl) public onlyDev {
		for (uint256 i = 0; i < wl.length; i++) {
			whiteList[wl[i]] = false;
			whiteListTracker.decrement();
		}
	}

	function withdraw() public payable onlyDev {
		uint256 contractBalance = address(this).balance;
		uint256 percentage = contractBalance.div(100);

		require(payable(C1).send(percentage.mul(50)));
		require(payable(C2).send(percentage.mul(18)));
		require(payable(C3).send(percentage.mul(7)));
		require(payable(C4).send(percentage.mul(25)));
	}

	function setDev(address changeAddress) public onlyDev {
		devAddress = changeAddress;
	}

	function getWhiteListLength() public view returns(uint256) {
		return whiteListTracker.current();
	}

	function getTracker1Length() public view returns(uint256) {
		return sale1Tracker.current();
	}

	function getTracker2Length() public view returns(uint256) {
		return sale2Tracker.current();
	}
}
