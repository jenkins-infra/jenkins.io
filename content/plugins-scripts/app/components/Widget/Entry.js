import React, { PropTypes } from 'react'
import styles from './Widget.css'
import {cleanTitle, getMaintainers, getScoreClassName} from '../../helper'
import classNames from 'classnames'

Entry.propTypes = {
  plugin: PropTypes.any.isRequired
}

export default function Entry ({plugin}) {
  return (
    <div
        key={plugin.get('sha1')}
        className={styles.Item}
      >
        
        <a href={plugin.get('wiki')} className={styles.Tile}>
          <div className={styles.Icon}>
            {plugin.get('iconDom')}
          </div>

          <div className={styles.Score}>
            <span className={getScoreClassName()}></span>
          </div>
          <div className={styles.Title}>
            <h4>{cleanTitle(plugin.get('title'))}</h4>
          </div>
          <div className={styles.Version}>
            <span className={styles.v}>{plugin.get('version')}</span>
            <span className="jc">
              <span className="j">Jenkins</span>
              <span className="c">{plugin.get('requiredCore')}+</span>
              </span>
          </div>

          <div className={styles.Wiki}>
            {plugin.get('wiki')}
          </div>

          <div className={styles.Excerpt}>
            {plugin.get('excerpt')}
          </div>

          <div className={styles.Authors}>
            {getMaintainers(plugin.get('developers'),plugin.get('sha1'))}
          </div>

        </a>
      </div>
  )
}
