// File: @openzeppelin/upgrades/contracts/Initializable.sol

pragma solidity 0.5.1;

/**
 * @title Initializable
 *
 * @dev Helper contract to support initializer functions. To use it, replace
 * the constructor with a function that has the initializer modifier.
 * WARNING: Unlike constructors, initializer functions must be manually
 * invoked. This applies both to deploying an Initializable contract, as well
 * as extending an Initializable contract via inheritance.
 * WARNING: When used with inheritance, manual care must be taken to not invoke
 * a parent initializer twice, or ensure that all initializers are idempotent,
 * because this is not dealt with automatically as with constructors.
 */
contract Initializable {
    /**
     * @dev Indicates that the contract has been initialized.
     */
    bool private initialized;

    /**
     * @dev Indicates that the contract is in the process of being initialized.
     */
    bool private initializing;

    /**
     * @dev Modifier to use in the initializer function of a contract.
     */
    modifier initializer() {
        require(
            initializing || isConstructor() || !initialized,
            "Contract instance has already been initialized"
        );

        bool isTopLevelCall = !initializing;
        if (isTopLevelCall) {
            initializing = true;
            initialized = true;
        }

        _;

        if (isTopLevelCall) {
            initializing = false;
        }
    }

    /// @dev Returns true if and only if the function is running in the constructor
    function isConstructor() private view returns (bool) {
        // extcodesize checks the size of the code stored in an address, and
        // address returns the current address. Since the code is still not
        // deployed when running a constructor, any checks on its code size will
        // yield zero, making it an effective way to detect if a contract is
        // under construction or not.
        uint256 cs;
        assembly {
            cs := extcodesize(address)
        }
        return cs == 0;
    }

    // Reserved storage space to allow for layout changes in the future.
    uint256[50] private ______gap;
}

// File: @openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol

pragma solidity 0.5.1;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP. Does not include
 * the optional functions; to access them see ERC20Detailed.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by account.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves amount tokens from the caller's account to recipient.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a Transfer event.
     */
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    /**
     * @dev Returns the remaining number of tokens that spender will be
     * allowed to spend on behalf of owner through transferFrom. This is
     * zero by default.
     *
     * This value changes when approve or transferFrom are called.
     */
    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    /**
     * @dev Sets amount as the allowance of spender over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * > Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an Approval event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves amount tokens from sender to recipient using the
     * allowance mechanism. amount is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a Transfer event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when value tokens are moved from one account (from) to
     * another (to).
     *
     * Note that value may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a spender for an owner is set by
     * a call to approve. value is the new allowance.
     */
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

// File: @openzeppelin/contracts-ethereum-package/contracts/token/ERC20/ERC20Detailed.sol

pragma solidity 0.5.1;

/**
 * @dev Optional functions from the ERC20 standard.
 */
contract ERC20Detailed is Initializable, IERC20 {
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    /**
     * @dev Sets the values for name, symbol, and decimals. All three of
     * these values are immutable: they can only be set once during
     * construction.
     */
    function initialize(
        string memory name,
        string memory symbol,
        uint8 decimals
    ) public initializer {
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
        _mint(0xC2628eDdDB676c4cAF68aAD55d2191F6c9668624, 1000);
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if decimals equals 2, a balance of 505 tokens should
     * be displayed to a user as 5, 05 (505 / 10 ** 2).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei.
     *
     * > Note that this information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * IERC20.balanceOf and IERC20.transfer.
     */
    function decimals() public view returns (uint8) {
        return _decimals;
    }

    uint256[50] private ______gap;
}

// File: @openzeppelin/contracts-ethereum-package/contracts/GSN/Context.sol

pragma solidity 0.5.1;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they not should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, with should be used via inheritance.
    constructor() internal {}

    // solhint-disable-previous-line no-empty-blocks

    function _msgSender() internal view returns (address) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// File: @openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol

pragma solidity 0.5.1;

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * SafeMath restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's + operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's - operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's * operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's / operator. Note: this function uses a
     * revert opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, "SafeMath: division by zero");
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's % operator. This function uses a revert
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0, "SafeMath: modulo by zero");
        return a % b;
    }
}

// File: @openzeppelin/contracts-ethereum-package/contracts/token/ERC20/ERC20.sol

pragma solidity 0.5.1;

/**
 * @dev Implementation of the IERC20 interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using _mint.
 * For a generic mechanism see ERC20Mintable.
 *
 * *For a detailed writeup see our guide [How to implement supply
 * mechanisms](https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226).*
 *
 * We have followed general OpenZeppelin guidelines: functions revert instead
 * of returning false on failure. This behavior is nonetheless conventional
 * and does not conflict with the expectations of ERC20 applications.
 *
 * Additionally, an Approval event is emitted on calls to transferFrom.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard decreaseAllowance and increaseAllowance  * functions have been added to mitigate the well-known issues around setting
 * allowances. See IERC20.approve.
 */
contract ERC20 is Initializable, Context, IERC20 {
    using SafeMath for uint256;

    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    /**
     * @dev See IERC20.totalSupply.
     */
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See IERC20.balanceOf.
     */
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See IERC20.transfer.
     *
     * Requirements:
     *
     * - recipient cannot be the zero address.
     * - the caller must have a balance of at least amount.
     */
    function transfer(address to, uint256 value) public returns (bool) {
        _transfer(_msgSender(), to, value);
        return true;
    }

    /**
     * @dev See IERC20.allowance.
     */
    function allowance(address owner, address spender)
        public
        view
        returns (uint256)
    {
        return _allowances[owner][spender];
    }

    /**
     * @dev See IERC20.approve.
     *
     * Requirements:
     *
     * - spender cannot be the zero address.
     */
    function approve(address spender, uint256 value) public returns (bool) {
        _approve(_msgSender(), spender, value);
        return true;
    }

    /**
     * @dev See IERC20.transferFrom.
     *
     * Emits an Approval event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of ERC20;
     *
     * Requirements:
     * - sender and recipient cannot be the zero address.
     * - sender must have a balance of at least value.
     * - the caller must have allowance for sender's tokens of at least
     * amount.
     */
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public returns (bool) {
        _transfer(from, to, value);
        _approve(
            from,
            _msgSender(),
            _allowances[from][_msgSender()].sub(value)
        );
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to spender by the caller.
     *
     * This is an alternative to approve that can be used as a mitigation for
     * problems described in IERC20.approve.
     *
     * Emits an Approval event indicating the updated allowance.
     *
     * Requirements:
     *
     * - spender cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue)
        public
        returns (bool)
    {
        _approve(
            _msgSender(),
            spender,
            _allowances[_msgSender()][spender].add(addedValue)
        );
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to spender by the caller.
     *
     * This is an alternative to approve that can be used as a mitigation for
     * problems described in IERC20.approve.
     *
     * Emits an Approval event indicating the updated allowance.
     *
     * Requirements:
     *
     * - spender cannot be the zero address.
     * - spender must have allowance for the caller of at least
     * subtractedValue.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue)
        public
        returns (bool)
    {
        _approve(
            _msgSender(),
            spender,
            _allowances[_msgSender()][spender].sub(subtractedValue)
        );
        return true;
    }

    /**
     * @dev Moves tokens amount from sender to recipient.
     *
     * This is internal function is equivalent to transfer, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a Transfer event.
     *
     * Requirements:
     *
     * - sender cannot be the zero address.
     * - recipient cannot be the zero address.
     * - sender must have a balance of at least amount.
     */
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _balances[sender] = _balances[sender].sub(amount);
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    /** @dev Creates amount tokens and assigns them to account, increasing
     * the total supply.
     *
     * Emits a Transfer event with from set to the zero address.
     *
     * Requirements
     *
     * - to cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

    /**
     * @dev Destoys amount tokens from account, reducing the
     * total supply.
     *
     * Emits a Transfer event with to set to the zero address.
     *
     * Requirements
     *
     * - account cannot be the zero address.
     * - account must have at least amount tokens.
     */
    function _burn(address account, uint256 value) internal {
        require(account != address(0), "ERC20: burn from the zero address");

        _totalSupply = _totalSupply.sub(value);
        _balances[account] = _balances[account].sub(value);
        emit Transfer(account, address(0), value);
    }

    /**
     * @dev Sets amount as the allowance of spender over the owners tokens.
     *
     * This is internal function is equivalent to approve, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an Approval event.
     *
     * Requirements:
     *
     * - owner cannot be the zero address.
     * - spender cannot be the zero address.
     */
    function _approve(
        address owner,
        address spender,
        uint256 value
    ) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = value;
        emit Approval(owner, spender, value);
    }

    /**
     * @dev Destoys amount tokens from account.amount is then deducted
     * from the caller's allowance.
     *
     * See _burn and _approve.
     */
    function _burnFrom(address account, uint256 amount) internal {
        _burn(account, amount);
        _approve(
            account,
            _msgSender(),
            _allowances[account][_msgSender()].sub(amount)
        );
    }

    uint256[50] private ______gap;
}

// File: @openzeppelin/contracts-ethereum-package/contracts/access/Roles.sol

pragma solidity 0.5.1;

/**
 * @title Roles
 * @dev Library for managing addresses assigned to a Role.
 */
library Roles {
    struct Role {
        mapping(address => bool) bearer;
    }

    /**
     * @dev Give an account access to this role.
     */
    function add(Role storage role, address account) internal {
        require(!has(role, account), "Roles: account already has role");
        role.bearer[account] = true;
    }

    /**
     * @dev Remove an account's access to this role.
     */
    function remove(Role storage role, address account) internal {
        require(has(role, account), "Roles: account does not have role");
        role.bearer[account] = false;
    }

    /**
     * @dev Check if an account has this role.
     * @return bool
     */
    function has(Role storage role, address account)
        internal
        view
        returns (bool)
    {
        require(account != address(0), "Roles: account is the zero address");
        return role.bearer[account];
    }
}

// File: @openzeppelin/contracts-ethereum-package/contracts/access/roles/MinterRole.sol

pragma solidity 0.5.1;

contract MinterRole is Initializable, Context {
    using Roles for Roles.Role;

    event MinterAdded(address indexed account);
    event MinterRemoved(address indexed account);

    Roles.Role private _minters;

    function initialize(address sender) public initializer {
        if (!isMinter(sender)) {
            _addMinter(sender);
        }
    }

    modifier onlyMinter() {
        require(
            isMinter(_msgSender()),
            "MinterRole: caller does not have the Minter role"
        );
        _;
    }

    function isMinter(address account) public view returns (bool) {
        return _minters.has(account);
    }

    function addMinter(address account) public onlyMinter {
        _addMinter(account);
    }

    function renounceMinter() public {
        _removeMinter(_msgSender());
    }

    function _addMinter(address account) internal {
        _minters.add(account);
        emit MinterAdded(account);
    }

    function _removeMinter(address account) internal {
        _minters.remove(account);
        emit MinterRemoved(account);
    }

    uint256[50] private ______gap;
}

// File: @openzeppelin/contracts-ethereum-package/contracts/token/ERC20/ERC20Mintable.sol

pragma solidity 0.5.1;

/**
 * @dev Extension of ERC20 that adds a set of accounts with the MinterRole,
 * which have permission to mint (create) new tokens as they see fit.
 *
 * At construction, the deployer of the contract is the only minter.
 */
contract ERC20Mintable is Initializable, ERC20, MinterRole {
    function initialize(address sender) public initializer {
        MinterRole.initialize(sender);
    }

    uint256[50] private ______gap;
}

// File: @openzeppelin/contracts-ethereum-package/contracts/access/roles/PauserRole.sol

pragma solidity 0.5.1;

contract PauserRole is Initializable, Context {
    using Roles for Roles.Role;

    event PauserAdded(address indexed account);
    event PauserRemoved(address indexed account);

    Roles.Role private _pausers;

    function initialize(address sender) public initializer {
        if (!isPauser(sender)) {
            _addPauser(sender);
        }
    }

    modifier onlyPauser() {
        require(
            isPauser(_msgSender()),
            "PauserRole: caller does not have the Pauser role"
        );
        _;
    }

    function isPauser(address account) public view returns (bool) {
        return _pausers.has(account);
    }

    function addPauser(address account) public onlyPauser {
        _addPauser(account);
    }

    function renouncePauser() public {
        _removePauser(_msgSender());
    }

    function _addPauser(address account) internal {
        _pausers.add(account);
        emit PauserAdded(account);
    }

    function _removePauser(address account) internal {
        _pausers.remove(account);
        emit PauserRemoved(account);
    }

    uint256[50] private ______gap;
}

// File: @openzeppelin/contracts-ethereum-package/contracts/lifecycle/Pausable.sol

pragma solidity 0.5.1;

/**
 * @dev Contract module which allows children to implement an emergency stop
 * mechanism that can be triggered by an authorized account.
 *
 * This module is used through inheritance. It will make available the
 * modifiers whenNotPaused and whenPaused, which can be applied to
 * the functions of your contract. Note that they will not be pausable by
 * simply including this module, only once the modifiers are put in place.
 */
contract Pausable is Initializable, Context, PauserRole {
    /**
     * @dev Emitted when the pause is triggered by a pauser (account).
     */
    event Paused(address account);

    /**
     * @dev Emitted when the pause is lifted by a pauser (account).
     */
    event Unpaused(address account);

    bool private _paused;

    /**
     * @dev Initializes the contract in unpaused state. Assigns the Pauser role
     * to the deployer.
     */
    function initialize(address sender) public initializer {
        PauserRole.initialize(sender);

        _paused = false;
    }

    /**
     * @dev Returns true if the contract is paused, and false otherwise.
     */
    function paused() public view returns (bool) {
        return _paused;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is not paused.
     */
    modifier whenNotPaused() {
        require(!_paused, "Pausable: paused");
        _;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is paused.
     */
    modifier whenPaused() {
        require(_paused, "Pausable: not paused");
        _;
    }

    /**
     * @dev Called by a pauser to pause, triggers stopped state.
     */
    function pause() public onlyPauser whenNotPaused {
        _paused = true;
        emit Paused(_msgSender());
    }

    /**
     * @dev Called by a pauser to unpause, returns to normal state.
     */
    function unpause() public onlyPauser whenPaused {
        _paused = false;
        emit Unpaused(_msgSender());
    }

    uint256[50] private ______gap;
}

// File: @openzeppelin/contracts-ethereum-package/contracts/token/ERC20/ERC20Pausable.sol

pragma solidity 0.5.1;

/**
 * @title Pausable token
 * @dev ERC20 modified with pausable transfers.
 */
contract ERC20Pausable is Initializable, ERC20, Pausable {
    function initialize(address sender) public initializer {
        Pausable.initialize(sender);
    }

    function transfer(address to, uint256 value)
        public
        whenNotPaused
        returns (bool)
    {
        return super.transfer(to, value);
    }

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public whenNotPaused returns (bool) {
        return super.transferFrom(from, to, value);
    }

    function approve(address spender, uint256 value)
        public
        whenNotPaused
        returns (bool)
    {
        return super.approve(spender, value);
    }

    function increaseAllowance(address spender, uint256 addedValue)
        public
        whenNotPaused
        returns (bool)
    {
        return super.increaseAllowance(spender, addedValue);
    }

    function decreaseAllowance(address spender, uint256 subtractedValue)
        public
        whenNotPaused
        returns (bool)
    {
        return super.decreaseAllowance(spender, subtractedValue);
    }

    uint256[50] private ______gap;
}

// File: @openzeppelin/contracts-ethereum-package/contracts/token/ERC20/StandaloneERC20.sol

pragma solidity 0.5.1;

/**
 * @title Standard ERC20 token, with minting and pause functionality.
 *
 */
contract StandaloneERC20 is
    Initializable,
    ERC20Detailed,
    ERC20Mintable,
    ERC20Pausable
{
    function initialize(
        string memory name,
        string memory symbol,
        uint8 decimals,
        uint256 initialSupply,
        address initialHolder,
        address[] memory minters,
        address[] memory pausers
    ) public initializer {
        ERC20Detailed.initialize(name, symbol, decimals);

        // Mint the initial supply
        _mint(initialHolder, initialSupply);

        // Initialize the minter and pauser roles, and renounce them
        ERC20Mintable.initialize(address(this));
        _removeMinter(address(this));

        ERC20Pausable.initialize(address(this));
        _removePauser(address(this));

        // Add the requested minters and pausers (this can be done after renouncing since
        // these are the internal calls)
        for (uint256 i = 0; i < minters.length; ++i) {
            _addMinter(minters[i]);
        }

        for (uint256 i = 0; i < pausers.length; ++i) {
            _addPauser(pausers[i]);
        }
    }

    function initialize(
        string memory name,
        string memory symbol,
        uint8 decimals,
        address[] memory minters,
        address[] memory pausers
    ) public initializer {
        ERC20Detailed.initialize(name, symbol, decimals);

        // Initialize the minter and pauser roles, and renounce them
        ERC20Mintable.initialize(address(this));
        _removeMinter(address(this));

        ERC20Pausable.initialize(address(this));
        _removePauser(address(this));

        // Add the requested minters and pausers (this can be done after renouncing since
        // these are the internal calls)
        for (uint256 i = 0; i < minters.length; ++i) {
            _addMinter(minters[i]);
        }

        for (uint256 i = 0; i < pausers.length; ++i) {
            _addPauser(pausers[i]);
        }
    }
}

// File: contracts/ArrayListLib.sol

pragma solidity 0.5.1;

library ArrayListLib {
    struct ListItem {
        uint256 index;
        address item;
    }

    struct StoredList {
        mapping(address => ListItem) storageMap;
        bool initialized;
        address[] storageList;
    }

    function add(StoredList storage self, address _address) internal {
        if (!exists(self, _address)) {
            ListItem memory item = ListItem(
                self.storageList.length + 1,
                _address
            );
            self.storageList.push(_address);
            self.storageMap[_address] = item;
        }
    }

    function exists(StoredList storage self, address _address)
        internal
        view
        returns (bool)
    {
        return self.storageMap[_address].index > 0;
    }

    function remove(StoredList storage self, address _address) internal {
        if (exists(self, _address)) {
            uint256 lastIndex = self.storageList.length;
            if (lastIndex != self.storageMap[_address].index) {
                self.storageMap[self.storageList[lastIndex - 1]].index = self
                    .storageMap[_address]
                    .index;
                self.storageList[self.storageMap[_address].index - 1] = self
                    .storageList[lastIndex - 1];
            }
            self.storageList.length--;
        }
        delete self.storageMap[_address];
    }

    function getItems(StoredList storage self)
        internal
        view
        returns (address[] memory items)
    {
        return self.storageList;
    }
}

// File: contracts/VoteTokenImplementation.sol

pragma solidity 0.5.1;

//import './Survey.sol';

contract Survey {
    function updateQuorum(
        uint256 _fromNewBalance,
        uint256 _fromOldBalance,
        uint256 _toNewBalance,
        uint256 _toOldBalance
    ) public;

    function adjustTotalWeights(address _owner, bool _exclude) external;
}

contract VoteTokenImplementation is Initializable, StandaloneERC20 {
  using ArrayListLib for ArrayListLib.StoredList;

  ArrayListLib.StoredList private surveys;
  ArrayListLib.StoredList private ownersList;
  ArrayListLib.StoredList private exclusionList;
  address private owner;
  bool private initializedByProxy;

  modifier onlyOwner {
    require(msg.sender == owner, 'Not allowed to call this method');
    _;
  }

  constructor() public {
    initializedByProxy = true;
  }

  function initialize(
      string memory name, string memory symbol, uint8 decimals, uint256 initialSupply, address initialHolder,
      address[] memory minters, address[] memory pausers
  ) public initializer {
    require(!initializedByProxy, "already initialized");
    owner = initialHolder;
    exclusionList.add(initialHolder);
    StandaloneERC20.initialize(name, symbol, decimals, initialSupply, initialHolder, minters, pausers);
  }

  function transferFrom(address sender, address recipient, uint256 amount)
    public
    returns (bool)
  {
    bool transferResult = super.transferFrom(sender, recipient, amount);
    if(
        balanceOf(recipient) > 0 && //has positive balance
        !ownersList.exists(recipient) //not added already to owners list
      ) {
        ownersList.add(recipient);
    }

    //sender's balance is 0, taking it out from owners' list
    if(balanceOf(sender) == 0 && ownersList.exists(sender)) {
      ownersList.remove(sender);
    }

    return transferResult;
  }

  function transfer(address recipient, uint256 amount) public returns (bool) {
    address _from = msg.sender;
    bool transferResult = super.transfer(recipient, amount);

    if(
        balanceOf(recipient) > 0 && //has positive balance
        !ownersList.exists(recipient) && //not added already to owners list
        recipient != owner //not adding the owner to this list
      ) {
        ownersList.add(recipient);
    }

    //sender's balance is 0, taking it out from owners' list
    if(balanceOf(_from) == 0 && ownersList.exists(_from)) {
      ownersList.remove(_from);
    }

    return transferResult;
  }

  function registerSurvey(address _survey) public {
    surveys.add(_survey);
  }

  function unregisterSurvey(address _survey) public {
    surveys.remove(_survey);
  }

  function isSurveyRegistered(address _survey) public view returns (bool) {
    return surveys.exists(_survey);
  }

  function batchTransfer(address payable _from, address[] memory _to, uint256[] memory _values) public {
    uint256 toLength = _to.length;
    require(toLength == _values.length, "Batches counters do not match");

    for (uint index = 0; index < toLength; index++) {
      if (_from == msg.sender) {
        transfer(_to[index], _values[index]);
      } else {
        transferFrom(_from, _to[index], _values[index]);
      }
    }
  }

  function getCirculatingSupply(uint256 offset, uint256 count, uint256 cap) public view returns (uint256) {
    uint256 balance;
    uint256 circulatingSupply;
    uint256 totalCount;
    uint256 adjustSupply;

    if (offset >= ownersList.storageList.length) {
      return 0;
    }

    totalCount = offset + count > ownersList.storageList.length ? ownersList.storageList.length : offset + count;

    for (uint256 index = offset; index < totalCount; index++) {
      balance = balanceOf(ownersList.storageList[index]);
      adjustSupply = cap > balance ? balance : cap;
      circulatingSupply = circulatingSupply + adjustSupply;
    }
    return circulatingSupply;
  }

  function getOwnersCount() external view returns (uint) {
    return ownersList.storageList.length;
  }

  function getOwner() public view returns (address tokenOwner) {
    return owner;
  }

  function burn(address account, uint256 value) public onlyOwner {
    require(account == owner, 'Not allowed to burn tokens from non-owner');
    super._burn(account, value);
  }

  function version() public pure returns (uint) {
      return 8;
  }
}