import React from "react";
import PropTypes from 'prop-types';
import Draggable from 'react-draggable';

import TwitterIcon from "../../icons/Twitter.svg";
import GithubIcon from "../../icons/Github.svg";
import CloseIcon from "../../icons/Close.svg";

const FollowerItem = ({social_link, user, draggable}) => {
    if (user == null) {
        return <div>no followers</div>;
    }
    let social_icon;
    if(social_link === "github") {
        social_icon = <GithubIcon width="40px" height="40px" />;
    }
    else {
        social_icon = <TwitterIcon width="40px" height="40px" />;
    }
    if(draggable) {
       return(
            <Draggable >
                <div className="followerItem">
                    <img className="followerItem__avatar" src={user.profile_image_url_https} alt="User Avatar"/>
                    <p className="followerItem__name">{user.screen_name}</p>
                    {social_icon}
                    <a href="#"><CloseIcon width="40px" height="40px"/></a>
                </div>
            </Draggable>
       )
    }
    return (
        <div className="followerItem">
            <img className="followerItem__avatar" src={user.profile_image_url_https} alt="User Avatar"/>
            <p className="followerItem__name">{user.screen_name}</p>
            {social_icon}
            <a href="#"><CloseIcon width="40px" height="40px"/></a>
        </div>
    );
}

FollowerItem.propTypes = {
    social_link: PropTypes.string,
    user: PropTypes.object
};
export default FollowerItem;
