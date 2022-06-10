import { Hbar, AccountId, TokenSupplyType } from "@hashgraph/sdk";
import { Account, ApiSession, Contract, Token, TokenTypes } from '@buidlerlabs/hedera-strato-js';

import dotenv from 'dotenv';

dotenv.config();
const escrowId = AccountId.fromString(process.env.ESCROW_ID);

const convertBigNumberArrayToNumberArray = (array) => array.map(item => item.toNumber());

// Define the constants used in the demo
const nftPriceInHbar = new Hbar(10);
const maxSupply = 10
const amountToMint = 5;
const metadata = "Qmbp4hqKpwNDYjqQxsAAm38wgueSY8U2BSJumL74wyX2Dy";
const defaultNonFungibleTokenFeatures = {
    decimals: 0,
    initialSupply: 0,
    keys: {
        kyc: null
    },
    maxSupply: maxSupply,
    name: "hbarRocks",
    supplyType: TokenSupplyType.Finite,
    symbol: "HROKs",
    type: TokenTypes.NonFungibleUnique
};

// Create the CreatableEntities and the UploadableEntities
const account = new Account({ maxAutomaticTokenAssociations: 1 });
const token = new Token(defaultNonFungibleTokenFeatures);
const contract = await Contract.newFrom({ path: 'gppgnftcontract.sol' });

// Initialize the session
const { session } = await ApiSession.default();

// Build the live counterpart of the entities
const aliceLiveAccount = await session.create(account);
const liveToken = await session.create(token);
const liveContract = await session.upload(
    contract,
    { _contract: { gas: 5_000_000 } },
    liveToken,
    escrowId.toSolidityAddress(),
    10
);

// Assign supply control of the token to the live contract
liveToken.assignSupplyControlTo(liveContract);

// Register Solidity triggered events
liveContract.onEvent("NftMint", ({ tokenAddress, serialNumbers }) => {
    console.log("NFTs minted event", tokenAddress, convertBigNumberArrayToNumberArray(serialNumbers));
});

liveContract.onEvent("NftTransfer", ({ tokenAddress, from, to, serialNumbers }) => {
    console.log("NFTs transferred event", tokenAddress, convertBigNumberArrayToNumberArray(serialNumbers), from, to);
});

// Call the Solidity mint function
const serialNumbers = await liveContract.mintTo(
    {
        amount: new Hbar(nftPriceInHbar.toBigNumber().toNumber() * amountToMint).toBigNumber().toNumber(),
        gas: 5_000_000
    },
    aliceLiveAccount,
    amountToMint
);

console.log("Serial numbers minted by the smart contract", convertBigNumberArrayToNumberArray(serialNumbers));

// Query info for the involved account and contract
const aliceInfo = await aliceLiveAccount.getLiveEntityInfo();
const contractInfo = await liveContract.getLiveEntityInfo();

console.log(`Number of NFTs owned by Alice: ${aliceInfo.ownedNfts.toNumber()}`);
console.log(`HBar balance of contract: ${contractInfo.balance.toBigNumber().toNumber()}`);
