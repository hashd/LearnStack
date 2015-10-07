import React from 'react'

class MainNav extends React.Component {
  render() {
    return (
      <nav className="mdl-navigation mdl-layout--large-screen-only">
        <a className="mdl-navigation__link" href="">Dashboard</a>
        <a className="mdl-navigation__link is-current" href="">Orders</a>
        <a className="mdl-navigation__link" href="">Catalog</a>
      </nav>
    )
  }
}

export default MainNav