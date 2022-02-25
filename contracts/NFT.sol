pragma solidity >= 0.7.0 < 0.9.0;

import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFT is ERC721 {
    constructor() ERC721("NFT Game", "NFT") {}

    uint private _tokenId = 0;
    mapping (uint => address) tokens;

	function mint() external returns (uint) {
		_tokenId++;
		_mint(msg.sender, _tokenId);
		return _tokenId;
	}
}