const sunny = `<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M12 3.0625V5.125" stroke="var(--yellow)" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round"/>
    <path d="M12 18.875V20.9375" stroke="var(--yellow)" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round"/>
    <path d="M18.3198 5.68016L16.8615 7.13852" stroke="var(--yellow)" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round"/>
    <path d="M7.13851 16.8615L5.68015 18.3198" stroke="var(--yellow)" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round"/>
    <path d="M20.9375 12H18.875" stroke="var(--yellow)" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round"/>
    <path d="M5.125 12H3.0625" stroke="var(--yellow)" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round"/>
    <path d="M18.3198 18.3198L16.8615 16.8615" stroke="var(--yellow)" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round"/>
    <path d="M7.13851 7.13852L5.68015 5.68016" stroke="var(--yellow)" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round"/>
    <path d="M12 15.4375C13.8985 15.4375 15.4375 13.8985 15.4375 12C15.4375 10.1015 13.8985 8.5625 12 8.5625C10.1015 8.5625 8.5625 10.1015 8.5625 12C8.5625 13.8985 10.1015 15.4375 12 15.4375Z" stroke="var(--yellow)" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round"/>
</svg>
`;
const cloudy = `<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M4.85825 10.6545C5.01166 10.6315 5.15375 10.5603 5.26394 10.4511C5.37412 10.3419 5.44666 10.2004 5.47104 10.0473C6.06917 6.27288 8.80725 4 12 4C14.965 4 16.9404 5.9415 17.7255 7.9875C17.7717 8.10892 17.8491 8.216 17.95 8.29792C18.0508 8.37984 18.1715 8.43371 18.2998 8.45408C20.8623 8.86108 23 10.5638 23 13.5333C23 16.5583 20.525 18.6667 17.5 18.6667H5.58333C3.0625 18.6667 1 17.409 1 14.6333C1 12.1386 3.01163 10.9295 4.85825 10.6545Z" stroke="var(--color--secondary)" stroke-width="1.5" stroke-linejoin="round"/>
</svg>
`;
const storm = `<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M9.5625 13.6875L8.875 17.8125H10.9375V21.25L14.375 16.4375H12.3125L13 13.6875" stroke="var(--yellow)" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
    <path d="M17.9986 7.19449H17.4773C17.1555 4.2709 14.6388 2 11.625 2C10.4141 1.99884 9.23259 2.37278 8.24289 3.07042C7.25314 3.76806 6.50386 4.75515 6.09793 5.89598H5.90156C3.7557 5.89598 2 7.6491 2 9.79153C2 11.9344 3.7557 13.6875 5.90156 13.6875H17.9986C19.7891 13.6875 21.25 12.2266 21.25 10.4408C21.25 8.65543 19.7891 7.19449 17.9986 7.19449Z" stroke="var(--color--secondary)" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
    <path d="M5.78125 15.75L4.75 17.8125M6.46875 19.1875L5.78125 20.5625M17.8125 15.75L16.7812 17.8125M18.5 19.1875L17.8125 20.5625" stroke="var(--cyan)" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
`;

// @author Alan Harder
var crumb = { wrap: function() { } };

function loaddata() {
  var script = document.createElement('SCRIPT');
  script.type = 'text/javascript';
  script.src = 'https://rating.jenkins.io/rate/result.php';
  script.onload = function() { do_loaddata(); }
  script.onreadystatechange = function() { // For IE
    if (this.readyState=='loaded' || this.readyState=='complete') do_loaddata();
  }
  document.getElementById('head').appendChild(script);
  return false;
}

/**
 * @param {'sunny' | 'cloudy' | 'storm'} status - the status
 * @param {string} version - the version of the release
 * @param {number} rate - what to rate the release when clicked, 1 for no major issues, 0 for notable issues, -1 for having to roll back
 * @param {string} description - the tooltip to show
 * @param {string} currentRating - the current rating
 */
function health(status, version, rate, description, currentRating) {
  let icon;

  switch (status) {
    case 'sunny':
      icon = sunny;
      break;
    case 'cloudy':
      icon = cloudy;
      break;
    case 'storm':
      icon = storm;
      break;
  }

  return `<button class="app-button app-button--tertiary ${status}" data-tooltip="${description}" onclick="rate('${version}', ${rate})">
            <span>${currentRating}</span>
            ${icon}
          </button>`;
}

function do_loaddata() {
  for (var anchors = document.querySelectorAll("[data-type='release-header']"), i = 0; i < anchors.length; i++) {
    const version = anchors[i].dataset.version;
    const information = data[version];
    let txt = '';
    const owner = document.createElement('div');
    owner.className = 'app-status-container'
    div2 = document.createElement('DIV');
    div2.className = 'app-status-container__icons';
    txt = health('sunny',version,1, 'No major issues with this release', (information && information[0] ? information[0] + ' ' : '0 '))
        + health('cloudy',version,0, 'I experienced notable issues', (information && information[1] ? information[1] + ' ' : '0 '))
        + health('storm',version,-1, 'I had to roll back', (information && information[2] ? information[2] + ' ' : '0 '));
    div2.innerHTML = txt;
    owner.appendChild(div2);

    if (information && information.length > 3) {
      const div3 = document.createElement('DIV');
      txt = '<span class="app-status-container__issues">Community reported issues: ';
      var issues = [];
      for (j = 3; j < information.length; j += 2) {issues.push({id: information[j], count: information[j + 1]})}
      issues.sort(function (a, b) {return b.count - a.count;});
      for (j = 0; j < issues.length; j++)
        txt += issues[j].count + '&times;<a href="https://issue-redirect.jenkins.io/issue/' + issues[j].id + '">JENKINS-' + issues[j].id + '</a> ';
      txt += '</span>';
      div3.innerHTML = txt;
      owner.appendChild(div3);
    }

    anchors[i].parentNode.parentNode.appendChild(owner);
  }
}

function rate(version,rating) {
  var issue = (rating <= 0) ? prompt('Please provide issue number from our JIRA causing trouble:','') : '';
  if (issue==null) return; // Cancelled
  if (rating <= 0 && issue == '') {
    issue = prompt('Are you sure you do not want to provide an issue reference? It really helps us improve Jenkins.\nEnter issue number, or leave empty to skip:', '');
    if (issue==null) return; // Cancelled
  }
  var script = document.createElement('SCRIPT');
  script.type = 'text/javascript';
  script.src = 'https://rating.jenkins.io/rate/submit.php?version='
    + encodeURIComponent(version) + '&rating=' + rating + '&issue=' + encodeURIComponent(issue);
  script.onload = function() { alert('Thanks!'); location.reload(); }
  script.onreadystatechange = function() { // For IE
    if (this.readyState=='loaded' || this.readyState=='complete') {
      alert('Thanks!'); location.reload();
    }
  }
  document.getElementById('head').appendChild(script);
}

