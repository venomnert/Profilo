import React from "react";
import Following from "./Following"

// Takes of list of Followings and renders out a list of Followings 

const FollowingList = ({followings}) => {
    return followings.map((following, index) => {
        return(
            <Following 
                key={index}
                following={following}
                type="social"
                />
        )
    })
};

export default FollowingList 