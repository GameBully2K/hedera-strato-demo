import { Hbar, TokenSupplyType } from "@hashgraph/sdk";
import { Account, ApiSession, Contract, Token, TokenTypes } from '@buidlerlabs/hedera-strato-js';
import pkg from '@buidlerlabs/hedera-strato-js';
const { ContractRegistry } = pkg;
import dotenv from 'dotenv';
dotenv.config();


const ContractID = process.env.CONTRACT_ID;
// const ABI = await ContractRegistry.gppgnftcontract;
// console.log(`${ABI}`);
// console.log(Object.keys(ContractRegistry))

const convertBigNumberArrayToNumberArray = (array) => array.map(item => item.toNumber());
async function connect() {
  const { session } = await ApiSession.default({ wallet: { type: "Browser" } });
  const liveJson = await session.upload(new Json({ theAnswer: 42 }));

  console.log(`Wallet account id used: ${session.wallet.account.id}`);
  console.log(`Json is stored at ${liveJson.id}`);
  console.log(`The answer is: ${liveJson.theAnswer}`);
}
//const { session } = await ApiSession.default();
const liveContract = await session.getLiveContract({
  id: ContractID,
  abi: [
    "function getClient() public view returns(address)",
    "function getBalance(address addr) public view returns(uint)",
    "function getJoinTime(address addr) public view returns(uint)",
    "function getstaked(address addr) public view returns(int64[])",
    "function getunstaked(address addr) public view returns(int64[] )",
    "function noc(int64[] arr) internal pure returns (uint)",
    "function nuc(int64[] arr) public returns(int64[])",
    "function mintNFT(uint64  amount, bytes[] _meta ) external",
    "function tokenAssociate(address _account) external",
    "function NFTTransfer(address  _sender, address  _receiver, int64[] _serialNumber) external",
    "function stake(address  _sender, int64[] _serialNumber) public",
    "function unstake(address _receiver, int64[] _serialNumber) public",
    "function addDay() public",
    "function minusDay() public",
    "function updateReward() public payable",
    "function addBonus() public payable",
    "function withdaw() public payable",
  ],
});
const bigNumberGetResult = await liveContract.nuc(
    {
        gas : 5_000_000 
    },
    [4,5,0,1,7]
);

console.log(convertBigNumberArrayToNumberArray(bigNumberGetResult));