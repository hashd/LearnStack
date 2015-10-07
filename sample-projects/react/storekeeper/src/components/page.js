import React from 'react'

class Page extends React.Component {
  render() {
    return (
      <main className="mdl-layout__content" style={{display:"block", width:"100%"}}>
        <div className="page-content">
          {this.props.children}
        </div>
      </main>
    )
  }
}

export default Page