module ApplicationHelper
  
  def form_label(form, attr)
    form.label attr, class: "control-label"
  end

  def form_field(form, field, attr, options)
    content_tag :div, class: "controls" do
      form.send(field, attr, options)
    end
  end

  def control_group(form, field, attr, options = {})
    attr = attr.kind_of?(Symbol) ? attr : attr.to_sym

    content_tag :div, class: "control-group" do
      form_label(form, attr) + form_field(form, field, attr, options)
    end
  end

end
