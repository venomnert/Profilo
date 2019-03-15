import * as React from 'react'
import { BrowserRouter, Route, Switch } from 'react-router-dom'

import Header from './components/Header'
import TestHeader from './components/TestHeader'


export default class Root extends React.Component {
  render() {
    return (
      <div>
        <Header />
        <TestHeader />
      </div>
    )        
  }
}