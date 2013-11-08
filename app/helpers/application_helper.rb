module ApplicationHelper
  include FormHelpers
  # For adding nested dynamic nested associations
  #
  def link_to_add_fields(name, form, association)
    new_object = form.object.send(association).klass.new
    id = new_object.object_id
    fields = form.fields_for(association, new_object, child_index: id) do |builder|
      render("admin/partials/" + association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, "#", class: "add-fields", data: { id: id, fields: fields.gsub("\n", "")})
  end

  def link_to_new_fields(name, klass)
    new_object = klass.new
    id = new_object.object_id

    fields = fields_for("#{klass.name.downcase}[]", klass.new) do |location|
      render("admin/partials/" + klass.to_s.downcase.singularize + "_fields", f: location)
    end

    link_to(name, "#", class: "add-fields", data: { id: id, fields: fields.gsub("\n", "")})
  end
end

