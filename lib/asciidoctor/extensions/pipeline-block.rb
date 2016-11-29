#!/usr/bin/env ruby

require 'asciidoctor/extensions'
require 'coderay'

Asciidoctor::Extensions.register do
  block do
    named :pipeline
    on_context :listing
    name_positional_attributes 'format'

    process do |parent, reader, attrs|
      format = (attrs.delete('format') || '')
      codelines = reader.lines()
      script = nil
      declarative = nil

      # Find where our "// Script" comment is for highlighting the Pipeline
      # Script syntax
      script_index = codelines.find_index { |c| c.match(/\/\/ (script) \/\//i) } || -1
      decl_index = codelines.find_index { |c| c.match(/\/\/ (declarative) \/\//i) } || -1

      # It would be great to re-use the [source] block styling, but it turns
      # out that our parser is going to delete WHATEVER style attribute we
      # would give the block if we used #create_listing_block()
      #
      # Ouch: <https://github.com/asciidoctor/asciidoctor/blob/master/lib/asciidoctor/parser.rb#L1086-L1087>
      snippet = ['<div class="pipeline-block">']

      if decl_index >= 0
        # Default to reading until the end of codelines
        last_line = -1

        if script_index > decl_index
          last_line = script_index - 1
        end
        declarative = codelines[(decl_index + 1) .. last_line].join("\n").chomp
        declarative = CodeRay::Duo[:groovy, :html, {:css => :style}].highlight(declarative)
        snippet << <<-EOF
<div class="listingblock pipeline-declarative">
  <div class="title">Jenkinsfile (Declarative Pipeline)</div>
  <div class="content">
EOF
        snippet << <<-EOF
<pre class="CodeRay highlight nowrap"><code class="language-groovy" data-lang="groovy">#{declarative}</code></pre>
EOF
        snippet << '</div></div>'
      end

      if script_index >= 0
        # Default to reading until the end of codelines
        last_line = -1

        # If our decl_index is lower than script_index, that means Declarative
        # was listed first, so we need to stop short of it
        if decl_index > script_index
          last_line = decl_index - 1
        end

        # Since we have a declarative block, let's show that by default and
        # hide this but leave a bread-crumb
        unless declarative.nil?
          snippet << <<-EOF
<div class="pipeline-script-expand">
  <a href="#" onclick="javascript:$(this).parent().siblings('.pipeline-script').toggle(); return false;">Toggle Pipeline Script</a>
  <em>(Advanced)</em>
</div>
EOF
        end

        script = codelines[(script_index + 1) .. last_line].join("\n").chomp
        script = CodeRay::Duo[:groovy, :html, {:css => :style}].highlight(script)
        snippet << <<-EOF
<div class="listingblock pipeline-script"
      style="display: #{(declarative.nil? or 'none') or 'inherit'}">
  <div class="title">Jenkinsfile (Pipeline Script)</div>
  <div class="content">
EOF
        snippet << <<-EOF
<pre class="CodeRay highlight nowrap"><code class="language-groovy" data-lang="groovy">#{script}</code></pre>
EOF
        snippet << '</div></div>'
      end

      snippet << '</div>'

      create_pass_block(parent, snippet.join(''), attrs)
    end
  end
end
