
import React from 'react';

import ProfileEdit from "./ProfileEdit";

const ProfileEditRoot = (props) => {
    let profiles = props.data.profiles;

    return (
        <>
            <h2>Profile Edit</h2>
            {
                profiles.map(profile => {
                    return (
                        <li key={profile.id}>
                            <ProfileEdit profile={profile} 
                                        updateProfile={props.updateProfile} />
                        </li>
                    )
                })
            }
        </>
    )
}

export default ProfileEditRoot;