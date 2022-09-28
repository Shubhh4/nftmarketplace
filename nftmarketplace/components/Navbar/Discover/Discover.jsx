import React from 'react'
import Link from 'next/link';


//here we will do the internal import 
import Style from "./Discover.module.css"

const Discover = () => {
  //here we will do discover navigation menu
  const discover = [
    {
      name:"Collection",
      link:"collection",
    },
    {
      name:"Search",
      link:"search",
    },
    {
      name:"Author Profile",
      link:"author-profile",
    },
    {
      name:"NFT Details",
      link:"nft-details",
    },
    {
      name:"Account Setting",
      link:"account-setting",
    },
    {
      name:"Connect Wallet",
      link:"connect-wallet",
    },
    {
      name:"Blog",
      link:"blog",
    }
  ]
  return (
    <div>
      {discover.map((el,i)=>(
        /* //every single id has a unique key */

        <div key={i + 1} className={Style.discover}>
         <Link href={{pathname: `${el.link}`}}>{el.name}</Link>
        </div>
      ))}
    </div>
  )
}

export default Discover