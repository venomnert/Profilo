import React, { Component } from "react";
import TwitterIcon from "../../icons/Twitter.svg";
import GithubIcon from "../../icons/Github.svg";
import CloseIcon from "../../icons/Close.svg";

class ProfileEdit extends Component {
    handleChange = (e) => {
        const updated_profile = Object.assign(
                                {...this.props.profile},
                                {[e.currentTarget.name]: e.currentTarget.value})
        this.props.update_profile(this.props.id, updated_profile)
    }
    render() {
        let profile = this.props.profile;
        if (!profile) {return <div>Nothing</div>};

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
            <div className="profileEdit col-12">
                <img className="profileEdit__avatar p-2" src={avatar_url} alt="User Avatar" style={avatar_style}/>
                <input
                    type="text"
                    name="avatar_url"
                    onChange={this.handleChange}
                    value={avatar_url}
                />
                <input
                    type="text"
                    name="name"
                    onChange={this.handleChange}
                    value={screen_name}
                />
                {Object.keys(connected_social_links).map(social_link => {
                    return social_link === "github" ? <GithubIcon height="40px" width="40px" /> : <TwitterIcon height="40px" width="40px"/>
                })}
                <ul className="profileEdit__groups-list">
                    {Object.keys(groups).map(group => {
                        return (
                            <li key={group} className="profileEdit__group-item">
                                {groups[group]}
                            </li>
                        )
                    })}
                </ul>
                <button onClick={() => this.props.delete_profile(this.props.id)}>Delete</button>
            </div>
        );
    }
}
export default ProfileEdit;
