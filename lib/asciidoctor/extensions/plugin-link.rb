require 'asciidoctor'
require 'asciidoctor/extensions'

#
# Usage:
# plugin:git[Git plugin]
#
Asciidoctor::Extensions.register do
  inline_macro do
    named :plugin
    name_positional_attributes 'label'

    process do |parent, target, attrs|
      label = attrs['label']
      target = %(https://plugins.jenkins.io/#{target})
      (create_anchor parent, label, type: :link, target: target).render
    end
  end
end
