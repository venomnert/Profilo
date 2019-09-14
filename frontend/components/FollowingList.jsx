import React, { Fragment, Component, useCallback, useState } from "react";
import Following from "./Following"

// Produces a list of followings

const FollowingList = ({followings}) => {
    return(
        followings.map((following, index) => {
        return(
            <Following 
                key={index}
                following={following}
                type="social"
                />
        )
        })
    )
};

export default FollowingList 