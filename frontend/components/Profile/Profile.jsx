import React from "react";
import CloseIcon from "../../static/icons/Close.svg";

const Profile = ({profile}) => {
    if (!profile.id) return <p>No profiles has been created</p>;

    const {name, id, avatarUrl} = profile;
    return (
        <div className="profile">
            <img className="profile__avatar p-2" src={avatarUrl} alt={name} />
            <p className="profile__name">{name}</p>
            <a href="#"><CloseIcon width="40px" height="40px"/></a>
        </div>
    );
}
export default Profile;
