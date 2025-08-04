#!/usr/bin/env ruby
#
# generate the plugin/core release history RSS
#
# Usage: release-rss.ruby <URL of release-hisotory.json>
#
require 'rss'
require 'faraday'
require 'faraday/follow_redirects'

def get_url(url)
  conn = Faraday.new url do |f|
    f.use Faraday::FollowRedirects::Middleware, limit: 5
    f.response :json, content_type: /\bjson$/
    f.adapter Faraday.default_adapter
  end
  resp = conn.get
end

def toGA(gav)
  gav.split(":").reverse.drop(1).reverse.join(":")
end

rss = RSS::Maker.make("atom") do |maker|
  maker.channel.id = "urn:63067410335c11e0bc8e0800200c9a66:feed"
  maker.channel.updated = Time.now.to_s
  maker.channel.author = "Jenkins History Bot"
  maker.channel.title = "Jenkins plugin releases"
  maker.channel.links.new_link { |link| link.href = "https://www.jenkins.io/" }
  maker.channel.links.new_link do |link|
    link.href = "https://www.jenkins.io/releases.rss"
    link.rel = "self"
    link.type = "application/atom+xml"
  end


  first = {}

  releaseHistory = get_url(ARGV[0]).body["releaseHistory"].reverse
  releaseHistory.each do |i|
    i["releases"].each do |r|
      first[toGA(r["gav"])] = r["gav"]
    end
  end

  releaseHistory[0..30].each do |i|
    i["releases"].each do |r|
      next unless r["gav"] && r["title"]

      maker.items.new_item do |item|
        s = (first[toGA(r["gav"])] == r["gav"]) ? " (new)" : ""
        item.title = "#{r["title"]} #{r["version"]}#{s}"
        item.id = "urn:63067410335c11e0bc8e0800200c9a66:#{r["gav"]}"
        item.summary = "#{r["title"]} #{r["version"]}"
        item.links.new_link do |link|
          link.href = r["url"]
          link.rel = "alternate"
          link.type = "text/html"
        end

        item.published = Time.at(r["timestamp"] / 1000)
        item.updated = Time.at(r["timestamp"] / 1000)
        item.pubDate = Time.at(r["timestamp"] / 1000)
      end
    end
  end

end

puts rss
