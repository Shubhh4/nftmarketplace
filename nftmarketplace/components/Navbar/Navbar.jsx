import React, {useState,useEffect} from 'react'
import Image from "next/image"
import Link from "next/link"
//now we importing the icons
import {MdNotifications} from 'react-icons/md'
import {BsSearch} from "react-icons/bs"
import {CgMenuLeft ,CgMenuRight} from 'react-icons/cg'

//importing the internal import for css file

import Style from "./Navbar.module.css";
import {Discover, HelpCenter, Notification, Profile, SideBar} from "../index";
import {Button} from '../componentindex';
import images from '../Img';

const Navbar = () => {
    //here we are using couple of useState components
   const [discover, setDiscover] = useState(false);
   const [help, setHelp] = useState(false);
   const [notification, setNotification] = useState(false);
   const [profile, setProfile] = useState(false);
   const [openSideMenu, setopenSideMenu] = useState(false);

   const openMenu = (e)=>{
    const btnText = e.target.innerText;  //if someone will click on discover help notification... we will get the text
    if(btnText == "Discover" ){
        setDiscover(true);
        setHelp(false);
        setNotification(false);
        setProfile(false);
    }else if(btnText == "Help Center"){
        setDiscover(false);
        setHelp(true);
        setNotification(false);
        setProfile(false);
    }else{
        setDiscover(false);
        setHelp(false);
        setNotification(false);
        setProfile(false);
    }
   };

    //function for open Notification
    const openNotification = ()=>{
        if(!notification){
            setDiscover(false);
            setHelp(false);
            setNotification(true);
            setProfile(false);
        }else{
            setNotification(false);
        }
   };
   const openProfile = ()=>{
    if(!profile){
        setProfile(true);
        setDiscover(false);
        setHelp(false);
        setNotification(false)
    }else{
        setProfile(false);
    }
   };
   const openSideBar =() =>{
    if(!openSideMenu){
        setopenSideMenu(true);
    }else{
        setopenSideMenu(false);
    }
   };
  return (
    <div className={Style.Navbar}>
        <div className={Style.navbar_container}>
            <div className={Style.navbar_container_left}>
                <div className={Style.logo}>
                    <Image 
                    src={images.logo}
                    alt="NFT MARKET PLACE" 
                    width={100} 
                    height={100}
                    />
                </div>
                <div className={Style.navbar_container_left_box_input}>
                    <div className={Style.navbar_container_left_box_input_box}>
                        <input type= 'text' placeholder="Search NFT"/>
                        <BsSearch onClick={()=> {}} className={Style.search_icon}/>
                    </div>
                </div>
            </div>
            {/* //here there will be end of left section */}
            <div className={Style.navbar_container_right}>
                <div className={Style.navbar_container_right_discover}>
                    {/* //the below one is the discover menu */}
                    <p onClick={(e)=>openMenu(e)}>Discover</p>
                    {discover && (
                         <div className={Style.navbar_container_right_container_box}>
                         <Discover/>
                     </div>
                    )}
                </div>
                {/* //these are for the help center components*/}

                <div className={Style.navbar_container_right_help}>
                    <p onClick={(e)=> openMenu(e)}>Help Center</p>
                    {help && (
                        <div className={Style.navbar_container_right_help_box}>
                            <HelpCenter/>
                        </div>
                    )}
                </div>
                {/* //here are the component for the nofication box*/}
                <div className={Style.navbar_container_right_notify}>
                    <MdNotifications className={Style.notify} onClick={() => openNotification()}
                    />
                    {notification && <Notification/>}
                </div>

                {/* //create a button section */}
                <div className={Style.navbar_container_right_button}>
                    <Button btnText = "create" handleClick={() => {}}/>
                </div>
                {/* //here we initialised the user profile */}
                <div className={Style.navbar_container_right_profile_box}>
                    <div className={Style.navbar_container_right_profile}>
                        <Image 
                        src={images.user1} 
                        alt="Profile" 
                        width={40} 
                        height={40} 
                        onClick={()=> openProfile()}
                        className={Style.navbar_container_right_profile}
                        />
                        {profile && <Profile/>}
                    </div>
                </div>
                {/* //the component for menu button */}
                <div className={Style.navbar_container_right_menuBtn}>
                    <CgMenuRight className={Style.menuIcon}
                    onClick={()=> openSideBar()}
                    />
                </div>
            </div>
        </div>
        {/* //here we render the sidebar components */}
        {openSideMenu && (
            <div className={Style.sideBar}>
                <SideBar setOpenSideMenu={setopenSideMenu}/>
            </div>
        )}
    </div>
  );
};

export default Navbar