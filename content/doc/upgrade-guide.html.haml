---
layout: documentation
title: "Jenkins LTS Upgrade Guide"
---

- grouped = site.versions_grouped

- if page.version
  - minor_versions = grouped[page.version]
  - position = grouped.keys.index(page.version.to_s)
  - if position == grouped.size - 1
    - prev = "1.651.3"
  - else
    - prev = grouped[grouped.keys[position + 1]][0].to_s.tr_s("-",".")
  - page.title = "Upgrading to Jenkins LTS #{page.version}.x"
  %p
    Each section covers the upgrade from the previous LTS release, 
    the section on #{minor_versions[-1].to_s.tr_s("-",".")} covers the upgrade from  #{prev}.

  - minor_versions.each do |minor|
    %h3{:id => "upgrading-to-jenkins-lts-#{minor}"}
      Upgrading to Jenkins #{minor.to_s.tr_s("-",".")}
    = site.upgrades[minor].content

- else
  %p
    This section highlights important changes for administrators upgrading
    %a{:href => "/download/lts"} Jenkins LTS.
    Each section covers the upgrade from the previous LTS release,
    sections on versions x.y.1 cover the upgrade from the last release of the
    previous LTS line. if you are skipping LTS releases when upgrading, it is
    recommended to read the sections for all releases in between.
  %ul
    - grouped.each do |major, minor_versions|
      %li
        %a{:href => "/doc/upgrade-guide/#{major}"}
          Upgrading to Jenkins #{major}.x
        %ul
          - minor_versions.each do |minor|
            %li
              %a{:href => "/doc/upgrade-guide/#{major}#upgrading-to-jenkins-lts-#{minor}"} 
                Upgrading to Jenkins #{minor.to_s.tr_s("-",".")}
