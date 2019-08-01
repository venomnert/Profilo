import React, { Component, Fragment } from "react";
import { Link } from 'react-router-dom';
import MenuList from "./MenuList";
// import * as ReactDOM from 'react-dom'

class Menu extends Component {
    render(){
        return (
            <Fragment>
                <a id="menu" href="/menu">Menu</a>
                <MenuList/>
                <Link to="/app">Home</Link>

            </Fragment>
        )

    }
}

export default Menu;


