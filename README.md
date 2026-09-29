# ERC20 Token Foundry Project

A hand-written ERC20 token implementation built with Solidity and tested with Foundry. I made this while learning smart contract development, mostly to understand how ERC20 actually works instead of just importing OpenZeppelin and calling it a day

## What It Contains

- `src/token.sol` - the ERC20 contract itself
- `test/MyToken.t.sol` - Foundry tests covering the main behaviors
- `script/Deploy.s.sol` - Foundry Deployed Script
- `lib/forge-std` - Foundry's standard library (installed via `forge install`)

## About the token

The contract implements the standard ERC20 interface: `totalSupply`, `balanceOf`, `transfer`, `approve`, `allowance`, and `transferFrom`. It also has the two required events, `Transfer` and `Approval`

The constructor takes three arguments: the token name, the symbol, and the initial supply. The initial supply is multiplied by `10 ** 18` inside the constructor, so when you pass `1000` you actually get 1000 whole tokens (i.e `1000 * 10**18` in the smallest unit). All of that supply is minted to whoever deploys the contract

Decimals are hardcoded to 18, which is the convention almost every token on Ethereum follows

## Tests

The tests live in `test/MyToken.t.sol` and use `forge-std`'s `Test` contract. They cover:

- Deployment: name, symbol, decimals, total supply, and the deployer's balance
- Transfers: normal transfers, insufficient balance, transfers to the zero address, and the `Transfer` event
- Approval: setting allowances, overwriting previous allowances, approving the zero address, and the `Approval` event
- `transferFrom`: spending allowances, insufficient allowance, insufficient balance, and the special case where the allowance is `type(uint256).max` (in that case it's not reduced)

Run them with:

```bash
forge test
```

For more detail (traces, emitted events, gas), use:

```bash
forge test -vv
```

Or target a single test:

```bash
forge test --match-test test_Transfer -vvv
```

## Build

```bash
forge build
```

## A few notes on the code

- Math uses `unchecked` blocks where it is already been proven safe by a `require` above it. That is just a small gas optimization, nothing clever
- The allowance is only decremented on `transferFrom` if it isn't set to `type(uint256).max`. That's the same trick OpenZeppelin uses so users do not have to re-approve every time
- There's no `mint` or `burn`. Supply is fixed at deployment. If you want those, you will need to add them yourself
- The contract does not inherit from any interface or library. It is written from scratch on purpose, to keep the learning value

## Why I wrote this

I come from a backend background (JS, Java, Python) and I wanted to actually understand what happens inside an ERC20 rather than treating it as a black box. Writing one by hand forces you to deal with storage, visibility, `msg.sender`, events, allowances, and all the little edge cases the standard has. Once you have done it once, using OpenZeppelin feels more easy

## Future Updates

Things I plan to add or try next:

- A version that inherits from OpenZeppelin's `ERC20` so I can compare the two side by side
- `mint` and `burn` functions with an owner-only guard
- An ERC721 (NFT) following the same hand written approach
- Basic fuzz tests with Foundry's `testFuzz_` prefix

## License
MIT. See the SPDX header in the source files

---
`Tizih Mark Marko`
`29/09/2026`