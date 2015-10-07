import React from 'react'

class Page extends React.Component {
  render() {
    return (
      <main className="mdl-layout__content">
        <div className="page-content">
          <h4 style={{"border-bottom":"1px solid #ddd"}}>{this.props.pageTitle}</h4>
          {this.props.children}
        </div>
      </main>
    )
  }
}

export default Page