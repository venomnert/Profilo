import React from "react";
import Following from "./Following"

const FollowingList = ({followings}) => (
    followings.map(following => {
        return <Following 
                    key={following.id}
                    draggable={false}
                    following={following}/>
    })
);

export default FollowingList 