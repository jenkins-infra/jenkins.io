require 'asciidoctor'
require 'asciidoctor/extensions'

#
# Usage:
#
# For core Javadoc:
#
# jenkinsdoc:SCM[]
# jenkinsdoc:SCM[some label]
# jenkinsdoc:hudson.scm.SCM[]
# jenkinsdoc:hudson.scm.SCM[some label]
# jenkinsdoc:hudson.scm.SCM#anchor[]
# jenkinsdoc:hudson.scm.SCM#anchor[some label]
#
#
# For plugin Javadoc:
#
# jenkinsdoc:git:hudson.plugins.git.GitSCM[]
# jenkinsdoc:git:hudson.plugins.git.GitSCM[some label]
# jenkinsdoc:git:hudson.plugins.git.GitSCM#anchor[]
# jenkinsdoc:git:hudson.plugins.git.GitSCM#anchor[some label]

Asciidoctor::Extensions.register do
  inline_macro do
    named :jenkinsdoc
    name_positional_attributes 'label'

    process do |parent, target, attrs|

      if target.include? ":"
        parts = target.split(':', 2)
        plugin = parts.first
        target = parts.last
      end
      classname = label = title = target

      if classname.include? "." || plugin
        classname = classname.gsub(/#.*/, '')
        classurl = classname.gsub(/\./, '/') + ".html"

        classfrag = (target.include? "#") ? '#' + target.gsub(/.*#/, '') : ''

        if plugin
          label = (attrs.has_key? 'label') ? attrs['label'] : %(#{classname} in #{plugin})
          target = %(http://javadoc.jenkins.io/plugin/#{plugin}/#{classurl}#{classfrag})
        else
          label = (attrs.has_key? 'label') ? attrs['label'] : classname
          target = %(http://javadoc.jenkins.io/#{classurl}#{classfrag})
        end
      else
        label = (attrs.has_key? 'label') ? attrs['label'] : classname
        target = %(http://javadoc.jenkins.io/byShortName/#{classname})
      end

      title = %(Javadoc for #{classname})

      (create_anchor parent, label, type: :link, target: target, attributes: {'title' => title}).render
    end
  end
end

Asciidoctor::Extensions.register do
  inline_macro do
    named :staplerdoc
    name_positional_attributes 'label'

    process do |parent, target, attrs|

      classname = target.gsub(/#.*/, '')
      classurl = classname.gsub(/\./, '/') + ".html"

      classfrag = (target.include? "#") ? '#' + target.gsub(/.*#/, '') : ''
      label = (attrs.has_key? 'label') ? attrs['label'] : classname
      target = %(http://stapler.kohsuke.org/apidocs/#{classurl}#{classfrag})

      title = %(Javadoc for #{classname})

      (create_anchor parent, label, type: :link, target: target, attributes: {'title' => title}).render
    end
  end
end


Asciidoctor::Extensions.register do
  inline_macro do
    named :javadoc
    name_positional_attributes 'label'

    process do |parent, target, attrs|

      classname = target.gsub(/#.*/, '')
      classurl = classname.gsub(/\./, '/') + ".html"

      classfrag = (target.include? "#") ? '#' + target.gsub(/.*#/, '') : ''
      label = (attrs.has_key? 'label') ? attrs['label'] : classname
      target = %(http://docs.oracle.com/javase/7/docs/api/#{classurl}#{classfrag})

      title = %(Javadoc for #{classname})

      (create_anchor parent, label, type: :link, target: target, attributes: {'title' => title}).render
    end
  end
end
