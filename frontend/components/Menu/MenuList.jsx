import React, { Component, Fragment } from "react";
import { Link, Router, Route } from 'react-router-dom';

// Icons
import ProfileIcon from '../../static/icons/Profile.svg';
import SettingsIcon from '../../static/icons/Settings.svg';
import ProfilesList from "../Profile/ProfilesList";

//Drag
import { DndProvider, DragDropContext } from 'react-dnd';
import HTML5Backend from 'react-dnd-html5-backend';




// function displayProfiles(){
//     return(
//         <ProfilesList 
//         profiles={this.state.profiles} 
//         createProfile={this.createProfile}
//         updateProfile={this.updateProfile}/>
//     )
// }

class MenuList extends Component {
    constructor(props) {
        super(props);
        this.state = {
            menu: {
                showProfileList: true,
                showManageProfiles: true,
                showSettings: false
            }
        }
      }

    renderProfileList = (showProfileList, props) => {
        if(showProfileList){            
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
    } 
    
    
    render(){
        return (
            <DndProvider backend={HTML5Backend}>
                <Fragment>
                    <div className="row">
                        {/* Left hand column of the menu */}
                        <div id="menu" className="col-3">
                            <ul className="menu-nav">
                                <a className="remove-link-underline" href="#" onClick={(e) => {
                                    e.preventDefault(); 
                                    let new_menu = {
                                        showProfileList: true,
                                        showSettings: false
                                    }
                                    this.setState({menu: new_menu});
                                }}>
                                    <ProfileIcon width="40px" height="40px" className="fill-primary" /> Profiles
                                </a>
                            </ul>
                        </div>
                        {/* Right hand column of the menu : shows ProfilesList commponent */}
                        {this.renderProfileList(this.state.menu.showProfileList, this.props.data.data)}

                        {/* Right hand column of the menu : shows ProfileManage commponent */}
                        {/* {this.renderProfileManage(this.state.menu.showProfileList, this.props.data.data)} */}
                    </div>
                </Fragment>
            </DndProvider>
        )

    }
}

export default MenuList;
