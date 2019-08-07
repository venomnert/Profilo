import React, { Component, Fragment } from "react";
import { Link, Router, Route } from 'react-router-dom';

// Icons
import ProfileIcon from '../../static/icons/Profile.svg';
import SettingsIcon from '../../static/icons/Settings.svg';
import ProfilesList from "../Profile/ProfilesList";

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
                showProfiles: false,
                showSettings: false
            }
        }
      }

    renderProfileList = (showProfiles, props) => {
        if(showProfiles){
            console.log("renderProfileList");
            console.log(showProfiles);
            return(
                <div id="lists" className="col-xs-4 col-sm-3">
                    <ProfilesList 
                        profiles={props.profiles} 
                        createProfile={props.createProfile}
                        updateProfile={props.updateProfile}/>                
                </div>
            )

        }
    }  
    
    render(){
        return (
            <Fragment>
                <div className="row">
                    {/* Left hand column of the menu */}
                    <div id="menu" className="col-xs-4 col-sm-3">
                        <ul className="menu-nav">
                            <a className="remove-link-underline" href="#" onClick={(e) => {
                                e.preventDefault(); 
                                let new_menu = {
                                    showProfiles: true,
                                    showSettings: false
                                }
                                this.setState({menu: new_menu});
                            }}>
                                <ProfileIcon width="40px" height="40px" className="fill-primary" /> Profiles
                            </a>
                        </ul>
                    </div>
                    {/* Right hand column of the menu : shows ProfilesList commponent */}
                    {this.renderProfileList(this.state.menu.showProfiles, this.props.data.data)}
                </div>
            </Fragment>
        )

    }
}

export default MenuList;
