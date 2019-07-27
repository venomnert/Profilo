import React from "react";

const ProfilePreviewItem = ({id, profile}) => {
    let screen_name = profile.name;
    return (
        <div className="profilePreviewItem">
            <p className="profilePreviewItem__name">{screen_name}</p>
        </div>
    );
}
export default ProfilePreviewItem;
