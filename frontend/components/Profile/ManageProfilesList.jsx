import React, { Fragment, Component, useCallback, useState } from "react";
import ReactDOM from 'react-dom';
import gql from "graphql-tag";
import {Mutation} from "react-apollo";
import { useMutation } from "@apollo/react-hooks"; 


import Profile from "./Profile";
import ProfilePreviewItem from "./ProfilePreviewItem";
import CreateProfileInput from "./CreateProfileInput";
import FollowingList from "../FollowingList";


//Drag
import { DndProvider, DragDropContext } from 'react-dnd'
import HTML5Backend from 'react-dnd-html5-backend'
import { useDrop } from 'react-dnd'


const ProfilesList = (props) => {

    //set state for profiles, followings (social links not need)
        //init empty state
        const [profiles, setProfiles] = useState(props.data.data.data.profiles);
        const [followings, setFollowings] = useState(props.data.data.data.followings);
        const [socialLinks, setSocialLinks] = useState(props.data.data.data.socialLinks);

    

    // handle a following dropped on a profile

    // props.state = {
    //     id: parseInt(this.props.profile.id),
    //     following_ids: [],
    //     profile: {
    //         name: props.profile.name,
    //         avatarUrl: props.profile.avatarUrl
    //     }
    // };

    console.log("ProfilesList.jsx")

    // let profiles = props.profiles;
    // let followings = props.followings;
    const LINK_FOLLOWING_TO_PROFILE = gql`
        mutation linkFollowing($id: Int!, $following_ids: [Int]!){
            linkFollowingToProfile(id: $id, followings: $following_ids) {
                id
            }
        } `
    
    const [update, { data }] = useMutation(LINK_FOLLOWING_TO_PROFILE);

    const handleDrop = useCallback((index, item, profile) => {
        
        const profileId = parseInt(profile.id);
        const followingId = [];
            followingId.push(parseInt(item.id));

        console.log("PROFILE ID ////////////////")
        console.log(profileId)
        console.log("////////////////")

        console.log("INDEX ID ////////////////")
        console.log(index)
        console.log("////////////////")

        console.log(typeof(followingId[0]));
        console.log(`profileId ${profileId}`);
        console.log(`item ${JSON.stringify(item)}`);
        console.log(followingId);

        const returnValue = update({variables:{
                id: profileId, 
                following_ids: followingId
            }
        })

        console.log(returnValue);

    })
    
    
    const profileUpdated = () => console.log("profile updated success")
    
    return (
        <>
            <div className="profilesList row col-12 ">       
                <div className="col-6">
                    
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
                                        <ProfilePreviewItem profile={profile} onDrop={item => handleDrop(index, item, profile)} />
                                    </li>
                                )
                            })
                        }
                    </ul>
                </div>

                <div className="col-6 list-overflow-scroll">
                    <ul className="list-unstyled">
                        <FollowingList followings={followings} />
                    </ul>

                    {
                        // filteredFollowings = props.followings.filter(following === this.state.selectedProfileID)
                        /* <FollowingList followingsList={getfilter()}/> */
                        }
                </div>
            </div>
        </>
    )
}

export default ProfilesList;
