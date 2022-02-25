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
    <li>$ await nft.mint({from: account[&lt;owner of nft&gt;]})</li> 
  </ul>
  <li>List Token to Market</li> 
  <ul>
    <li>$ const market = await Market.deployed();</li> 
    <li>$ await market.listToken(nft.address, &lt;token Id&gt;, {from: account[&lt;owner of nft&gt;]})</li> 
    <li>Error 'ERC721: transfer caller is not owner nor approved'</li> 
    <li>Approve to Market and repair list Token</li> 
    <ul>
      <li>Approve to Market </li>
      <li>$ await nft.approve(market.address, &lt;token Id&gt;, {from: account[&lt;owner of nft&gt;]})</li> 
      <li>Repair list Token </li>
      <li>$ await market.listToken(nft.address, &lt;token Id&gt;, {from: account[&lt;owner of nft&gt;]})</li>
    </ul>
  </ul>
  <li>Check NFT in Market</li> 
  <ul>
    <li>$ market.getListing(&lt;token Id in market&gt;)</li> 
  </ul>
  <li>Buy NFT in Market</li> 
  <ul>
    <li>if NFT.status == Active</li> 
    <li>$ market.buyToken(&lt;token Id&gt;, {from: accounts[&lt;account buy nft&gt;], value: &lt;price of nft&gt;})</li> 
  </ul>
  <li>Cancel NFT in Market</li> 
  <ul>
    <li>if NFT.status == Active</li> 
    <li>$ market.cancel(&lt;token Id in market&gt;, {from: accounts[&lt;account list nft to market&gt;]})</li> 
  </ul>
</ul>

