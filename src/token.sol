// SPDX-License-identifier: MIT

pragma solidity ^0.8.0;

contract ERC20Token{

    // ========== EVENts =============
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);


    mapping (address => uint256) private _balance;
    mapping (address => mapping (address => uint256)) private _allowances;
    uint256 private _totalSupply;
    string public name;
    string public symbol;
    uint8 public decimals;

    constructor (string memory _name, string memory _symbol, uint256 _initialSupply){
        name = _name;
        symbol = _symbol;
        decimals = 18;

        _totalSupply = _initialSupply;
        _balance[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);

    }

    // ========= Required Functions =============

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256){
        return _balance[account];
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        address owner = msg.sender;
        _transfer(owner, to, amount);
        return true;
    }

    function _transfer(address from, address to, uint256 amount) internal {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer from the zero address");
        uint256 fromBalance = _balance[from];
        require(fromBalance >= amount, "Not enough balance");
        unchecked {
            _balance[from] = fromBalance - amount;
            _balance[to] += amount;
        }

        emit Transfer(from, to, amount);

    }

    function approve(address spender, uint256 amount) public returns (bool){
        address owner = msg.sender;
        _approve(owner, spender, amount);
        return true;
    }

    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);

    }

    function allowance(address owner, address spender) public view returns (uint256){
        return _allowances[owner][spender];
    }

    function transferFrom(address from, address to, uint256 amount) public returns (bool){
        address spender = msg.sender;
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    function _spendAllowance(address owner, address spender, uint256 amount) internal {
        uint256 currentAllowance = allowance(owner, spender);

        if (currentAllowance != type(uint256).max){
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }




}