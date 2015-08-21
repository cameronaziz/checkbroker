module PortfoliosHelper
  def add_investment(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render('investments/table_form', f: builder)
    end
    link_to(name, '#', class: 'btn btn-default add_field', data: {id: id, fields: fields.gsub("\n", '')})
  end
end