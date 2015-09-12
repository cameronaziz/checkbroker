module OrganizationsHelper
  def add_advisor(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render('organizations/add_advisors_form', f: builder)
    end
    link_to(name, '#', class: 'btn btn-primary add_field', data: {id: id, fields: fields.gsub("\n", '')})
  end
end
