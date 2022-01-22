module JenkinsIsTheWay
  def fix_jitw_quote(content)
    content.gsub(/<div class="quoteblock testimonal">\s*<blockquote>\s*(?<quote>[^<]*)<span class="image">(?<img>.*?)<\/span>\s*<\/blockquote>\s*<div class="attribution">\s*/) do |match|
      "<div class=\"quoteblock testimonal\"><blockquote>#{$~[:quote]}</blockquote><div class=\"attribution\"> #{$~[:img]}"
    end
  end
end
