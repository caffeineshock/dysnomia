module Postprocess
  def self.included(base)
    base.class_eval do
      def self.acts_as_processable(*fields)
        fields.each do |f|
          define_method "postprocessed_#{f}".to_sym do
            PostprocessorService.instance.toHTML(send(f)).html_safe
          end
        end
      end
    end
  end
end