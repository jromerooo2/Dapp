// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Base64.sol";
import "./DNAContract.sol";

contract MyPunk is ERC721, ERC721Enumerable, DNAContract {
    using Counters for Counters.Counter;

    Counters.Counter private _idCounter;
    
    uint256 public MaxSupply;

    constructor(uint256 _maxSupply) ERC721("MY punk", "PLPKS") {
        MaxSupply = _maxSupply;
    }
    
    function mint() public{
        uint256 current = _idCounter.current();
        require(current < MaxSupply, "Max supply reached");
        _safeMint(msg.sender, current);
        _idCounter.increment();
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        require(_exists(_tokenId), "ERC721 Metadata: URI query for notexistant");
        
        string memory jsonURI = Base64.encode(
            abi.encodePacked(
                '{ "name": "PlatziPunks #',
                _tokenId,
                '", "description": "Platzi Punks are randomized Avataaars stored on chain to teach DApp development on Platzi", "image": "',
                "// TODO: Calculate image URL",
                '"attributes": [{"Accessories Type": "Blank" ,"Clothe Color": "Red","Clothe Type":"Hoodie","Eye Type":"Close","Eye Brow Type":"Angry","Facial Hair Color":"Blonde","Facial Hair Type":"MoustacheMagnum","Hair Color":"SilverGray","Hat Color":"white","Graphic Type":"Skull","Mouth Type":"Smile","Skin Color":"Light","Top Type":"LongHairMiaWallace",}]',
                '"}'
            )
        );
        return string(abi.encodePacked("data:application/json;base64,",jsonURI));
    }


    //override required
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}