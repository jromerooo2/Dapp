// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyPunk is ERC721, ERC721Enumerable {
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