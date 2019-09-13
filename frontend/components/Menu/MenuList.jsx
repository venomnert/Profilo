import React, { Component, Fragment } from "react";
import { Link, Router, Route } from 'react-router-dom';

// Icons
import ProfileIcon from '../../static/icons/Profile.svg';
import SettingsIcon from '../../static/icons/Settings.svg';
import ProfilesList from "../Profile/ProfilesList";

//Drag
import { DndProvider, DragDropContext } from 'react-dnd';
import HTML5Backend from 'react-dnd-html5-backend';


class MenuList extends Component {
    constructor(props) {
        super(props);
    }

    renderProfileList = (props) => {
        return(
            <div id="lists" className="col-9">
                <ProfilesList 
                    followings={props.followings}
                    profiles={props.profiles}
                    createProfile={props.createProfile}
                    updateProfile={props.updateProfile}/>
            </div>
        )
    } 
    
    render(){
        return (
            <DndProvider backend={HTML5Backend}>
                <Fragment>
                    <div className="row">
                        {/* Menu Navigation 
                        ====================================================================*/}
                        <div id="menu" className="col-3">
                            <ul className="menu-nav">
                                <a className="remove-link-underline" href="#" onClick={(e) => {
                                    e.preventDefault(); 
                                }}>
                                    <ProfileIcon width="40px" height="40px" className="fill-primary" /> Profiles
                                </a>
                            </ul>
                        </div>
                        {/* Left hand column of the menu : shows ProfilesList commponent 
                        ====================================================================*/}
                        {this.renderProfileList(this.props.data.data)}                        

                    </div>
                </Fragment>
            </DndProvider>
        )

    }
}

export default MenuList;
