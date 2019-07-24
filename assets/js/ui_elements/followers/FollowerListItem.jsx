import React,{ Component }from "react";
import PropTypes from 'prop-types';
import Draggable from 'react-draggable';

import TwitterIcon from "../../icons/Twitter.svg";
import GithubIcon from "../../icons/Github.svg";
import CloseIcon from "../../icons/Close.svg";

class FollowerListItem extends Component {
    renderFollowerListItem = (social_icon, avatar_url, screen_name, avatar_style) => {
        return (
            <div className="followerListItem">
                <img className="followerListItem__avatar p-2" src={avatar_url} alt="User Avatar" style={avatar_style}/>
                <p className="followerListItem__name">{screen_name}</p>
                {social_icon}
                <a href="#"><CloseIcon width="40px" height="40px"/></a>
            </div>
        )
    }
    render() {
        let {social_link, user, draggable} = {...this.props};
        let social_icon, avatar_url, screen_name, avatar_style;

        if (user == null) { return <div>no followers</div>;}
        avatar_style = {
            width: "75px",
            height: "75px", 
            border: "1px solid",
            borderRadius: "50%"
        }
        if(social_link === "github") {
            social_icon = <GithubIcon width="40px" height="40px" />;
            avatar_url = user.node.avatarUrl;
            screen_name = user.node.name;
        }
        else {
            social_icon = <TwitterIcon width="40px" height="40px" />;
            avatar_url = user.profile_image_url_https;
            screen_name = user.screen_name;
        }
        if(draggable) {
           return(
                <Draggable >
                    {this.renderFollowerListItem(social_icon, avatar_url, screen_name, avatar_style)}
                </Draggable>
           )
        }
        else { return this.renderFollowerListItem(social_icon, avatar_url, screen_name, avatar_style); }   
    }
}

FollowerListItem.propTypes = {
    social_link: PropTypes.string,
    user: PropTypes.object
};
export default FollowerListItem;
