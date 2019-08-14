import React, { Fragment, Component, useCallback } from "react";
import ReactDOM from 'react-dom';
import Profile from "./Profile";
import ProfilePreviewItem from "./ProfilePreviewItem";
import CreateProfileInput from "./CreateProfileInput";
import ProfileEdit from "./ProfileEdit";
import FollowingList from "../FollowingList";


//Drag
import { DndProvider, DragDropContext } from 'react-dnd'
import HTML5Backend from 'react-dnd-html5-backend'
import { useDrop } from 'react-dnd'


const ProfilesList = (props) => {
    console.log("ProfilesList.jsx")

    let profiles = props.profiles;
    let followings = props.followings;

    const handleDrop = useCallback((index, item) => {
        console.log(index);
        console.log(item);
    })
    
    console.log(followings)

    return (
        <Fragment>

            <div className="profilesList row col-12 ">       
                <div className="col-6">

                    {/* Available only in Profile List view */}
                    <a href="/manage/profiles"> Manage Profiles </a>
                    
                    {/* Available only in Profile Manager view */}
                    {/* Create New Profile
                    ------------------------------------------------------- */}
                    <CreateProfileInput createProfile={props.createProfile}/>

                    {/* Displays Profile Name Only (Preview)
                    ------------------------------------------------------- */}
                    <ul className="list-unstyled">
                        {
                            profiles.map((profile, index) => {
                                return (
                                    <li key={profile.id}>
                                        <ProfilePreviewItem profile={profile} onDrop={item => handleDrop(index, item)} />
                                    </li>
                                )
                            })
                        }
                    </ul>
                </div>

                <div className="col-6">
                    <ul className="list-unstyled">
                        <FollowingList followings={followings} />
                    </ul>

                    {
                        // filteredFollowings = props.followings.filter(following === this.state.selectedProfileID)
                        /* <FollowingList followingsList={getfilter()}/> */
                        }
                </div>



                {/* Show List of Profile
                ------------------------------------------------------- */}
                {/* Link each profile to their respective profile feed */}
                
                {/* <ul className="list-unstyled">
                    {
                        profiles.map(profile => {
                            return (
                                <li key={profile.id}>
                                    <Profile profile={profile} />
                                </li>
                            )
                        })
                    }
                </ul> */}
                
                {/* ------------------------------------------------------- */}
                {/* <h2>Profile Edit</h2>
                {
                    profiles.map(profile => {
                        return (
                            <li key={profile.id}>
                                <ProfileEdit profile={profile} 
                                            updateProfile={props.updateProfile} />
                            </li>
                        )
                    })
                } */}
            </div>
 
        </Fragment>
    )
}

export default ProfilesList;
