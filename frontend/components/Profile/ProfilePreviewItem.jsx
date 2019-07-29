import React from "react";

const ProfilePreviewItem = ({profile}) => {
    if (!profile.id) return <p>No profiles has been created</p>;
    
    const {name, id, avatarUrl} = profile;
    return (
        <div className="profilePreviewItem">
            <p className="profilePreviewItem__name">{name}</p>
        </div>
    );  
}
export default ProfilePreviewItem;