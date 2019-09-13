
/*
Please use CAUTION. There are unfortunately 2 ListProfiles.jsx.
* TODO: rename /component/ListProfiles to ManageListProfiles
*/

import React, { Fragment, Component, useCallback, useState } from "react";
import ProfilePreviewItem from './Profile/ProfilePreviewItem'
import Profile from './Profile/Profile'

const ListProfiles = (props) => {

    const profiles = props.data
    
    return(
        <> 
            {/* Show List of Profile
            ------------------------------------------------------- */}
            {/* Link each profile to their respective profile feed */}
            
            <ul className="list-unstyled">
                <h1>ListProfiles</h1>
                 {   
                    profiles.map(profile => {
                        return (
                            <li key={profile.id}>
                                <Profile profile={profile} />
                            </li>
                        )
                    })
                }
            </ul>
        </>
    )
}

export default ListProfiles; 