// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "../openzeppelin/contracts/utils/Context.sol";
import "../openzeppelin/contracts/utils/math/SafeMath.sol";
import "../openzeppelin/contracts/utils/Counters.sol";
import "../fatty-chuchucat/IFattyChuchucat.sol";

contract SaleV1 is Context {
	using SafeMath for uint256;
	using Counters for Counters.Counter;

	IFattyChuchucat public FattyChuchucatContract;
	uint256 public publicSalePrice;

	Counters.Counter private _freeSaleIdTracker;
	Counters.Counter private _publicSaleP1IdTracker;
	Counters.Counter private _publicSaleP2IdTracker;
	Counters.Counter private _publicSaleP3IdTracker;
	Counters.Counter private _privateSaleIdTracker;

	uint256 public constant MAX_FREE_SALE_SUPPLY = 7375;
	uint256 public constant MAX_PUBLIC_SALE_P1_SUPPLY = 500;
	uint256 public constant MAX_PUBLIC_SALE_P2_SUPPLY = 1000;
	uint256 public constant MAX_PUBLIC_SALE_P3_SUPPLY = 1000;
	uint256 public constant MAX_PRIVATE_SALE_SUPPLY = 125;
	uint256 public constant MAX_TOKEN_SUPPLY = 10000;

	uint256 public constant MIDDLE_VAL_1 = 7875;
	uint256 public constant MIDDLE_VAL_2 = 8875;
	uint256 public constant MIDDLE_VAL_3 = 9875;

	uint256 public constant MAX_PUBLICSALE_AMOUNT = 20;

	bool public isFreeSale = false;
	bool public isPublicSale = false;
	bool public isPrivateSale = false;

	address public C1;
	address public C2;
	address public C3;
	address public C4;
	address public C5;
	address public C6;
	address public C7;
	address public devAddress;

	mapping(address => bool) public freeSaleBuyerList;

	modifier freeSaleRole() {
		require(isFreeSale, "The free sale has not started.");
		require(FattyChuchucatContract.totalSupply() < MAX_TOKEN_SUPPLY, "Sale has already ended.");
		require(_freeSaleIdTracker.current() < MAX_FREE_SALE_SUPPLY, "Free sale has already ended.");
		require(freeSaleBuyerList[_msgSender()] == false, "Free sale can participate only once.");
		_;
	}

	modifier publicSaleP1Role(uint256 numberOfTokens) {
		require(isPublicSale, "The sale has not started.");
		require(FattyChuchucatContract.totalSupply() < MAX_TOKEN_SUPPLY, "Sale has already ended.");
		require(_publicSaleP1IdTracker.current() < MAX_PUBLIC_SALE_P1_SUPPLY, "Sale has already ended.");
		require(_publicSaleP1IdTracker.current().add(numberOfTokens) <= MAX_PUBLIC_SALE_P1_SUPPLY, "Purchase would exceed max supply of NFT");
		require(numberOfTokens <= MAX_PUBLICSALE_AMOUNT, "Can only mint 20 NFT at a time");
		require(publicSalePrice.mul(numberOfTokens) <= msg.value, "Eth value sent is not correct");
		_;
	}

	modifier publicSaleP2Role(uint256 numberOfTokens) {
		require(isPublicSale, "The sale has not started.");
		require(FattyChuchucatContract.totalSupply() < MAX_TOKEN_SUPPLY, "Sale has already ended.");
		require(_publicSaleP2IdTracker.current() < MAX_PUBLIC_SALE_P2_SUPPLY, "Sale has already ended.");
		require(_publicSaleP2IdTracker.current().add(numberOfTokens) <= MAX_PUBLIC_SALE_P2_SUPPLY, "Purchase would exceed max supply of NFT");
		require(numberOfTokens <= MAX_PUBLICSALE_AMOUNT, "Can only mint 20 NFT at a time");
		require(publicSalePrice.mul(numberOfTokens) <= msg.value, "Eth value sent is not correct");
		_;
	}

	modifier publicSaleP3Role(uint256 numberOfTokens) {
		require(isPublicSale, "The sale has not started.");
		require(FattyChuchucatContract.totalSupply() < MAX_TOKEN_SUPPLY, "Sale has already ended.");
		require(_publicSaleP3IdTracker.current() < MAX_PUBLIC_SALE_P3_SUPPLY, "Sale has already ended.");
		require(_publicSaleP3IdTracker.current().add(numberOfTokens) <= MAX_PUBLIC_SALE_P3_SUPPLY, "Purchase would exceed max supply of NFT");
		require(numberOfTokens <= MAX_PUBLICSALE_AMOUNT, "Can only mint 20 NFT at a time");
		require(publicSalePrice.mul(numberOfTokens) <= msg.value, "Eth value sent is not correct");
		_;
	}

	modifier privateSaleRole(uint256 numberOfTokens) {
		require(_msgSender() == devAddress, "only dev");
		require(isPrivateSale, "The sale has not started.");
		require(FattyChuchucatContract.totalSupply() < MAX_TOKEN_SUPPLY, "Sale has already ended.");
		require(_privateSaleIdTracker.current() < MAX_PRIVATE_SALE_SUPPLY, "Sale has already ended.");
		require(_privateSaleIdTracker.current().add(numberOfTokens) <= MAX_PRIVATE_SALE_SUPPLY, "Purchase would exceed max supply of NFT");
		_;
	}

	/*
    C1: Artist, C2: Developer, C3: Commander, C4: TeamBuilder, C5: PM, C6: PD, C7: Team
  */
	modifier onlyCreator() {
		require(
			C1 == _msgSender() ||
				C2 == _msgSender() ||
				C3 == _msgSender() ||
				C4 == _msgSender() ||
				C5 == _msgSender() ||
				C6 == _msgSender() ||
				C7 == _msgSender() ||
				devAddress == _msgSender(),
			"onlyCreator: caller is not the creator"
		);
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

	modifier onlyC5() {
		require(C5 == _msgSender(), "only C5: caller is not the C5");
		_;
	}

	modifier onlyC6() {
		require(C6 == _msgSender(), "only C6: caller is not the C6");
		_;
	}

	modifier onlyC7() {
		require(C7 == _msgSender(), "only C7: caller is not the C7");
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
		address _C5,
		address _C6,
		address _C7,
		address _dev
	) {
		FattyChuchucatContract = IFattyChuchucat(_NFT);
		C1 = _C1;
		C2 = _C2;
		C3 = _C3;
		C4 = _C4;
		C5 = _C5;
		C6 = _C6;
		C7 = _C7;
		devAddress = _dev;
		_freeSaleIdTracker.increment();
		_publicSaleP1IdTracker.increment();
		_publicSaleP2IdTracker.increment();
		_publicSaleP3IdTracker.increment();
		_privateSaleIdTracker.increment();
		setPublicSalePrice(300000000000000000); // 0.3 Eth
	}

	function freeSale() public payable freeSaleRole {
		freeSaleBuyerList[_msgSender()] = true;
		FattyChuchucatContract.mint(_msgSender(), _freeSaleIdTracker.current());
		_freeSaleIdTracker.increment();
	}

	function publicSaleP1(uint256 numberOfTokens) public payable publicSaleP1Role(numberOfTokens) {
		for (uint256 i = 0; i < numberOfTokens; i++) {
			FattyChuchucatContract.mint(_msgSender(), MAX_FREE_SALE_SUPPLY.add(_publicSaleP1IdTracker.current()));
			_publicSaleP1IdTracker.increment();
		}
	}

	function publicSaleP2(uint256 numberOfTokens) public payable publicSaleP2Role(numberOfTokens) {
		for (uint256 i = 0; i < numberOfTokens; i++) {
			FattyChuchucatContract.mint(_msgSender(), MIDDLE_VAL_1.add(_publicSaleP2IdTracker.current()));
			_publicSaleP2IdTracker.increment();
		}
	}

	function publicSaleP3(uint256 numberOfTokens) public payable publicSaleP3Role(numberOfTokens) {
		for (uint256 i = 0; i < numberOfTokens; i++) {
			FattyChuchucatContract.mint(_msgSender(), MIDDLE_VAL_2.add(_publicSaleP3IdTracker.current()));
			_publicSaleP3IdTracker.increment();
		}
	}

	function privateSale(uint256 numberOfTokens, address receiver) public privateSaleRole(numberOfTokens) {
		for (uint256 i = 0; i < numberOfTokens; i++) {
			FattyChuchucatContract.mint(receiver, MIDDLE_VAL_3.add(_privateSaleIdTracker.current()));
			_privateSaleIdTracker.increment();
		}
	}

	function withdraw() public payable onlyCreator {
		uint256 contractBalance = address(this).balance;
		uint256 percentage = contractBalance.div(1000);

		require(payable(C1).send(percentage.mul(450)));
		require(payable(C2).send(percentage.mul(162)));
		require(payable(C3).send(percentage.mul(48)));
		require(payable(C4).send(percentage.mul(64)));
		require(payable(C5).send(percentage.mul(128)));
		require(payable(C6).send(percentage.mul(48)));
		require(payable(C7).send(percentage.mul(100)));
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

	function setC5(address changeAddress) public onlyC5 {
		C5 = changeAddress;
	}

	function setC6(address changeAddress) public onlyC6 {
		C6 = changeAddress;
	}

	function setC7(address changeAddress) public onlyC7 {
		C7 = changeAddress;
	}

	function setDev(address changeAddress) public onlyDev {
		devAddress = changeAddress;
	}

	function setFreeSale() public onlyDev {
		isFreeSale = !isFreeSale;
	}

	function setPublicSale() public onlyDev {
		isPublicSale = !isPublicSale;
	}

	function setPrivateSale() public onlyDev {
		isPrivateSale = !isPrivateSale;
	}

	function setPublicSalePrice(uint256 price) public onlyDev {
		publicSalePrice = price;
	}
}
