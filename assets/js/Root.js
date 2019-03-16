import * as React from 'react'
import { BrowserRouter, Route, Switch } from 'react-router-dom'

import Header from './components/Header'
import Login from './components/Login'


export default class Root extends React.Component {
  render() {
    return (
      <div>
        <Header />
        <Login />
      </div>
    )        
  }
}