# Associate Profit Splitter

The main function of this contract is to split equitably the profit of a company two three employees. The contract makes no determination about scaling the profit split based on the employee's seniority or rank. Rather, by using the the deposit function, which references the balance of the contract, each employee will receive an equal distribution of the profits. There may be some remaining ETH after this split. This contract does not have the functionality to hold and maintain a balance of ETH for an extended period of time. So, any remaining ETH will be returned to the contract owner, which in this case would most likely be an HR representative.

## Compiling, Deploying and Testing

After writing the contract in Solidity we can begin using it by doing the following:

1) Compile the solidity code

[Compile](Images/Compile.png)

2) Deploy the code onto your local network. To do this, you will need to add address from the three employees. To demonstrate, I selected three address from my Ganache.

[Ganache](Images/Ganache_addresses.png)

[Deploy](Images/Deploy.png)

3) After deploying the contract we are read to test our contract out by providing a value that it will distribute to the three employees evenly. 

[Test_value](Images/Test_value.png)

4) After providing a test value, we can then click our deposit function in order to initiate the distribution process. There will be a popup that appears asking you to confirm the call of the deposit function from MetaMask. 

[Deposit](Images/Deposit.png)

[Confirmation](Images/Confirmation.png)

5) We can check that the transactions were successful in a number of ways. But, the most convenient is to check Ganache to make sure that the balances of your accounts (the msg.sender and the three employees) all changed as a result of the deposit function being called. In this example, I set the value to 10 ETH and, as you can see, the first address was reduced by a magnitude of 10 ETH and the next three addresses each increased by an even 3.33 ETH, respectively.

[Ganache_check](Images/Ganache_check.png)

We are also going to want to verify that the contract is working successfully by checking the balance of the contract. Again, since we are only distributing payments here, the balance should be *zero*.

[Balance_check](Images/Balance_check.png)

# Tier Profit Splitter

Unlike the associate profit splitting contract, this contract does take an employees seniority into account. Rather than taking the profits and dividing them evenly, each employee receives a differentiable split of the profit that is inline with their position within the firm. The CEO will get the highest percentaged, followed by the CTO and other C-Suite office holders and so on down the employee structure of the firm. To facilitate this, the profits (msg.value) is divided by 100. This will allow us to multiply the points with a number representing a percentage. For example, `points * 60` will output a number that is ~60% of the `msg.value`.

After that, we can simply transfer to each employee their profit split amount, which will be just the total amount of the profit multiplied by that person's profit percentage entitlement. As before, there will be an amount left over after this profit split. This remainder will be given to the CEO.

## Compiling, Deploying and Testing

After writing the code in solidity for the tier profit splitting contract, we can compile the function and deploy it similar to the way we did above. One difference is that, in addition to defining the addresses for the employees we will also have to define the percentages associated with each employee. The percentages are not hardcoded into the code but rather allow use to define what the percentage breakdown should be when we deploy.

[Deploy_tier](Images/Deploy_tier.png)

After deploying the contract, we can test the new deposit function by providing a test value (100+ wei) and making sure that 1) the transaction was successful and 2) that the balance of the contract remains at *zero*.

[Tier_test_value](Images/Tier_test_value.png)

After providing the test value, we can then select the 'deposit' button in order to activate the deposit function and distribute the test value to the three employees. The same popup as before will appear asking you to confirm the transaction in order to continue to the using of the deposit function.

[Tier_deploy](Images/Tier_deploy.png)

We will know that the contract was successfully deployed and used if we get both a successful message in the panel below the solidity and code and see a balance of zero for the contract.

[Tier_success](Images/Tier_success.png)

[Tier_balance](Images/Tier_balance.png)

# Deferred Equity Plan

In this contract, we will be managing an employee's "deferred equity incentive plan" in which 1000 shares will be distributed over 4 years to the employee. We won't need to work with Ether in this contract, but we will be storing and setting amounts that represent the number of distributed shares the employee owns and enforcing the vetting periods automatically. 

For example, we will be using now as the starting time, so that the point at which the contract is deployed will act as the contract start time. Based on that, there is a lockup period of one year, so that the unlock_time will be 365 days from now. Besides leveraging time to restrict access to the equity plan, we also restrict access to only the msg.sender (HR) and the employee in question. We also want to make that there are no distributions beyond the 1000 alloted for over 4 years as there is no incentive, at least in terms of equity, for the employee to stay longer. 

Using the starting time as the base, the distributions per year (250) will be given out at a staggered pace by using the following function:

    distributed_shares = ((now - start_time) / 365 days * annual_distribution)

So, as we move through time the distributions will be triggered automatically.

## Compiling and Deploying

After writing the code in solidity we can compile the code and then deploy the contract, much like we have done before.

[Deferred_Equity_deploy](Images/Deferred_Equity_deploy.png)

Once we have deployed we can check that our function works by trying to select the 'distribute' function in order to transfer 1000 shares. This, however, will give us the following error:

[Deferred_Equity_error](Images/Deferred_error.png)

This is because, in our code we have a check to make sure that the unlock_time is not less than or equal to now in order to prevent the employee from accessing or being given equity before the lockup period has expired. Rather than waiting for a year to make sure that our function works we can simply select the 'fast forward' function, which will add 400 days to the unlock_time, and thus allow the equity to be distributed. 

[Fast_forward](Images/Fast_forward.png)

Once we have done that we can once again hit the 'distribute' function. We can check to make sure it worked by selecting the 'distributed_shares' icon to make sure that a positive number of shares have been distributed out.

[Distributed_shares](Images/Distributed_shares.png)

# Deploying Contracts to Kovan Network

After compiling, deploying and testing our contracts on our local test networks, the next step is to point our MetaMask towards the Kovan network to see how, or if, the operate in the new environment. 

[Kovan_network](Images/Kovan_network.png)

Once we have confirmed that we have test ETH in our Kovan Network accounts, we can deploy the contracts the same as before and check their functionality

## Associate Profit Split - Kovan

Once we have successfully directed MetaMask to be point at the Kovan Network we should be see a 'Kovan (42) network' signature below the Injected Web3 environment. 

[Kovan_42](Images/Kovan_42.png)

If so, we can deploy the contract once again, but this time on the Kovan Network by compiling, deploying and confirming.

[Associate_kovan](Images/Associate_kovan.png)

After that, we can test the same way we did before by transferring a test value (101) of wei to each employ and making sure that 1) the transaction went through and that 2) the balance of the contract remains at zero.

[Associate_kovan_deposit](Images/Associate_kovan_deposit.png)

[Associate_kovan_tx_check](Images/Associate_kovan_tx_check.png)

[Associate_kovan_balance](Images/Associate_kovan_balance.png)

## Tier Profit Splitter

The same process will be followed for the Tiered Profit Splitter. We will recompile the code, deploy, confirm and test the functionality of the contract. The same addresses and corresponding percentages will be used here. 

[Tier_kovan](Images/Tier_kovan.png)

After successfully deploying the contract on the Kovan Network we can test our contract by sending a test amount (200) of wei and making sure that the transactions(s) go through and that their is no remaining balance in the contract, as all ETH should be distributed.

[Tier_deposit_kovan](Images/Tier_deposit_kovan.png)

[Tier_kovan_success](Images/Tier_deposit_success.png)

[Tier_kovan_balance](Images/Tier_kovan_balance.png)

