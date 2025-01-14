// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./hip-206/IHederaTokenService.sol";
import "./hip-206/HederaResponseCodes.sol";

// @title NFTShop - a simple minting and transferring contract
// @author Buidler Labs
// @dev The functions implemented make use of Hedera Token Service precompiled contract
contract NFTShop is HederaResponseCodes {

    // @dev Hedera Token Service precompiled address
    address constant precompileAddress = address(0x167);

    // @dev The address of the Non-Fungible token
    address tokenAddress;

    // @dev The address of the token treasury, the address which receives tokens once they are minted
    address tokenTreasury;

    // @dev The price for a mint
    uint64 mintPrice;

    // @dev The metadata which the minted tokens will contain
    bytes metadata;

    // @dev Constructor is the only place where the tokenAddress, tokenTreasury, mintPrice and metadata are being set
    constructor(
        address _tokenAddress,
        address _tokenTreasury,
        uint64 _mintPrice,
        bytes memory _metadata
    ) {
        tokenAddress = _tokenAddress;
        tokenTreasury = _tokenTreasury;
        mintPrice = _mintPrice;
        metadata = _metadata;
    }

    // @notice Error used when reverting the minting function if it doesn't receive the required payment amount
    error InsufficientPay();

    // @dev Error used to revert if an error occured during HTS mint
    error MintError(int32 errorCode);

    // @dev Error used to revert if an error occured during HTS transfer
    error TransferError(int32 errorCode);

    // @dev event used if a mint was successful
    event NftMint(address indexed tokenAddress, int64[] serialNumbers);

    // @dev event used after tokens have been transferred
    event NftTransfer(
        address indexed tokenAddress,
        address indexed from,
        address indexed to,
        int64[] serialNumbers
    );

    // @dev Modifier to test if while minting, the necessary amount of hbars is paid
    modifier isPaymentCovered(uint256 pieces) {
        if (uint256(mintPrice) * pieces > msg.value) {
            revert InsufficientPay();
        }
        _;
    }

    // @dev Main minting and transferring function
    // @param to The address to which the tokens are transferred after being minted
    // @param amount The number of tokens to be minted
    // @return The serial numbers of the tokens which have been minted
    function mint(address to, uint256 amount)
        external
        payable
        isPaymentCovered(amount)
        returns (int64[] memory)
    {
        bytes[] memory nftMetadatas = generateBytesArrayForHTS(
            metadata,
            amount
        );

        (bool success, bytes memory result) = precompileAddress.call(
            abi.encodeWithSelector(
                IHederaTokenService.mintToken.selector,
                tokenAddress,
                0,
                nftMetadatas
            )
        );
        (int32 responseCode, , int64[] memory serialNumbers) = success
            ? abi.decode(result, (int32, uint64, int64[]))
            : (HederaResponseCodes.UNKNOWN, 0, new int64[](0));

        if (responseCode != HederaResponseCodes.SUCCESS) {
            revert MintError(responseCode);
        }

        emit NftMint(tokenAddress, serialNumbers);

        address[] memory tokenTreasuryArray = generateAddressArrayForHTS(
            tokenTreasury,
            amount
        );

        address[] memory minterArray = generateAddressArrayForHTS(to, amount);

        (bool successTransfer, bytes memory resultTransfer) = precompileAddress
            .call(
                abi.encodeWithSelector(
                    IHederaTokenService.transferNFTs.selector,
                    tokenAddress,
                    tokenTreasuryArray,
                    minterArray,
                    serialNumbers
                )
            );
        responseCode = successTransfer
            ? abi.decode(resultTransfer, (int32))
            : HederaResponseCodes.UNKNOWN;

        if (responseCode != HederaResponseCodes.SUCCESS) {
            revert TransferError(responseCode);
        }

        emit NftTransfer(tokenAddress, tokenTreasury, to, serialNumbers);

        return serialNumbers;
    }

    // @dev Helper function which generates array of addresses required for HTSPrecompiled
    function generateAddressArrayForHTS(address _address, uint256 _items)
        internal
        pure
        returns (address[] memory _addresses)
    {
        _addresses = new address[](_items);
        for (uint256 i = 0; i < _items; i++) {
            _addresses[i] = _address;
        }
    }

    // @dev Helper function which generates array required for metadata by HTSPrecompiled
    function generateBytesArrayForHTS(bytes memory _bytes, uint256 _items)
        internal
        pure
        returns (bytes[] memory _bytesArray)
    {
        _bytesArray = new bytes[](_items);
        for (uint256 i = 0; i < _items; i++) {
            _bytesArray[i] = _bytes;
        }
    }

    
    mapping (address => int64[]) public staked;
    address add = 0x0000000000000000000000000000000000000001;

    int64[] nuked;
    function nuc(int64[] memory arr) public returns(int64[] memory) {
        nuked = arr;
        for (uint i = 0 ; i < nuked.length; i++) {
            if (nuked[i] == 0) {
                while (nuked[i] == 0) {
                    nuked[i] = nuked[nuked.length-1];
                    nuked.pop();
                }
            }
        }
        return nuked;
        
    }
}
