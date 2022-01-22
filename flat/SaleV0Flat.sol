// Sources flattened with hardhat v2.8.0 https://hardhat.org

// File contracts/openzeppelin/contracts/utils/Context.sol

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.0 (utils/Context.sol)

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}


// File contracts/openzeppelin/contracts/utils/math/SafeMath.sol

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.0 (utils/math/SafeMath.sol)

pragma solidity ^0.8.0;

// CAUTION
// This version of SafeMath should only be used with Solidity 0.8 or later,
// because it relies on the compiler's built in overflow checks.

/**
 * @dev Wrappers over Solidity's arithmetic operations.
 *
 * NOTE: `SafeMath` is generally not needed starting with Solidity 0.8, since the compiler
 * now has built in overflow checking.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the substraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}


// File contracts/openzeppelin/contracts/utils/Counters.sol

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.0 (utils/Counters.sol)

pragma solidity ^0.8.0;

/**
 * @title Counters
 * @author Matt Condon (@shrugs)
 * @dev Provides counters that can only be incremented, decremented or reset. This can be used e.g. to track the number
 * of elements in a mapping, issuing ERC721 ids, or counting request ids.
 *
 * Include with `using Counters for Counters.Counter;`
 */
library Counters {
    struct Counter {
        // This variable should never be directly accessed by users of the library: interactions must be restricted to
        // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
        // this feature: see https://github.com/ethereum/solidity/issues/4637
        uint256 _value; // default: 0
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        unchecked {
            counter._value += 1;
        }
    }

    function decrement(Counter storage counter) internal {
        uint256 value = counter._value;
        require(value > 0, "Counter: decrement overflow");
        unchecked {
            counter._value = value - 1;
        }
    }

    function reset(Counter storage counter) internal {
        counter._value = 0;
    }
}


// File contracts/interfaces/ICloseYourEyesV0.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

interface ICloseYourEyesV0 {
	event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

	event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

	event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

	function mint(address to) external;

	function totalSupply() external view returns (uint256);

	function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256 tokenId);

	function tokenByIndex(uint256 index) external view returns (uint256);

	function balanceOf(address owner) external view returns (uint256 balance);

	function ownerOf(uint256 tokenId) external view returns (address owner);

	function transferFrom(
		address from,
		address to,
		uint256 tokenId
	) external;

	function approve(address to, uint256 tokenId) external;

	function getApproved(uint256 tokenId) external view returns (address operator);

	function setApprovalForAll(address operator, bool _approved) external;

	function isApprovedForAll(address owner, address operator) external view returns (bool);
}


// File contracts/sale/SaleV0.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;




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
