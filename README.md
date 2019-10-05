# Pentesting Ethereum Contracts
### Exploring a honeypot contract using **[ganache-cli](https://github.com/trufflesuite/ganache-cli)**

## Background

In [this](https://www.reddit.com/r/ethdev/comments/7x5rwr/tricked_by_a_honeypot_contract_or_beaten_by/) `/r/ethdev` post, [/u/CurrencyTycoon](https://www.reddit.com/u/CurrencyTycoon) describes his attempt to exploit a contract with a _re-entrancy_ attack. Little did he know, the contract was a **[honeypot](https://en.wikipedia.org/wiki/Honeypot_(computing))**.

This repository attempts to demonstrate that honeypot using the forking feature of [ganache-cli](https://github.com/trufflesuite/ganache-cli) and Ganache UI. Ganache is a fast, lightweight development blockchain, and is part of the [Truffle Suite](https://trufflesuite.com/).

Disclosure: We maintain Ganache.


## Explanation

There are two ways the contracts can be run: `local`, and `forked`.

### Local

When running in `local` mode, we deploy **both** the target to exploit and the exploit contract to our local blockchain created by Ganache. For the target to exploit, we use the contract code _as displayed_ on [etherscan.io](https://etherscan.io/address/0x95d34980095380851902ccd9a1fb4c813c2cb639#code) (note: we have updated our version of the contract to use a newer Solidity version).

### Forked

When running in `forked` mode, we only need to deploy the exploit contract and we'll use Ganache to _fork_ mainnet.
Navigate to [migrations/2_bank.js](migrations/2_bank.js) and [migrations/3_exploit.js](migrations/3_exploit.js) to see how this is accomplished.

For details about the honeypot contract itself, see the [reddit post](https://www.reddit.com/r/ethdev/comments/7x5rwr/tricked_by_a_honeypot_contract_or_beaten_by/) which inspired this repo, and Alex Sherbuck's writeup on how the honeypot contract works in this [Medium blog post](https://medium.com/@alexsherbuck/dissecting-an-ethereum-honey-pot-7102d7def5e0).


To understand how it all works, see the exploit contract in [contracts/BadGuyContract.sol](contracts/BadGuyContract.sol), and the test in [test/exploit.js](test/exploit.js).

## Usage

This is a node.js project. If you don't already have node.js installed, I highly recommend installing it with [NVM](https://github.com/creationix/nvm). See the README page there for instructions.

Make sure to install project dependencies by running `npm install` in the root directory of this repo.

### Local Mode
To run in [local](#local) mode, open two terminals:
- In one terminal, run:
```bash
npm run local_testnet
```
- In the other terminal, run
```bash
npm run local_migrate && npm run local_test
```
**NOTE**: because this `local` mode uses the contract code _as displayed_ on [etherscan.io](https://etherscan.io/address/0x95d34980095380851902ccd9a1fb4c813c2cb639#code) our _re-entrancy_ exploit succeeds!

### Forked Mode
To run in [forked](#forked) mode, open two terminals:
- In one terminal, run:
```bash
npm run forked_testnet
```
- In the other terminal, run:
```bash
npm run forked_migrate && npm run forked_test
```
**Note**: This test _should_ fail.  Because the actual code deployed to mainnet is not vulnerable to re-entrancy.
