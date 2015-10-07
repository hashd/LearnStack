import React from 'react'
import MainNav from './main_nav'

class MainHeader extends React.Component {
  render() {
    return (
      <header className="mdl-layout__header">
        <div className="mdl-layout__header-row">
          <span className="mdl-layout-title">StoreKeeper</span>
          <div className="mdl-layout-spacer"></div>
          <MainNav />
        </div>
      </header>
    )
  }
}

export default MainHeader