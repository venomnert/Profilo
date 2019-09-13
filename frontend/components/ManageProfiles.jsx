import React, { Component, Fragment } from "react";
import ProfilesList from "./Profile/ProfilesList";
import { DndProvider, DragDropContext } from 'react-dnd';
import HTML5Backend from 'react-dnd-html5-backend';


const ManageProfiles = (props) => {
    return(
        <>
            <div>ManageProfiles.jsx</div>
            <DndProvider backend={HTML5Backend}>
                <div id="lists" className="col-9">
                    <ProfilesList 
                        followings={props.followings}
                        profiles={props.profiles}
                        createProfile={props.createProfile}
                        updateProfile={props.updateProfile}/>
                </div>
            </DndProvider>
        </>
    )
}

export default ManageProfiles