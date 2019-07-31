import React, { Component, Fragment } from "react";
import MenuList from "./MenuList";
// import * as ReactDOM from 'react-dom'

class Menu extends Component {
    render(){
        return (
            <Fragment>
                <a>Menu</a>
                <MenuList/>
            </Fragment>
        )

    }
}

export default Menu;


