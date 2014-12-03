module Formtastic
  module Inputs
    class CheckBoxesInput
      def choice_html(choice)
        template.content_tag(
          :label,
          template.content_tag(:div,
            checkbox_input(choice) + choice_label(choice),
            class: input_html_options[:check_boxes_class]),
          label_html_options.merge(:for => choice_input_dom_id(choice), :class => nil)
        )
      end
    end
  end
end