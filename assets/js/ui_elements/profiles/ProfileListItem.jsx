import React from "react";
import TwitterIcon from "../../icons/Twitter.svg";
import GithubIcon from "../../icons/Github.svg";

const ProfileListItem = ({id, profile}) => {
    let avatar_url = profile.avatar_url;
    let screen_name = profile.name;
    let connected_social_links = profile.connected_social_links;
    let avatar_style = {
        width: "75px",
        height: "75px", 
        border: "1px solid",
        borderRadius: "50%"
    };
    return (
        <div className="profileListItem">
            <img className="profileListItem__avatar p-2" src={avatar_url} alt="User Avatar" style={avatar_style}/>
            <p className="profileListItem__name">{screen_name}</p>
            {Object.keys(connected_social_links).map(social_link => {
                return social_link === "github" ? <GithubIcon height="40px" width="40px"/> : <TwitterIcon height="40px" width="40px"/>
            })}
        </div>
    );
}
export default ProfileListItem;
