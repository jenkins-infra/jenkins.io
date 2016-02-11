/** @flow */
import React from 'react'
import styles from './Header.css'

export default function Header () {
  return (
    <nav className={styles.Header}>

      <div className={styles.LogoContainer}>
        <img
          height={50}
          title='Jenkins logo'
          src='https://wiki.jenkins-ci.org/download/attachments/2916393/logo.png'
        />
        <div className={styles.JenkinsText}>Jenkins</div>
        <div className={styles.SearchText}>Plugins</div>
        <div className={styles.JenkinsText}>Search</div>
        <img
            title='Redux Search logo'
            width={50}
            height={50}
            src='https://cloud.githubusercontent.com/assets/29597/11674783/dadaa3a8-9dd8-11e5-811d-1371a8a50c68.png'
          />
      </div>

      <ul className={styles.NavList}>
        <NavLink
          target='_blank'
          text='Source'
          url='https://github.com/scherler/jenkins-plugin-site/tree/nodeInfrastructure'
          pathData='M12.89,3L14.85,3.4L11.11,21L9.15,20.6L12.89,3M19.59,12L16,8.41V5.58L22.42,12L16,18.41V15.58L19.59,12M1.58,12L8,5.58V8.41L4.41,12L8,15.58V18.41L1.58,12Z'
        />
        <NavLink
          text='Documentation'
          target='_blank'
          url='https://github.com/scherler/jenkins-plugin-site/tree/nodeInfrastructure/docs'
          pathData='M11,19V9A2,2 0 0,0 9,7H5V17H9A2,2 0 0,1 11,19M13,9V19A2,2 0 0,1 15,17H19V7H15A2,2 0 0,0 13,9M21,19H15A2,2 0 0,0 13,21H11A2,2 0 0,0 9,19H3V5H9A2,2 0 0,1 11,7H13A2,2 0 0,1 15,5H21V19Z'
        />
        <NavLink
          text='Issues'
          target='_blank'
          url='https://github.com/scherler/jenkins-plugin-site/issues'
          pathData='M14,12H10V10H14M14,16H10V14H14M20,8H17.19C16.74,7.22 16.12,6.55 15.37,6.04L17,4.41L15.59,3L13.42,5.17C12.96,5.06 12.5,5 12,5C11.5,5 11.04,5.06 10.59,5.17L8.41,3L7,4.41L8.62,6.04C7.88,6.55 7.26,7.22 6.81,8H4V10H6.09C6.04,10.33 6,10.66 6,11V12H4V14H6V15C6,15.34 6.04,15.67 6.09,16H4V18H6.81C7.85,19.79 9.78,21 12,21C14.22,21 16.15,19.79 17.19,18H20V16H17.91C17.96,15.67 18,15.34 18,15V14H20V12H18V11C18,10.66 17.96,10.33 17.91,10H20V8Z'
        />
      </ul>
    </nav>
  )
}

function NavLink ({ pathData, text, url }) {
  return (
    <li className={styles.NavListItem}>
      <a
        className={styles.NavLink}
        href={url}
      >
        <svg
          className={styles.NavLinkIcon}
          viewBox='0 0 24 24'
        >
          <path d={pathData}></path>
        </svg>
        {text}
      </a>
    </li>
  )
}
