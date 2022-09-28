import React from 'react'

//here we are importing the internal import
import Style from './Button.module.css'

//here we are assigning the props
const Button = ({btnName,handleClick}) => {
  return (
    <div className={Style.box}>
      <button className={Style.button} onClick={()=> handleClick()}>
        {btnName}
      </button>
    </div>
  )
}

export default Button