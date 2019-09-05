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
        // const [profileId, setProfileId] = useState();
        // const [followingIds, setFollowingId] = useState([]);


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

    let profiles = props.profiles;
    let followings = props.followings;
    const LINK_FOLLOWING_TO_PROFILE = gql`
        mutation linkFollowing($id: Int!, $following_ids: [Int]!){
            linkFollowingToProfile(id: $id, followings: $following_ids) {
                id
            }
        } `
    
    const [update, { data }] = useMutation(LINK_FOLLOWING_TO_PROFILE);

    const handleDrop = useCallback((index, item) => {
            
        const profileId = index;
        const followingId = [];
            followingId.push(item.id);

        console.log(typeof(followingId[0]));
        console.log(`profileId ${profileId}`);
        console.log(`item ${JSON.stringify(item)}`);
        console.log(followingId);
        const returnValue = update({variables:{
                id: 5, 
                following_ids: [56]
            }
        })

        console.log(returnValue);

    })
    
    
    const profileUpdated = () => console.log("profile updated success")
    
    return (
        <>
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
