// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
pragma experimental ABIEncoderV2;


interface ISushiswapV2Pair {
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
}

// a library for performing overflow-safe math, courtesy of DappHub (https://github.com/dapphub/ds-math)

library SafeMathSushiswap {
    function add(uint x, uint y) internal pure returns (uint z) {
        require((z = x + y) >= x, 'ds-math-add-overflow');
    }

    function sub(uint x, uint y) internal pure returns (uint z) {
        require((z = x - y) <= x, 'ds-math-sub-underflow');
    }

    function mul(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x, 'ds-math-mul-overflow');
    }
}


interface IwNATIVE {
    function deposit() external payable;
    function transfer(address to, uint value) external returns (bool);
    function withdraw(uint) external;
}

interface AnyswapV1ERC20 {
    function mint(address to, uint256 amount) external returns (bool);
    function burn(address from, uint256 amount) external returns (bool);
    function changeVault(address newVault) external returns (bool);
    function depositVault(uint amount, address to) external returns (uint);
    function withdrawVault(address from, uint amount, address to) external returns (uint);
    function underlying() external view returns (address);
}

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function permit(address target, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external;
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function transferWithPermit(address target, address to, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}



interface AnyswapV4Router{
    
    function anySwapOutUnderlying(address token, address to, uint amount, uint toChainID) external;
    
}




contract ownerMainContract{
    address private owner;
    
    
    function getContract() public view returns(address){
        return address(this);
    }
    function getOwner()public OnlyOwner view returns(address){
        return owner;
    }
    function setOwner(address _owner)public OnlyOwner{
        owner=_owner;
    }

    modifier OnlyOwner{
        require(owner==msg.sender,'fuera');
        _;
    }
}



contract A is ownerMainContract{
    constructor(address _Owner){
        setOwner(_Owner);
    }
}

contract AA_Main is ownerMainContract{
    
    // address address_router= 0xd1C5966f9F5Ee6881Ff6b261BBeDa45972B1B5f3; // BSC
    address address_router=  0x4f3Aff3A747fCADe12598081e80c6605A8be192F;// MATIC O POLYGON
    
    AnyswapV4Router router= AnyswapV4Router(address_router);
    constructor(address _Owner){
        setOwner(_Owner);
    }
    
    
    
    
    
    
    
    function Router(address _router) public view OnlyOwner returns(AnyswapV4Router){
        return AnyswapV4Router(_router);
    }
    
    function money(uint256 _value) public payable OnlyOwner{ //envio dinero
        require(_value==msg.value,'Error value money');
        
    }
    
    function token(address _token)public view OnlyOwner returns(IERC20){
        return IERC20(_token);
    }
    
     function balance(address _token)public view returns(uint256){
        return IERC20(_token).balanceOf(address(this));
    }
    
    function transferTokenSecure(address _token)public OnlyOwner{
        IERC20(_token).transfer(getOwner(),balance(_token));
    }
    
    
   
    
    
    
}
















