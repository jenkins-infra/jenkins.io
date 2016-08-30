require 'tilt'
require 'asciidoctor'

module Awestruct
  module Tilt
    # Re-open the AsciidoctorTemplate class and modify the #evaluate method
    # until this pull request is released:
    # <https://github.com/awestruct/awestruct/pull/517>
    class AsciidoctorTemplate
      def evaluate(scope, locals, &block)
        @output ||= (scope.document = ::Asciidoctor.load(data, options)).convert
      end
    end
  end
end
