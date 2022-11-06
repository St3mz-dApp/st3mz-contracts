-include .env

all: clean remove install update build

# Remove the build artifacts and cache directories
clean:; forge clean

# Remove modules
remove:; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

# Install dependencies
install:; forge install rari-capital/solmate --no-commit && forge install foundry-rs/forge-std --no-commit

# Update dependencies
update:; forge update

# Build the project's smart contract
build:; forge build

# Run the project's tests
tests:; forge test

# Get tests coverage report
coverage:; forge coverage

# Run Slither static analysis for the contract
slither:; slither src 

# Create a snapshot of each test's gas usage
snapshot:; forge snapshot

# Create flattened version of the contract
flatten:; forge flatten --output flattened/St3mz.flattened.sol src/St3mz.sol && forge flatten --output flattened/St3mzUtil.flattened.sol src/St3mzUtil.sol

# Create inheritance graph of the contract
inheritance:; slither src/St3mz.sol --print inheritance-graph && dot src/St3mz.sol.inheritance-graph.dot -Tsvg -o docs/inheritance-graph.png && xdg-open docs/inheritance-graph.png && rm src/St3mz.sol.inheritance-graph.dot

# Copy contract artifacts to frontend project directory
copy-artifacts:; cp out/St3mz.sol/St3mz.json ${FRONTEND_CONTRACTS_PATH} && cp out/St3mzUtil.sol/St3mzUtil.json ${FRONTEND_CONTRACTS_PATH}

# Show summary of the contract
summary:; slither src/St3mz.sol --print contract-summary

# Show dependencies of the contract
dependencies:; slither src/St3mz.sol --print data-dependency

# Create local testnet node
anvil:; anvil -m "${ANVIL_MNEMONIC}"

# Deploy contract to Anvil
deploy-anvil:; @forge script script/Deploy.s.sol:Deploy --rpc-url http://localhost:8545 --private-key ${ANVIL_PRIVATE_KEY} --broadcast

# Deploy contracts to Mumbai
deploy-testnet:; @forge script script/Deploy.s.sol:Deploy --rpc-url ${TESTNET_RPC_URL} --private-key ${TESTNET_PRIVATE_KEY} --broadcast --verify --etherscan-api-key ${POLYGONSCAN_API_KEY} -vvvv

# Deploy contractS to Polygon Mainnet
deploy-mainnet:; @forge script script/Deploy.s.sol:Deploy --rpc-url ${MAINNET_RPC_URL} --private-key ${MAINNET_PRIVATE_KEY} --broadcast --verify --etherscan-api-key ${POLYGONSCAN_API_KEY} -vvvv --legacy
