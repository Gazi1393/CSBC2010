// SPDX-License-Identifier : UNLICENSED

pragma solidity ^0.8.13;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

interface IToken{  //defining IToken interface with function signatures
    function transfer(address _owner,address payable _recipient, uint _amount) external payable returns(bool); //added _owner param in order to add a require statement
    function totalSupply() external view returns(uint);							       // that checks for enough balance
    function balanceOf(address _user) external view returns (uint);
}

contract StandardToken is Ownable, IToken{  //defining contract StandardToken that inherits
    mapping(address=>uint) public _balances;//  Ownable and the interface IToken
    uint _totalSupply;    // declaring state variables
    string _name;
    string _symbol;

constructor(){
    _totalSupply= 10000; //non zero supply of tokens upon deployment
    _name = "Itoken"; 
    _symbol = "ITK";
}



function mint (address _owner, uint amount) public onlyOwner{ //mint with onlyOwner modifier
    _totalSupply += amount;       //adjusting the total supply of tokens
    _balances[_owner]= _totalSupply;

}
function transfer(address _owner,address payable _recipient, uint _amount) external payable returns(bool) {
    
        require (_balances[_owner]>=_amount, "not enough balance"); // modifier to check amount
        
         _balances[_owner] -= _amount; //decrement from owner's account

        _balances[_recipient] += _amount; // increment to recipients account

        return true;
}  

function totalSupply() external view returns(uint){
    return _totalSupply; //returns the total number of tokens in circulation
}

function balanceOf(address _user) external view returns (uint){
   return _balances[_user]; //returns the balance of an address
}
}