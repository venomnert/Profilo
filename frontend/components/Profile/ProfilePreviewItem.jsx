import React from "react";
import { useDrop } from 'react-dnd'

/* 
    Displays Name of Profilo Profiles
 */
const ProfilePreviewItem = ({profile, lastDroppedItem, onDrop}) => {
    const [{ isOver, canDrop }, drop] = useDrop({
        drop: onDrop,
        accept:"following",
        collect: monitor => ({
          isOver: monitor.isOver(),
          canDrop: monitor.canDrop(),
        }),
    })
   
    if (!profile.id) return <p>No profiles has been created</p>;
    
    const {name, id, avatarUrl} = profile;
    return (
        <div ref={drop} className="profilePreviewItem">
            <p className="profilePreviewItem__name">{name}</p>
        </div>
    );  
}

export default ProfilePreviewItem;
