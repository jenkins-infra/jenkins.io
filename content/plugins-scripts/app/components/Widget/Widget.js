/** @flow */
import Immutable from 'immutable'
import Entry from './Entry'
import styles from './Widget.css'
import React, { PropTypes } from 'react'
import {cleanTitle, getMaintainers, getScoreClassName} from '../../helper'
import { VirtualScroll } from 'react-virtualized'
import classNames from 'classnames'

Widget.propTypes = {
  generateData: PropTypes.func.isRequired,
  recordIds: PropTypes.any.isRequired,
  recordsMap: PropTypes.any.isRequired,
  rowRenderer: PropTypes.any.isRequired,
  searchData: PropTypes.func.isRequired,
  title: PropTypes.string.isRequired
}
export default function Widget ({
  generateData,
  recordIds,
  recordsMap,
  rowRenderer,
  searchData,
  title
}) {
  const totalSize = recordsMap instanceof Immutable.Collection
    ? recordsMap.size
    : Object.keys(recordsMap).length
  const filteredSize = recordIds instanceof Immutable.Collection
    ? recordIds.size
    : recordIds.length

  return (
    <div className={classNames(styles.ItemFinder, 'item-finder')} >
      
      <div className={classNames(styles.CategoriesBox, 'categories-box col-md-2')} >
        <ul className="list-group">
          <li className={classNames(styles.scm, 'scm')}>
            <a className={classNames(styles.li, 'list-group-item')}>SCM connectors</a></li>
          <li className={classNames(styles.build, 'build')}>
            <a className={classNames(styles.li, 'list-group-item')}>Build and analytics</a></li>
          <li className={classNames(styles.deployment, 'deployment')}>
            <a className={classNames(styles.li, 'list-group-item')}>Deployment</a></li>
          <li className={classNames(styles.pipelines, 'pipelines')}>
            <a className={classNames(styles.li, 'list-group-item')}>Pipelines</a></li>
          <li className={classNames(styles.containers, 'containers')}>
            <a className={classNames(styles.li, 'list-group-item')}>Containers</a></li>
          <li className={classNames(styles.security, 'security')}>
            <a className={classNames(styles.li, 'list-group-item')}>Users and security</a></li>
          <li className={classNames(styles.general, 'general')}>
            <a className={classNames(styles.li, 'list-group-item')}>General purpose</a></li>
        </ul>
      </div>
      
      <div className={classNames(styles.ItemsList, 'items-box col-md-10')}>
      
        <nav id="cb-grid-toolbar" className='navbar navbar-light bg-faded'>
          <ul className="nav navbar-nav">
            <li className="nav-item active"><a className="nav-link">Featured</a></li>
            <li className="nav-item"><a className="nav-link">New</a></li>
            <li className="nav-item"><a className="nav-link">All</a></li>
            <li className="nav-item btn-group"><a className="nav-link dropdown-toggle">Tags</a></li>
            <li className="nav-item btn-group"><a className="nav-link dropdown-toggle">Technologies</a></li>
            <li className="nav-item"><button className="btn btn-sm" onClick={()=>  generateData()}>getPlugins</button></li>
          </ul>
          
          <ul className="pull-xs-right nav navbar-nav">
            <li className="nav-item">
              {totalSize > 0 &&
                <span className="nav-link">
                  {filteredSize} of {totalSize}
                </span>
              }
            </li>
            <li className="nav-item">
              <form className="form-inline pull-xs-right">
              <input
                disabled={recordsMap.size === 0}
                className={classNames(styles.SearchInput, "form-control")}
                onChange={event => searchData(event.target.value)}
                placeholder='Filter...'
              />
              </form>
            </li>
            <li className="nav-item btn-group">
              <a className="nav-link dropdown-toggle">Sort</a>
            </li>
            <li className="nav-item btn-group">
              <a className="nav-link dropdown-toggle">Filter</a>
            </li>
            <li className="nav-item btn-group dropdown">
              <a className="nav-link dropdown-toggle">View</a>
              
            </li>
          </ul>          
        </nav>
        
        
        <div id="cb-item-finder-grid-box" className={classNames(styles.GridBox, 'grid-box')} >
          <div className={classNames(styles.Grid, 'grid foo')} >
          
            {totalSize > 0 && recordIds.valueSeq().map(id => {
              return <Entry className="Entry" key={recordsMap.get(id).id} plugin={recordsMap.get(id)} />
            })}
            
          </div>
        </div>
        
      
        <div className="clearfix"></div>
      
      </div>
      
    </div>
    )
}
