/** @flow */
import React from 'react'
import styles from './CardWrapper.css'

CardWrapper.propTypes = {
  children: React.PropTypes.node.isRequired
}
export default function CardWrapper ({ children }) {
  return (
    <div className="container">
      <div className="row">
        <div className="col-md-12">
          {children}
        </div>
      </div>
    </div>
  )
}
