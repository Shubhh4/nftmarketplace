import React from 'react'
import Link from "next/link"

//here we are doing the internal import
import Style from "./HelpCenter.module.css"


const Helpcenter = () => {
  const helpCenter =[
    {
    name:"About",
    link:"about",
  },
  {
    name:"Contact Us",
    link:"contact us",
  },
  {
    name:"Sign Up",
    link:"sign up",
  },
  {
    name:"Sign in",
    link:"sign-in"
  },
  {
    name:"Subscription",
    link:"subscription",
  }
];
  return (
    <div className={Style.box}>
      {helpCenter.map((el,i)=>(
        <div className={Style.helpCenter}>
          <Link href={{pathname: `${el.link}`}}>{el.name}</Link>
        </div>
      ))}
      </div>
  )
}

export default Helpcenter