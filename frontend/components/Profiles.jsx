import React, { Component, Fragment } from "react";
import { Link } from 'react-router-dom';

import ListProfiles from './ListProfiles'

const Profiles = ({data: {data: {profiles, followings, socialLinks}}}) => {
    
    console.log(profiles);
    console.log(followings);
    console.log(socialLinks);
    
    return(
        <>
            <div>Profiles.jsx</div>
            <Link to="/menu/profiles/manage">Manage</Link>
            <ListProfiles data={profiles}/>

        </>
    )
}

export default Profiles