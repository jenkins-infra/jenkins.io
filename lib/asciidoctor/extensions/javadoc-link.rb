require 'asciidoctor'
require 'asciidoctor/extensions'

#
# Usage:
# javadoc:SCM[]
# javadoc:SCM[some label]
# javadoc:hudson.scm.SCM[]
# javadoc:hudson.scm.SCM[some label]
# javadoc:hudson.scm.SCM#anchor[]
# javadoc:hudson.scm.SCM#anchor[some label]
#
Asciidoctor::Extensions.register do
  inline_macro do
    named :javadoc
    name_positional_attributes 'label'

    process do |parent, target, attrs|

      classname = label = title = target

      if classname.include? "."
        classname = classname.gsub(/#.*/, '')
        classurl = classname.gsub(/\./, '/') + ".html"

        classfrag = (target.include? "#") ? '#' + target.gsub(/.*#/, '') : ''
        label = (attrs.has_key? 'label') ? attrs['label'] : classname
        target = %(http://javadoc.jenkins-ci.org/#{classurl}#{classfrag})
      else
        label = (attrs.has_key? 'label') ? attrs['label'] : classname
        target = %(http://javadoc.jenkins-ci.org/byShortName/#{classname}) 
      end

      title = %(Javadoc for #{classname})

      (create_anchor parent, label, type: :link, target: target, attributes: {'title' => title}).render
    end
  end
end
