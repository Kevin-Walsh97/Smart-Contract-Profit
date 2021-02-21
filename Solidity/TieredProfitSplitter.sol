pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/math/SafeMath.sol";

// lvl 2: tiered split
contract TieredProfitSplitter {
    
    using SafeMath for uint;
    
    address payable employee_ceo; // ceo
    address payable employee_cto; // cto
    address payable employee_Bob; // bob
    uint public ceo_pct;
    uint public cto_pct;
    uint public bob_pct;

    constructor(address payable _ceo, address payable _cto, address payable _bob, uint _pctceo, uint _pctcto, uint _pctbob) public {
        employee_ceo = _ceo;
        employee_cto = _cto;
        employee_Bob = _bob;
        ceo_pct = _pctceo;
        cto_pct = _pctcto;
        bob_pct = _pctbob;
    }

    // Should always return 0! Use this to test your `deposit` function's logic
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        uint points = msg.value.div(100); // Calculates rudimentary percentage by dividing msg.value into 100 units
        uint total;
        uint amount;

        // @TODO: Calculate and transfer the distribution percentage
        // Step 1: Set amount to equal `points` * the number of percentage points for this employee
        // Step 2: Add the `amount` to `total` to keep a running total
        // Step 3: Transfer the `amount` to the employee
        amount = points.mul(ceo_pct);
        total = total.add(amount);
        employee_ceo.transfer(amount);

        // @TODO: Repeat the previous steps for `employee_two` and `employee_three`
        // Your code here!
        // CTO 
        amount = points.mul(cto_pct);
        total = total.add(amount);
        employee_cto.transfer(amount);
        
        // Bob 
        amount = points.mul(bob_pct);
        total = total.add(amount);
        employee_Bob.transfer(amount);

        employee_ceo.transfer(msg.value.sub(total)); // ceo gets the remaining wei
    }

    function fallback() external payable {
        deposit();
    }
}
