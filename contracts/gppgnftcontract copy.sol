// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.7.0 <0.9.0;
pragma experimental ABIEncoderV2;

import "./hip-206/HederaTokenService.sol";
import "./hip-206/HederaResponseCodes.sol";


contract gppgnftcontract is HederaTokenService {

    address admin;
    address client;
    address tokenAddress;
    address[] escrow;
    int64 nftTotalSupply;
    address[] stakers;
    uint startTime;
    mapping (address => uint) joinTime;
    mapping (int64 => address) staking;
    mapping (address => uint) balance;
    mapping (address => int64[]) public staked;
    mapping (address => int64[]) public unstaked;
    bool public customRates;
    mapping (int64 => uint) public pourcentage;

    //since solidity still doesn't permit you to have optional parametres I will hard set the percentages for the nft ranks manully

    constructor(address _client,address _tokenAddress, address _escrow, int64 total ) {
        tokenAddress = _tokenAddress;
        escrow.push(_escrow);
        nftTotalSupply = total;
        startTime = block.timestamp;
        admin = msg.sender;
        client =  _client;

        //since solidity still doesn't permit you to have optional parametres
        //I will hard set the percentages for the nft ranks manully
        // this is just to speed things up but for scalibility or/and providing staking as a service for other creators a function is put in place
        customRates = true;
        {
            
            pourcentage[ 166 ] = 262 ;
            pourcentage[ 162 ] = 262 ;
            pourcentage[ 160 ] = 262 ;
            pourcentage[ 158 ] = 262 ;
            pourcentage[ 155 ] = 262 ;
            pourcentage[ 154 ] = 262 ;
            pourcentage[ 153 ] = 262 ;
            pourcentage[ 152 ] = 262 ;
            pourcentage[ 149 ] = 262 ;
            pourcentage[ 143 ] = 262 ;
            pourcentage[ 141 ] = 262 ;
            pourcentage[ 140 ] = 262 ;
            pourcentage[ 139 ] = 262 ;
            pourcentage[ 138 ] = 262 ;
            pourcentage[ 135 ] = 262 ;
            pourcentage[ 134 ] = 262 ;
            pourcentage[ 128 ] = 262 ;
            pourcentage[ 123 ] = 262 ;
            pourcentage[ 121 ] = 262 ;
            pourcentage[ 118 ] = 262 ;
            pourcentage[ 117 ] = 262 ;
            pourcentage[ 116 ] = 262 ;
            pourcentage[ 114 ] = 262 ;
            pourcentage[ 113 ] = 262 ;
            pourcentage[ 112 ] = 262 ;
            pourcentage[ 108 ] = 262 ;
            pourcentage[ 106 ] = 262 ;
            pourcentage[ 105 ] = 262 ;
            pourcentage[ 102 ] = 262 ;
            pourcentage[ 99 ] = 262 ;
            pourcentage[ 98 ] = 262 ;
            pourcentage[ 96 ] = 262 ;
            pourcentage[ 95 ] = 262 ;
            pourcentage[ 94 ] = 262 ;
            pourcentage[ 93 ] = 262 ;
            pourcentage[ 92 ] = 262 ;
            pourcentage[ 90 ] = 262 ;
            pourcentage[ 89 ] = 262 ;
            pourcentage[ 84 ] = 262 ;
            pourcentage[ 83 ] = 262 ;
            pourcentage[ 81 ] = 262 ;
            pourcentage[ 79 ] = 262 ;
            pourcentage[ 78 ] = 262 ;
            pourcentage[ 77 ] = 262 ;
            pourcentage[ 76 ] = 262 ;
            pourcentage[ 75 ] = 262 ;
            pourcentage[ 73 ] = 262 ;
            pourcentage[ 70 ] = 262 ;
            pourcentage[ 68 ] = 262 ;
            pourcentage[ 67 ] = 262 ;
            pourcentage[ 64 ] = 262 ;
            pourcentage[ 63 ] = 262 ;
            pourcentage[ 62 ] = 262 ;
            pourcentage[ 60 ] = 262 ;
            pourcentage[ 58 ] = 262 ;
            pourcentage[ 57 ] = 262 ;
            pourcentage[ 56 ] = 262 ;
            pourcentage[ 55 ] = 262 ;
            pourcentage[ 53 ] = 262 ;
            pourcentage[ 49 ] = 262 ;
            pourcentage[ 48 ] = 262 ;
            pourcentage[ 46 ] = 262 ;
            pourcentage[ 43 ] = 262 ;
            pourcentage[ 39 ] = 262 ;
            pourcentage[ 37 ] = 262 ;
            pourcentage[ 34 ] = 262 ;
            pourcentage[ 33 ] = 262 ;
            pourcentage[ 31 ] = 262 ;
            pourcentage[ 29 ] = 262 ;
            pourcentage[ 28 ] = 262 ;
            pourcentage[ 27 ] = 262 ;
            pourcentage[ 22 ] = 262 ;
            pourcentage[ 21 ] = 262 ;
            pourcentage[ 20 ] = 262 ;
            pourcentage[ 17 ] = 262 ;
            pourcentage[ 16 ] = 262 ;
            pourcentage[ 15 ] = 262 ;
            pourcentage[ 14 ] = 262 ;
            pourcentage[ 9 ] = 262 ;
            pourcentage[ 5 ] = 262 ;
            pourcentage[ 4 ] = 262 ;
            pourcentage[ 3 ] = 262 ;
            pourcentage[ 2 ] = 262 ;
            pourcentage[ 163 ] = 314 ;
            pourcentage[ 161 ] = 314 ;
            pourcentage[ 159 ] = 314 ;
            pourcentage[ 145 ] = 314 ;
            pourcentage[ 142 ] = 314 ;
            pourcentage[ 137 ] = 314 ;
            pourcentage[ 131 ] = 314 ;
            pourcentage[ 129 ] = 314 ;
            pourcentage[ 127 ] = 314 ;
            pourcentage[ 126 ] = 314 ;
            pourcentage[ 125 ] = 314 ;
            pourcentage[ 124 ] = 314 ;
            pourcentage[ 115 ] = 314 ;
            pourcentage[ 110 ] = 314 ;
            pourcentage[ 107 ] = 314 ;
            pourcentage[ 104 ] = 314 ;
            pourcentage[ 103 ] = 314 ;
            pourcentage[ 101 ] = 314 ;
            pourcentage[ 88 ] = 314 ;
            pourcentage[ 87 ] = 314 ;
            pourcentage[ 86 ] = 314 ;
            pourcentage[ 85 ] = 314 ;
            pourcentage[ 74 ] = 314 ;
            pourcentage[ 72 ] = 314 ;
            pourcentage[ 66 ] = 314 ;
            pourcentage[ 65 ] = 314 ;
            pourcentage[ 59 ] = 314 ;
            pourcentage[ 50 ] = 314 ;
            pourcentage[ 45 ] = 314 ;
            pourcentage[ 44 ] = 314 ;
            pourcentage[ 40 ] = 314 ;
            pourcentage[ 38 ] = 314 ;
            pourcentage[ 35 ] = 314 ;
            pourcentage[ 32 ] = 314 ;
            pourcentage[ 30 ] = 314 ;
            pourcentage[ 26 ] = 314 ;
            pourcentage[ 24 ] = 314 ;
            pourcentage[ 23 ] = 314 ;
            pourcentage[ 8 ] = 314 ;
            pourcentage[ 6 ] = 314 ;
            pourcentage[ 164 ] = 393 ;
            pourcentage[ 157 ] = 393 ;
            pourcentage[ 148 ] = 393 ;
            pourcentage[ 147 ] = 393 ;
            pourcentage[ 146 ] = 393 ;
            pourcentage[ 132 ] = 393 ;
            pourcentage[ 130 ] = 393 ;
            pourcentage[ 122 ] = 393 ;
            pourcentage[ 120 ] = 393 ;
            pourcentage[ 119 ] = 393 ;
            pourcentage[ 111 ] = 393 ;
            pourcentage[ 97 ] = 393 ;
            pourcentage[ 91 ] = 393 ;
            pourcentage[ 82 ] = 393 ;
            pourcentage[ 80 ] = 393 ;
            pourcentage[ 71 ] = 393 ;
            pourcentage[ 69 ] = 393 ;
            pourcentage[ 54 ] = 393 ;
            pourcentage[ 36 ] = 393 ;
            pourcentage[ 19 ] = 393 ;
            pourcentage[ 12 ] = 393 ;
            pourcentage[ 11 ] = 393 ;
            pourcentage[ 7 ] = 393 ;
            pourcentage[ 1 ] = 393 ;
            pourcentage[ 165 ] = 655 ;
            pourcentage[ 156 ] = 655 ;
            pourcentage[ 151 ] = 655 ;
            pourcentage[ 150 ] = 655 ;
            pourcentage[ 144 ] = 655 ;
            pourcentage[ 133 ] = 655 ;
            pourcentage[ 109 ] = 655 ;
            pourcentage[ 100 ] = 655 ;
            pourcentage[ 51 ] = 655 ;
            pourcentage[ 42 ] = 655 ;
            pourcentage[ 13 ] = 655 ;
            pourcentage[ 10 ] = 655 ;
            pourcentage[ 136 ] = 786 ;
            pourcentage[ 61 ] = 786 ;
            pourcentage[ 52 ] = 786 ;
            pourcentage[ 41 ] = 786 ;
            pourcentage[ 25 ] = 786 ;
            pourcentage[ 18 ] = 786 ;
        }
    }
    fallback () external payable {
        // No fallback code yet
    }
    receive() external payable {
        // No receiving code yet
    }
    
    modifier onlyClient() {
        require(msg.sender == client, "Client only");
        _;
    }
    
    modifier adminClient() {
        require(msg.sender == client || msg.sender == admin, "Client or admin only");
        _;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Admin only");
        _;
    }
    function getClient() public view returns(address add) {
        return client;
    }
    function getBalance(address addr) public view returns(uint) {
        return balance[addr];
    }

    function getJoinTime(address addr) public view returns(uint) {
        return joinTime[addr];
    }

    function getstaked(address addr) public returns(int64[] memory) {
        return nuc(staked[addr]);
    } 
    
    //the use of this function is not mendatory in the frontend it just makes sense to add it
    function getunstaked(address addr) public returns(int64[] memory) {
        return nuc(unstaked[addr]);
    }

    // this function count array length for populated fields
    function noc(int64[] memory arr) internal pure returns (uint r) {
        for (uint i = 0 ; i < arr.length ; i++) {
            if (arr[i] > 0) r++;
        }
    }

    
    //nuc takes an array and nucs the zeros
    int64[] nuked;
    function nuc(int64[] memory arr) internal returns(int64[] memory) {
        for (uint i = 0 ; i < nuked.length; i++) {
            nuked.pop();
        }
        for (uint i = 0 ; i < arr.length; i++) {
            if (arr[i] != 0) nuked.push(arr[i]);
        }
        return nuked;
    }

    // int64[] nuked;
    // function nuc(int64[] memory arr) public returns(int64[] memory) {
    //     for (uint i = 0 ; i < nuked.length; i++) {
    //         nuked.pop();
    //     }
    //     for (uint i = 0 ; i < arr.length; i++) {
    //         if (arr[i] != 0) nuked.push(arr[i]);
    //     }
    //     return nuked;
    // }

    // function deleteunstacked(address _stacker, int64[] memory _serialNumber) internal {
        
    // }

    function mintNFT(uint64  amount, bytes[] memory _meta ) external {
        (int response,,) = HederaTokenService.mintToken(tokenAddress, amount, _meta );
        if (response != HederaResponseCodes.SUCCESS) {
            revert ("Mint Failed");
        }
    }

    function tokenAssociate(address _account) external {
        int response = HederaTokenService.associateToken(_account, tokenAddress);

        if (response != HederaResponseCodes.SUCCESS) {
            revert ("Associate Failed");
        }
    }
    address[] sens;
    address[] recs;
    function NFTTransfer(address  _sender, address  _receiver, int64[] memory _serialNumber) external {        
        sens.push(_sender);
        recs.push(_receiver);
        int response = HederaTokenService.transferNFTs(tokenAddress, sens, recs, _serialNumber);

        if (response != HederaResponseCodes.SUCCESS) {
            
        }
        sens.pop();
        recs.pop(); 
    }

    function enableCustomRates() public adminClient {
        customRates = true;
    }

    /**
        add custo rate for each serial number
        choose newgen as false if you want just to edit a previous entry
     */
    function addCutsomRates (int64[] memory serialNumbers, uint[] memory pourcentages) public adminClient {
        customRates = true;
        for (uint i=0; i< serialNumbers.length;i++) {
            pourcentage[serialNumbers[i]]=pourcentages[i]*1000;
        }
    }
    
    function disableCustomRates() public adminClient {
        customRates = false;
    }

    function stake( address  _sender, int64[] memory _serialNumber) public {
        require(_serialNumber[0] != 0,"No NFTs selected");
        sens.push(_sender);
        int response = HederaTokenService.transferNFTs(tokenAddress, sens, escrow , _serialNumber);
        if (response != HederaResponseCodes.SUCCESS) {
            revert ('Transfer Failed');
            
        }
        bool exist = false;
        for (uint i=0; i < stakers.length; i++) {
            if (stakers[i] == _sender) exist=true;
        }
        if (!exist) {
            stakers.push(_sender);
            joinTime[_sender] = block.timestamp;
            }
        //linking staked assets with staker address
        for (uint i=0; i < _serialNumber.length ; i++) {
            staking[_serialNumber[i]]=_sender;
            staked[_sender].push(_serialNumber[i]);
        }

        int64[] memory num  = unstaked[_sender];
        for (uint i=0;i < num.length; i++) {
            for (uint j=0; j < _serialNumber.length; j++) {
                if (num[i] == _serialNumber[j]) delete unstaked[_sender][i];
            }
        }
        sens.pop();
        
    }

    function unstake( address  _receiver, int64[] memory _serialNumber) public {
        recs.push(_receiver);
        int response = HederaTokenService.transferNFTs(tokenAddress, escrow, recs , _serialNumber);
        if (response != HederaResponseCodes.SUCCESS) {
            revert ('Transfer Failed');
        }
        require(_serialNumber[0] != 0,"No NFTs selected");
            
        for (uint i=0; i < _serialNumber.length; i++) {
            staking[_serialNumber[i]]= 0x0000000000000000000000000000000000000000;
            unstaked[_receiver].push(_serialNumber[i]);
        }

        //deleteunstacked(_receiver,_serialNumber);
        for (uint j = 0 ; j < staked[_receiver].length ; j++) {
            for (uint i =0 ; i < _serialNumber.length ; i++) {
                if (staked[_receiver][j] == _serialNumber[i]) {
                    staked[_receiver][j] = 0;
                }
            }
        }

        //removing the stacker if he doen't have any staked assets
        if (noc(staked[_receiver]) == 0) {
            uint no = stakers.length-1;
            for (uint i=0; i < stakers.length; i++) {
                if (stakers[i] == _receiver) {
                    stakers[i] = stakers[no];
                    stakers.pop();
                }
            }
        }
        recs.pop();
    }

    uint weekcount;
    uint daycount;
    function addDay () public {
        daycount++;
    }
    
    function minusDay () public {
        daycount--;
    }

    function updateReward() public payable {
        uint amount = msg.value;
        uint share;
        if (!customRates) {
            for ( uint i = 0 ; i < stakers.length; i++) {
                share = noc(staked[stakers[i]]) *100;
                share = (share / stakers.length);
                balance[stakers[i]] += (amount*share)/100;
            }
            //since did function updates daily
            daycount++;
            // uint o = weekcount;
            // weekcount = daycount%7;
            // weekcount = daycount - weekcount;    //switched from weekly to dayli
            // weekcount = weekcount / 7;
            // if (o != weekcount) {
            for ( uint i = 0 ; i < stakers.length; i++) {withdrawed[stakers[i]] = false;}
            // }
        } else {
            uint totalPercentages;
            for (uint i =0 ; i < stakers.length; i++) {
                for (uint j = 0; j < staked[stakers[i]].length ; j++) {
                    if (staked[stakers[i]][j] != 0) {
                        totalPercentages += pourcentage[staked[stakers[i]][j]];
                    }
                }
            }
            for (uint i = 0; i < stakers.length; i++) {
                share = 0;
                for (uint j = 0; j < staked[stakers[i]].length ; j++) {
                    if (staked[stakers[i]][j] != 0) {
                        share += pourcentage[staked[stakers[i]][j]];
                    }
                }
                share = (share * 10000) / totalPercentages;
                share = share/100;
                balance[stakers[i]] += (amount*share)/1000;
            }
            
            daycount++;
            for ( uint i = 0 ; i < stakers.length; i++) {withdrawed[stakers[i]] = false;}
        }
    }

    function addBonus() public payable {
        uint amount = msg.value;
        uint share;
        for ( uint i = 0 ; i < stakers.length; i++) {
            share = noc(staked[stakers[i]]) *100;
            share = (share / stakers.length);
            balance[stakers[i]] += (amount*share)/100;
        }
    }

    mapping (address => bool) withdrawed;

    function withdaw() public payable {
        require (block.timestamp - (joinTime[msg.sender] ) > 604800);
        require (!withdrawed[msg.sender],"You already Withdrawed");
        withdrawed[msg.sender] = true;
        (bool os, ) = payable(msg.sender).call{value: balance[msg.sender] }("");
            require(os);
    }
    
    //withdraw function
    



}


