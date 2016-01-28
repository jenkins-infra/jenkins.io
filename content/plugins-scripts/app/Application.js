/** @flow */
import { actions, searchText, filteredList, plugins } from './resources'
import { connect } from 'react-redux'
import { createSelector } from 'reselect'
import { Card, CardWrapper } from './components/Card'
import Footer from './components/Footer'
import Header from './components/Header'
import Immutable from 'immutable'
import React, { PropTypes } from 'react'
import Widget from './components/Widget'
import Highlighter from 'react-highlight-words'
import styles from './Application.css'

Application.propTypes = {
  searchText: PropTypes.string.isRequired,
  generatePluginData: PropTypes.func.isRequired,
  filteredList: PropTypes.instanceOf(Immutable.List).isRequired,
  searchText: PropTypes.string.isRequired,
  plugins: PropTypes.any.isRequired,
  searchPluginData: PropTypes.func.isRequired
}
export default function Application ({
  generatePluginData,
  filteredList,
  searchText,
  plugins,
  searchPluginData
}) {

  return (
      <Widget
        generateData={generatePluginData}
        recordIds={filteredList}
        recordsMap={plugins}
        rowRenderer={
          index => {
            const plugin = plugins.get(filteredList.get(index))
            return (

              <div
                key={index}
                className={styles.Row}
              >
                <a href={plugin.wiki} className={styles.Tile}>
                  <div className={styles.Icon}>
                    {plugin.iconDom}
                  </div>

                  <div className={styles.Score}>
                    <span className={getScoreClassName()}></span>
                  </div>
                  <div className={styles.Title}>
                    <h4>{cleanTitle(plugin.title)}</h4>
                  </div>
                  <div className={styles.Version}>
                    <span className={styles.v}>{plugin.version}</span>
                    <span className="jc">
                      <span className="j">Jenkins</span>
                      <span className="c">{plugin.requiredCore}+</span>
                      </span>
                  </div>

                  <div className={styles.Wiki}>
                    {plugin.wiki}
                  </div>

                  <div className={styles.Excerpt}>
                    {plugin.excerpt}
                  </div>

                  <div className={styles.Authors}>
                    {getMaintainers(plugin.developers,index)}
                  </div>

                </a>
              </div>
            )
          }
        }
        searchData={searchPluginData}
        title={'List of Plugins'}
      />

  )
}

const selectors = createSelector(
  [filteredList, searchText, plugins],
  (filteredList, searchText, plugins) => ({
    filteredList,
    searchText,
    plugins
  })
)

export default connect(selectors, actions)(Application)
