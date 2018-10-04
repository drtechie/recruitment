class ArrayInput

  include Formtastic::Inputs::Base

  def to_html
    input_wrapping do
      inputs = []

      @object[method].each_with_index do |v, x|
        inputs << array_input_html(v)
      end

      label_html <<
          template.content_tag(:div, class: "input-group--array") do
            inputs.join.html_safe << array_input_html('', false)
          end
    end
  end

  private

  def array_input_html(value, remove =true)
    if remove
      button = template.button_tag('-', "data-action": 'remove', type: 'button')
    else
      button = template.button_tag('+', "data-action": 'add', type: 'button')
    end
    template.content_tag(:div, class: "input-group--array__item #{options[:item_class]}") do
      template.text_area_tag("#{object_name}[#{method}][]", value, class: "textarea-group--array #{options[:class]}") << button
    end
  end

end