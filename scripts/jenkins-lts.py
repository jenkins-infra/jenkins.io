import requests
import re

def get_jenkins_lts_releases():
    # Fetch the Jenkins release data
    response = requests.get('https://www.jenkins.io/changelog-stable/rss.xml')

    # Check for a successful request
    if response.status_code != 200:
        print("Well, that didn't go as planned. Couldn't fetch the release data.")
        return

    # Parse the release data for LTS version numbers
    lts_versions = re.findall(r'<title>Jenkins (\d+\.\d+)\.\d+', response.text)

    # Get the last three unique LTS releases
    last_three_lts = []
    for version in lts_versions:
        if version not in last_three_lts:
            last_three_lts.append(version)
        if len(last_three_lts) == 3:
            break

    return last_three_lts

# Print the last three unique Jenkins LTS releases
print(get_jenkins_lts_releases())