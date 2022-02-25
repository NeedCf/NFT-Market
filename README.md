<h1> NFT Market </h1>
<hr>
<h3> How to run Project ? </h3>
<ul>
  <li>Install Nodejs <a href="https://nodejs.org/en/">link</a></li>
  <li>Install Ganache <a href="https://trufflesuite.com/ganache/index.html">link</a></li>
  <li>$ truffle migrate --network development</li>  
  <li>$ truffle console</li>  
  <li>Create NFT</li> 
  <ul>
    <li>$ const nft = await NFT.deployed();</li> 
    <li>$ await nft.mint({from: account[<owner of nft>]})</li> 
  </ul>
  <li>List Token to Market</li> 
  <ul>
    <li>$ const market = await Market.deployed();</li> 
    <li>$ await market.listToken(nft.address, <token Id>, {from: account[<owner of nft>]})</li> 
    <li > <p style="color:red;">Error 'ERC721: transfer caller is not owner nor approved' </p></li> 
    <li>Approve to Market and repair list Token</li> 
    <ul>
      <li>Approve to Market </li>
      <li>$ await nft.approve(market.address, <token Id>, {from: account[<owner of nft>]})</li> 
      <li>Repair list Token </li>
      <li>$ await market.listToken(nft.address, <token Id>, {from: account[<owner of nft>]})</li>
    </ul>
  </ul>
  <li>$ truffle console</li> 
  <li>$ truffle console</li> 
  
</ul>