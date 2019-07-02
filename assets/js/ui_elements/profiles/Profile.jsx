import React from "react";
import TwitterIcon from "../../icons/Twitter.svg";
import GithubIcon from "../../icons/Github.svg";
import CloseIcon from "../../icons/Close.svg";

const Profile = ({id, profile}) => {
    let avatar_url = profile.avatar_url;
    let screen_name = profile.name;
    let connected_social_links = profile.connected_social_links;
    let groups = profile.groups;
    let avatar_style = {
        width: "75px",
        height: "75px", 
        border: "1px solid",
        borderRadius: "50%"
    };
    return (
        <div className="Profile">
            <img className="Profile__avatar p-2" src={avatar_url} alt="User Avatar" style={avatar_style}/>
            <p className="Profile__name">{screen_name}</p>
            {Object.keys(connected_social_links).map(social_link => {
                return social_link === "github" ? <GithubIcon height="40px" width="40px" /> : <TwitterIcon height="40px" width="40px"/>
            })}
            <ul className="Profile__groups-list">
                {Object.keys(groups).map(group => {
                    return (
                        <li key={group} className="Profile__group-item">
                            {groups[group]}
                        </li>
                    )
                })}
            </ul>
            <a href="#"><CloseIcon width="40px" height="40px"/></a>
        </div>
    );
}
export default Profile;
