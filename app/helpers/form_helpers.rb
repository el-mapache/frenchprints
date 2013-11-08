module FormHelpers
  # Create a form label for use with bootstrap
  def form_label(form, attr)
    form.label attr, class: "control-label"
  end

  # Creates a bootstrap form field group
  def form_field(form, field, attr, options)
    content_tag :div, class: "controls" do
      form.send(field, attr, options)
    end
  end

  # Creates a boilerplate bootstrap form group.
  #
  # .control-group
  #   %form_label
  #   .controls
  #     %input_field
  # @param {form} Object: The form instance the fields should be associated with
  # @param {field} Symbol: The type of form field you want to create
  # @param {attr} Symbol or String: The model attribute you want the input to set 
  # @param {options} Hash: Optional standard HTML options
  #
  def control_group(form, field, attr, options = {})
    attr = attr.kind_of?(Symbol) ? attr : attr.to_sym

    content_tag :div, class: "control-group" do
      form_label(form, attr) + form_field(form, field, attr, options)
    end
  end
end
