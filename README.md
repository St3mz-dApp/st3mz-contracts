# St3mz Smart Contracts

## Contracts



|         | St3mz | St3mzUtil |
| ------- |:--------:|:-----:|
| **Testnet**  | [0x0](https://testnet.ftmscan.com/address/0x0#code) | [0x0](https://testnet.ftmscan.com/address/0x0#code) |
| **Mainnet** | [0x0](https://ftmscan.com/address/0x0#code) | [0x0](https://ftmscan.com/address/0x0#code) |

## Setup

This project has been created with [**Foundry**](https://github.com/foundry-rs/foundry).

See the official Foundry installation [instructions](https://github.com/gakonst/foundry/blob/master/README.md#installation).

Then, install the [foundry](https://github.com/gakonst/foundry) toolchain installer (`foundryup`) with:

```bash
curl -L https://foundry.paradigm.xyz | bash
```

Now that you've installed the `foundryup` binary, anytime you need to get the latest `forge` or `cast` binaries, you can run:

```bash
foundryup
```

## Commands

| Description                               |        Command        |
| ----------------------------------------- | :-------------------: |
| Install dependencies                      |    `make install`     |
| Update dependencies                       |     `make update`     |
| Build all smart contracts                 |     `make build`      |
| Remove artifacts and cache directories    |     `make clean`      |
| Remove modules                            |     `make remove`     |
| Run all tests                             |     `make tests`      |
| Get tests coverage report                 |    `make coverage`    |
| Run Slither static analysis               |    `make slither`     |
| Create snapshot of each test's gas usage  |    `make snapshot`    |
| Create flattened version of the contracts |    `make flatten`     |
| Create inheritance graph of the contracts |  `make inheritance`   |
| Copy artifacts to frontend project        | `make copy-artifacts` |
| Show summary of the contracts             |    `make summary`     |
| Show dependencies of the contracts        |  `make dependencies`  |
| Create local testnet node                 |     `make anvil`      |
| Deploy contracts to Anvil                 |  `make deploy-anvil`  |
| Deploy contracts to Testnet               | `make deploy-testnet` |
| Deploy contracts to Mainnet               | `make deploy-mainnet` |

## License

Distributed under the MIT License. See [LICENSE](LICENSE) for more information.
