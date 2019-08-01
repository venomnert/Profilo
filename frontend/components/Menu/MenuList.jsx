import React, { Component, Fragment } from "react";

// Icons
import ProfileIcon from '../../static/icons/Profile.svg';
import SettingsIcon from '../../static/icons/Settings.svg';


class MenuList extends Component {
    render(){
        return (
            <Fragment>
                MenuList
                <ul className="menu-nav">
                    <li><a className="remove-link-underline" href="/app/profiles" > <ProfileIcon width="40px" height="40px" className="fill-primary" /> Profiles</a></li>
                    <li><a className="remove-link-underline" href="/app/settings"> <SettingsIcon width="40px" height="40px" className="fill-primary" /> Settings</a></li>
                </ul>
            {/* 
                <Expander/> */}
            </Fragment>
        )

    }
}

export default MenuList;
