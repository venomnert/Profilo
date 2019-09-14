/* * TODO: rename /component/ListProfiles to ManageListProfiles
=========================================================================*/

import React from 'react';

import Profile from './Profile'

const ListProfiles = (props) => {
    
    let profiles = props.data.profiles;

    return(
        <> 
            {/* Show List of Profile
            ------------------------------------------------------- */}
            {/* Link each profile to their respective profile feed */}
            
            <ul className="list-unstyled">
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