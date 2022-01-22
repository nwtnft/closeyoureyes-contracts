// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "../openzeppelin/contracts/utils/Context.sol";
import "../openzeppelin/contracts/utils/math/SafeMath.sol";
import "../openzeppelin/contracts/utils/Counters.sol";
import "../interfaces/ICloseYourEyesV0.sol";

contract SaleV1 is Context {
	using SafeMath for uint256;
	using Counters for Counters.Counter;

	ICloseYourEyesV0 public CloseYourEyesV0;
	uint256 public publicSalePrice;

	Counters.Counter public publicSaleP1IdTracker;
	Counters.Counter public publicSaleP2IdTracker;
	Counters.Counter public publicSaleP3IdTracker;

	uint256 public constant MAX_PUBLIC_SALE_P1_SUPPLY = 1000;
	uint256 public constant MAX_PUBLIC_SALE_P2_SUPPLY = 2000;
	uint256 public constant MAX_PUBLIC_SALE_P3_SUPPLY = 5000;
	uint256 public constant MAX_NFT_SUPPLY = 8888;

	uint256 public constant MAX_PUBLICSALE_AMOUNT = 30;

	bool public isPublicSaleP1 = false;
	bool public isPublicSaleP2 = false;
	bool public isPublicSaleP3 = false;

	address public C1;
	address public C2;
	address public C3;
	address public C4;
	address public devAddress;

	mapping(address => bool) public freeSaleBuyerList;

	modifier publicSaleP1Role(uint256 numberOfTokens) {
		require(isPublicSaleP1, "The sale has not started.");
		require(CloseYourEyesV0.totalSupply() < MAX_NFT_SUPPLY, "Sale has already ended.");
		require(publicSaleP1IdTracker.current() < MAX_PUBLIC_SALE_P1_SUPPLY, "Sale has already ended.");
		require(publicSaleP1IdTracker.current().add(numberOfTokens) <= MAX_PUBLIC_SALE_P1_SUPPLY, "Purchase would exceed max supply of NFT");
		require(numberOfTokens <= MAX_PUBLICSALE_AMOUNT, "Can only mint 30 NFT at a time");
		require(publicSalePrice.mul(numberOfTokens) <= msg.value, "Eth value sent is not correct");
		_;
	}

	modifier publicSaleP2Role(uint256 numberOfTokens) {
		require(isPublicSaleP2, "The sale has not started.");
		require(CloseYourEyesV0.totalSupply() < MAX_NFT_SUPPLY, "Sale has already ended.");
		require(publicSaleP2IdTracker.current() < MAX_PUBLIC_SALE_P2_SUPPLY, "Sale has already ended.");
		require(publicSaleP2IdTracker.current().add(numberOfTokens) <= MAX_PUBLIC_SALE_P2_SUPPLY, "Purchase would exceed max supply of NFT");
		require(numberOfTokens <= MAX_PUBLICSALE_AMOUNT, "Can only mint 30 NFT at a time");
		require(publicSalePrice.mul(numberOfTokens) <= msg.value, "Eth value sent is not correct");
		_;
	}

	modifier publicSaleP3Role(uint256 numberOfTokens) {
		require(isPublicSaleP3, "The sale has not started.");
		require(CloseYourEyesV0.totalSupply() < MAX_NFT_SUPPLY, "Sale has already ended.");
		require(publicSaleP3IdTracker.current() < MAX_PUBLIC_SALE_P3_SUPPLY, "Sale has already ended.");
		require(publicSaleP3IdTracker.current().add(numberOfTokens) <= MAX_PUBLIC_SALE_P3_SUPPLY, "Purchase would exceed max supply of NFT");
		require(numberOfTokens <= MAX_PUBLICSALE_AMOUNT, "Can only mint 30 NFT at a time");
		require(publicSalePrice.mul(numberOfTokens) <= msg.value, "Eth value sent is not correct");
		_;
	}

	/*
    C1: Artist, C2: Developer, C3: CampJackson, C4: Team
  */
	modifier onlyCreator() {
		require(C1 == _msgSender() || C2 == _msgSender() || C3 == _msgSender() || C4 == _msgSender() || devAddress == _msgSender(), "onlyCreator: caller is not the creator");
		_;
	}

	modifier onlyC1() {
		require(C1 == _msgSender(), "only C1: caller is not the C1");
		_;
	}

	modifier onlyC2() {
		require(C2 == _msgSender(), "only C2: caller is not the C2");
		_;
	}

	modifier onlyC3() {
		require(C3 == _msgSender(), "only C3: caller is not the C3");
		_;
	}

	modifier onlyC4() {
		require(C4 == _msgSender(), "only C4: caller is not the C4");
		_;
	}

	modifier onlyDev() {
		require(devAddress == _msgSender(), "only dev: caller is not the dev");
		_;
	}

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
		setPublicSalePrice(150000000000000000000); // 150 klay
	}

	function preMint(uint256 numberOfTokens, address receiver) public onlyDev {
		for (uint256 i = 0; i < numberOfTokens; i++) {
			if (CloseYourEyesV0.totalSupply() < MAX_NFT_SUPPLY) {
				CloseYourEyesV0.mint(receiver);
			}
		}
	}

	function publicSaleP1(uint256 numberOfTokens) public payable publicSaleP1Role(numberOfTokens) {
		for (uint256 i = 0; i <  numberOfTokens; i++) {
			CloseYourEyesV0.mint(_msgSender());
			publicSaleP1IdTracker.increment();
		}
	}

	function publicSaleP2(uint256 numberOfTokens) public payable publicSaleP2Role(numberOfTokens) {
		for (uint256 i = 0; i < numberOfTokens; i++) {
			CloseYourEyesV0.mint(_msgSender());
			publicSaleP2IdTracker.increment();
		}
	}

	function publicSaleP3(uint256 numberOfTokens) public payable publicSaleP3Role(numberOfTokens) {
		for (uint256 i = 0; i < numberOfTokens; i++) {
			CloseYourEyesV0.mint(_msgSender());
			publicSaleP3IdTracker.increment();
		}
	}

	function withdraw() public payable onlyCreator {
		uint256 contractBalance = address(this).balance;
		uint256 percentage = contractBalance.div(100);

		require(payable(C1).send(percentage.mul(50)));
		require(payable(C2).send(percentage.mul(18)));
		require(payable(C3).send(percentage.mul(7)));
		require(payable(C4).send(percentage.mul(25)));
	}

	function setC1(address changeAddress) public onlyC1 {
		C1 = changeAddress;
	}

	function setC2(address changeAddress) public onlyC2 {
		C2 = changeAddress;
	}

	function setC3(address changeAddress) public onlyC3 {
		C3 = changeAddress;
	}

	function setC4(address changeAddress) public onlyC4 {
		C4 = changeAddress;
	}

	function setDev(address changeAddress) public onlyDev {
		devAddress = changeAddress;
	}

	function setPublicSaleP1() public onlyDev {
		isPublicSaleP1 = !isPublicSaleP1;
	}

  function setPublicSaleP2() public onlyDev {
		isPublicSaleP2 = !isPublicSaleP2;
	}

  function setPublicSaleP3() public onlyDev {
		isPublicSaleP3 = !isPublicSaleP3;
	}

	function setPublicSalePrice(uint256 price) public onlyDev {
		publicSalePrice = price;
	}
}
