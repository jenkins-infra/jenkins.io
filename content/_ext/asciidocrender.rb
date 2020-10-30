module AsciidocRender
  include Asciidoctor

  def asciidoc(text)
    Asciidoctor.convert(text, :attributes => {'icons' => 'font'})
  end
end

