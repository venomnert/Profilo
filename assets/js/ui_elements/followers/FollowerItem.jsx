import React, { Component } from "react";

class FollowerItem extends Component {
    render() {
        return (
            <div className="followerItem">
                <img className="followerItem__avatar" src="" alt="User Avatar"/>
                <p className="followerItem__name"></p>
                <img className="followerItem__social_link" src="" alt="Twitter"/>
                <img className="followerItem__close" src="" alt="Close Icon"/>
            </div>
        );
    }
}

export default FollowerItem;
