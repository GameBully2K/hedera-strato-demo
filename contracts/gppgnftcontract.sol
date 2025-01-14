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

    constructor(/*address _client, */address _client,address _tokenAddress, address _escrow, int64 total ) {
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
            pourcentage[1] = 170;
            pourcentage[2] = 170;
            pourcentage[3] = 170;
            pourcentage[4] = 170;
            pourcentage[5] = 170;
            pourcentage[6] = 170;
            pourcentage[7] = 170;
            pourcentage[8] = 170;
            pourcentage[10] = 170;
            pourcentage[11] = 170;
            pourcentage[12] = 170;
            pourcentage[13] = 170;
            pourcentage[14] = 170;
            pourcentage[15] = 170;
            pourcentage[16] = 170;
            pourcentage[17] = 170;
            pourcentage[18] = 170;
            pourcentage[19] = 170;
            pourcentage[20] = 170;
            pourcentage[21] = 170;
            pourcentage[22] = 170;
            pourcentage[24] = 170;
            pourcentage[25] = 170;
            pourcentage[27] = 170;
            pourcentage[28] = 170;
            pourcentage[30] = 170;
            pourcentage[32] = 170;
            pourcentage[34] = 170;
            pourcentage[35] = 170;
            pourcentage[36] = 170;
            pourcentage[38] = 170;
            pourcentage[39] = 170;
            pourcentage[51] = 170;
            pourcentage[52] = 170;
            pourcentage[52] = 170;
            pourcentage[53] = 170;
            pourcentage[56] = 170;
            pourcentage[63] = 170;
            pourcentage[64] = 170;
            pourcentage[65] = 170;
            pourcentage[72] = 170;
            pourcentage[73] = 170;
            pourcentage[77] = 170;
            pourcentage[80] = 170;
            pourcentage[81] = 170;
            pourcentage[82] = 170;
            pourcentage[83] = 170;
            pourcentage[84] = 170;
            pourcentage[86] = 170;
            pourcentage[88] = 170;
            pourcentage[89] = 170;
            pourcentage[90] = 170;
            pourcentage[92] = 170;
            pourcentage[93] = 170;
            pourcentage[95] = 170;
            pourcentage[ 185 ] = 170;
            pourcentage[ 183 ] = 170;
            pourcentage[ 181 ] = 170;
            pourcentage[ 175 ] = 170;
            pourcentage[ 165 ] = 170;
            pourcentage[ 163 ] = 170;
            pourcentage[ 161 ] = 170;
            pourcentage[ 153 ] = 170;
            pourcentage[ 146 ] = 170;
            pourcentage[ 137 ] = 170;
            pourcentage[ 136 ] = 170;
            pourcentage[ 134 ] = 170;
            pourcentage[ 133 ] = 170;
            pourcentage[ 131 ] = 170;
            pourcentage[ 130 ] = 170;
            pourcentage[ 129 ] = 170;
            pourcentage[ 127 ] = 170;
            pourcentage[ 126 ] = 170;
            pourcentage[ 125 ] = 170;
            pourcentage[ 124 ] = 170;
            pourcentage[ 123 ] = 170;
            pourcentage[ 122 ] = 170;
            pourcentage[ 121 ] = 170;
            pourcentage[ 113 ] = 170;
            pourcentage[ 112 ] = 170;
            pourcentage[ 97 ] = 170;
            pourcentage[ 96 ] = 170;
            pourcentage[ 190 ] = 204;
            pourcentage[ 189 ] = 204;
            pourcentage[ 188 ] = 204;
            pourcentage[ 187 ] = 204;
            pourcentage[ 182 ] = 204;
            pourcentage[ 179 ] = 204;
            pourcentage[ 168 ] = 204;
            pourcentage[ 167 ] = 204;
            pourcentage[ 166 ] = 204;
            pourcentage[ 164 ] = 204;
            pourcentage[ 162 ] = 204;
            pourcentage[ 160 ] = 204;
            pourcentage[ 159 ] = 204;
            pourcentage[ 157 ] = 204;
            pourcentage[ 156 ] = 204;
            pourcentage[ 152 ] = 204;
            pourcentage[ 151 ] = 204;
            pourcentage[ 148 ] = 204;
            pourcentage[ 141 ] = 204;
            pourcentage[ 140 ] = 204;
            pourcentage[ 139 ] = 204;
            pourcentage[ 138 ] = 204;
            pourcentage[ 135 ] = 204;
            pourcentage[ 132 ] = 204;
            pourcentage[ 128 ] = 204;
            pourcentage[ 120 ] = 204;
            pourcentage[ 118 ] = 204;
            pourcentage[ 115 ] = 204;
            pourcentage[ 111 ] = 204;
            pourcentage[ 108 ] = 204;
            pourcentage[ 107 ] = 204;
            pourcentage[ 101 ] = 204;
            pourcentage[ 100 ] = 204;
            pourcentage[ 98 ] = 204;
            pourcentage[ 94 ] = 204;
            pourcentage[ 91 ] = 204;
            pourcentage[ 87 ] = 204;
            pourcentage[ 85 ] = 204;
            pourcentage[ 79 ] = 204;
            pourcentage[ 78 ] = 204;
            pourcentage[ 76 ] = 204;
            pourcentage[ 75 ] = 204;
            pourcentage[ 74 ] = 204;
            pourcentage[ 71 ] = 204;
            pourcentage[ 70 ] = 204;
            pourcentage[ 62 ] = 204;
            pourcentage[ 60 ] = 204;
            pourcentage[ 59 ] = 204;
            pourcentage[ 58 ] = 204;
            pourcentage[ 57 ] = 204;
            pourcentage[ 54 ] = 204;
            pourcentage[ 48 ] = 204;
            pourcentage[ 47 ] = 204;
            pourcentage[ 46 ] = 204;
            pourcentage[ 44 ] = 204;
            pourcentage[ 42 ] = 204;
            pourcentage[ 41 ] = 204;
            pourcentage[ 40 ] = 204;
            pourcentage[ 37 ] = 204;
            pourcentage[ 33 ] = 204;
            pourcentage[ 31 ] = 204;
            pourcentage[ 29 ] = 204;
            pourcentage[ 26 ] = 204;
            pourcentage[ 23 ] = 204;
            pourcentage[ 9 ] = 204;
            pourcentage[ 198 ] = 255;
            pourcentage[ 196 ] = 255;
            pourcentage[ 194 ] = 255;
            pourcentage[ 193 ] = 255;
            pourcentage[ 192 ] = 255;
            pourcentage[ 186 ] = 255;
            pourcentage[ 184 ] = 255;
            pourcentage[ 177 ] = 255;
            pourcentage[ 173 ] = 255;
            pourcentage[ 171 ] = 255;
            pourcentage[ 170 ] = 255;
            pourcentage[ 169 ] = 255;
            pourcentage[ 158 ] = 255;
            pourcentage[ 155 ] = 255;
            pourcentage[ 154 ] = 255;
            pourcentage[ 150 ] = 255;
            pourcentage[ 149 ] = 255;
            pourcentage[ 147 ] = 255;
            pourcentage[ 117 ] = 255;
            pourcentage[ 116 ] = 255;
            pourcentage[ 106 ] = 255;
            pourcentage[ 105 ] = 255;
            pourcentage[ 104 ] = 255;
            pourcentage[ 99 ] = 255;
            pourcentage[ 69 ] = 255;
            pourcentage[ 68 ] = 255;
            pourcentage[ 61 ] = 255;
            pourcentage[ 49 ] = 255;
            pourcentage[ 45 ] = 255;
            pourcentage[ 199 ] = 425 ;
            pourcentage[ 180 ] = 425 ;
            pourcentage[ 178 ] = 425 ;
            pourcentage[ 174 ] = 425 ;
            pourcentage[ 145 ] = 425 ;
            pourcentage[ 143 ] = 425 ;
            pourcentage[ 142 ] = 425 ;
            pourcentage[ 114 ] = 425 ;
            pourcentage[ 110 ] = 425 ;
            pourcentage[ 109 ] = 425 ;
            pourcentage[ 103 ] = 425 ;
            pourcentage[ 102 ] = 425 ;
            pourcentage[ 67 ] = 425 ;
            pourcentage[ 66 ] = 425 ;
            pourcentage[ 50 ] = 425 ;
            pourcentage[ 43 ] = 425 ;
            pourcentage[ 197 ] = 510 ;
            pourcentage[ 195 ] = 510 ;
            pourcentage[ 191 ] = 510 ;
            pourcentage[ 176 ] = 510 ;
            pourcentage[ 172 ] = 510 ;
            pourcentage[ 144 ] = 510 ;
            pourcentage[ 119 ] = 510 ;
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
            //add staker if not added
            
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


