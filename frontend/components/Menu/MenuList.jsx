import React, { Component, Fragment } from "react";

class MenuList extends Component {
    render(){
        return (
            <Fragment>
                MenuList
                <ul>
                    <li><a href="/profiles" >Profiles</a></li>
                    <li><a href="/settings">Settings</a></li>
                </ul>
            {/* 
                <Expander/> */}
            </Fragment>
        )

    }
}

export default MenuList;
