//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

//here is the internal import for nft openzeppelin
import "@openzeppelin/contracts/utils/Counters.sol"; // using these as a counter  counter=track(how many nft is sold,how many get purchase)
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "hardhat/console.sol";



contract NFTMarketplace is ERC721URIStorage{
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds; //it will keep the track how many token is are listed
    Counters.Counter private _itemsSold; //it will keep the track of how many items got sold

    uint256 listingPrice = 0.0020 eth;

    address payable owner;

    mapping(uint256=> MarketItem) private idMarketItem; //mapping is the items of key and values

    struct MarketItem{
        uint256 tokenId;
        address payable seller;
        address payable owner; //the one who will get the nft on marketplace
        uint256 price; //price of nft
        bool sold;  //track the status whether the nft is sold or not
    }
    events idMarketItemCreated(
        uint256 indexed tokenId,
        address seller,
        address owner,
        uint256 price,
        bool sold
    );
//for swttinf the condition
modifier onlyOwner{
    require(
        msg.sender == owner,
        "only contract owner can change the nft listing price"
        );
        _;
}

//it's the special type of function that are called once...name and for the symbols
    constructor() ER721("NFT Metaverse Token","MYNFT"){
        Owner==payable(msg.sender);  //smart contract owner who is calling the contract
    }

    function updateListingPrice(uint256 _listingPrice) public payable onlyOwner{
        listingPrice = _listingPrice;
    } 

    function getListingPrice() public view returns(uint256){
        return listingPrice;
    }

    //here we create "create nft token function"
//tokenURI is the url of nft when someone will upload the nft we'll get the url of nft
    function createToken(string memory tokenURI(),uint256 price) public payable returns(uint256){
        _tokenIds.increment(); //if someone will create nft this token id will get increased

        uint256 newTokenId = _tokenIds.current();

        _mint(msg.sender, newTokenId); //we've taken these mint function from openzeppelin
        _setTokenURI(newTokenId,tokenURI);

        createMarketItem(newTokenId, price);

        return newTokenId;
    }

    //this function will create the nft and all the detail of nft
    //private= only to the owner of the contract

    function createMarketItem(uint256 tokenId, uint256 price) private{
        require(price >0 ,"price must be atleat 1");
        require(msg.value==listingPrice,"Price must be equal to listing price");

 // this will identify which item is getting created
        idMarketItem[tokenId]= MarketItem(
            tokenId;
            payable(msg.sender),
            payable(address(this)),
            price,
            false, //currently the nft is not sold that is why the status should be false
        );     

        //now we have to send the nft from the msg.sender to the contarct

        _transfer(msg.sender,address(this),tokenId);
//we have created events now when the transfer of token takes place we have to call the events
        emit idMarketItemCreated(
            tokenId,
            msg.sender,
            address(this),
            price,
            false
            );                           
    }

    //this is the function resale token
    function reSellToken(uint256 tokenId,uint256 price) public payable {
        require(idMarketItem[tokenId].owner == msg.sender,"Only item owner can perform this");
        //we have to make comission if someone is using our application
        require(msg.value== listingPrice,"Price must be equal to the listingPrice");

        idMarketItem[tokenId].sold= false;
        idMarketItem[tokenId].price= price;
        idMarketItem[tokenId].seller= payable(msg.sender);
        idMarketItem[tokenId].owner= payable(address(this));

        _itemSold.decrement(); //when someone will resell the nft this no. will go down

        _transfer(msg.sender,address(this),tokenId);
    }

    //this function is for createmarketsale

    function createMarketSale(uint256 tokenId) public payable{
        uint256 price = idMarketItem[tokenId].price;
//if someone want to buy the nft the user has the asking price
        require(
            msg.value==price,
            "Please submit the asking price in order to complete the purchase"
            );

            idMarketItem[tokenId].owner = payable(msg.sender);
            idMarketItem[tokenId].sold=true;
            idMarketItem[tokenId].owner=payable(address(0));

            _itemSold.increment();
            //now we have to transfer the token because when someone will call the token it will list on the contract
            _transfer(address(this),msg.sender,tokenId);

            payable(owner).transfer(listingPrice); //if any sell will done we have to take our comission
            payable(itemMarketItem[tokenId].seller).transfer(msg.value); //if the token is sold the owner will get the listing price of nft and the rest amount will goes to the nft owner

    }

    //the function for not sold nft data

    function fetchMarketItem() public view returns(MarketItem[] memory){
        uint256 itemCount = _tokenIds.current(); //everytime someone will keep the nft the no.will keep increasing
        //also those nft are not sold we have to track that nfts
        uint256 unSoldItemCount = _tokenIds.current() - _itemSold.current(); //after subracting sold to unsold item will get the unsold items
        uint256 currentIndex =0;

        //Taking the array for the unsold nft
        MarketItem[] memory items = new MarketItem[](unSoldItemCount);
        for(uint256 i =0; i<itemCount;i++){
            //those nft belong to these smart contract address those are not sold it unsold nft
            if(idMarketItem[i+1].owner == address(this)){
                //if we will find that nft we will simply increment that
                uint256 currentId = i+1;

                MarketItem storage currentItem = idMarketItem[currentId];
                item[currentItem]= currentItem; //here we will simply track the current items
                currentIndex += 1;
            }
           
        }
         return items;
    }
    //function for purchase item

    function fetchMyNFT() public view returns(MarketItem[] memory){
        uint256 tokenCount = _tokenIds.current();
        uint256 itemCount = 0;
        uint256 currentIndex = 0;

        for(uint256 i =0;i<totalCount;i++){
            if(idMarketItem[i+1].owner==msg.sender){ //here we are checking who is the owner whether the owner is msg.sender
            itemCount +=1;

            } 
        }
        MarketItem[] memory items = new MarketItem[](itemCount)
        for(uint256 i = 0;i<totalCount;i++){
            if(idMarketItem[i+1].owner ==msg.sender){
                uint256 currentId = i+1; //now we will increment the id
            MarketItem storage currentItem = idMarketItem[currentId];
            items[currentIndex] = currentItem;
            currentIndex +=1;
            }
            
        }
        return item;
    }
    //here is a function for single user item
    function fetchItemListed() public view returns(MarketItem[] memory){
        uint256 totalCount = _tokenIds.current();
        uint256 itemCount = 0;
        uint256 currentIndex = 0;

        for(uint256 i = 0;i < totalCount; i++){
            if(idMarketItem[i+1].seller==msg.sender){
                itemCount +=1;
            }
        }

        MarketItem[] memory items = new MarketItem[] (itemCount);
        for(uint256 i =0;i<totalCount; i++){
            if(idMarketItem[i+1].seller==msg.sender){
                uint256 currentId = i+1; 

                MarketItem storage currentItem = idMarketItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex +=1;

            }
        }
        return items;
    }


}