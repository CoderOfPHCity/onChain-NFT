// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    mapping(uint256 => uint256) public tokenIdToLevels;

    constructor() ERC721("OnChainNFT", "OCN") {}

    function simplifiedFormatTokenURI(string memory imageURI)
        public
        pure
        returns (string memory)
    {
        string memory baseURL = "data:application/json;base64,data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/Pgo8IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDEuMS8vRU4iICJodHRwOi8vd3d3LnczLm9yZy9HcmFwaGljcy9TVkcvMS4xL0RURC9zdmcxMS5kdGQiID4KCjwhLS0gTGljZW5zZTogUEQuIE1hZGUgYnkgcGZlZmZlcmxlOiBodHRwczovL2dpdGh1Yi5jb20vcGZlZmZlcmxlL29wZW53ZWJpY29ucyAtLT4KPHN2ZyB3aWR0aD0iNDAwcHgiIGhlaWdodD0iNDAwcHgiIHZpZXdCb3g9Ii0xMCAtNSAxMDM0IDEwMzQiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHZlcnNpb249IjEuMSI+CiAgIDxwYXRoIGZpbGw9IiMwMDAwMDAiCmQ9Ik00OTcgMTc3cS05NSAxIC0xNzkuNSA0MS41dC0xNDQuNSAxMTEuNXEtNjIgNzUgLTg1IDE2OXEtMjggMTEyIDQgMjIycTMxIDEwNyAxMTEgMTg1cTgyIDgwIDE5NCAxMDh0MjIyIC00cTEwNyAtMzIgMTg1IC0xMTFxODAgLTgyIDEwOCAtMTk0dC00IC0yMjNxLTMyIC0xMDYgLTExMSAtMTg0cS04MiAtODEgLTE5NCAtMTA4cS01MyAtMTQgLTEwNiAtMTN6TTQ4MyAzMjVsNDYgMTJsLTE5IDc1bDM4IDhsMTggLTc0bDQ3IDExbC0xOSA3NwpxNDkgMTcgNzIgNDBxMjcgMjggMjEgNjdxLTggNTcgLTU5IDY5cTMzIDE3IDQ0IDQzcTEzIDI5IC0xIDcwcS0xOCA1MCAtNjIgNjRxLTM3IDExIC0xMDMgLTFsLTE5IDc3bC00NyAtMTJsMTkgLTc2bC0zNyAtOWwtMTkgNzZsLTQ3IC0xMWwyMCAtNzhsLTk0IC0yNGwyMyAtNTNsMTcgNXExNyA0IDE3IDNxMTUgNCAyMSAtMTFsMzEgLTEyMmw1IDFsLTUgLTFsMjEgLTg4cTIgLTIxIC0yMSAtMjdsLTM0IC04djBsMTIgLTUwbDY1IDE2aC0xbDMwIDh6Ck00OTggNDY3bC0yMyA5M2w3IDJxNDEgMTEgNjQgMTBxNDEgMCA0OSAtMzJ0LTI3IC01MXEtMTkgLTExIC02MSAtMjB6TTQ2MyA2MDdsLTI2IDEwMmw5IDNxNTAgMTMgNzcgMTNxNDkgMCA1OCAtMzV0LTM0IC01N3EtMjMgLTEyIC03MyAtMjR6IiAvPgo8L3N2Zz4=";
        string memory json = string(
            abi.encodePacked(
                '{"name": "LCM ON-CHAINED", "description": "A simple SVG based on-chain NFT", "image":"',
                imageURI,
                '"}'
            )
        );
        string memory jsonBase64Encoded = Base64.encode(bytes(json));
        return string(abi.encodePacked(baseURL, jsonBase64Encoded));
    }

    function mint(string memory imageURI) public {
        /* Encode the SVG to a Base64 string and then generate the tokenURI */
        // string memory imageURI = svgToImageURI(svg);
        string memory tokenURI = simplifiedFormatTokenURI(imageURI);

        /* Increment the token id everytime we call the mint function */
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();

        /* Mint the token id and set the token URI */
        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
    }
}