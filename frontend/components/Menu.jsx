import React, { Component, Fragment } from "react";
import { Link } from 'react-router-dom';
import Profiles from "./Profiles"
 
// import * as ReactDOM from 'react-dom'


const Menu = () => {
    // console.log(profiles)
    // console.log(followings)
    // console.log(socialLinks)

    return(
        <>
            <Link to="/menu/profiles">Profiles</Link>
            <div></div>
            <Link to="/">Home</Link>
        </>
    )
}
export default Menu;


