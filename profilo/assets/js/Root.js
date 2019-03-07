import * as React from 'react'
import { BrowserRouter, Route, Switch } from 'react-router-dom'

import Header from './components/Header'
import HomePage from './pages'

export default class Root extends React.Component {
  render() {
    return (
        <Header />
    )
  }
}