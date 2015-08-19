module ApplicationHelper
  def display_nav_item(text, link)
    raw("<li#{current_page?(link) ? ' class="active"' : ''}>#{link_to text, link}</li>")
  end

  def link_to_button(click_text, url, button_class = 'btn-default')
    button_class = "btn #{button_class}"
    link_to click_text, url, :class => button_class
  end

  def nav_li_link(anchor, url)
    if current_page?(url)
      html = "<li class='active'>"
      html += link_to raw("#{anchor}<span class='sr-only'>(current)</span>"), url
    else
      html = '<li>'
      html += link_to anchor, url
    end
    html += '</li>'
    html.html_safe
  end

  def full_title(page_title = '')

    if page_title.empty?
      SITENAME
    else
      "#{page_title} | #{SITENAME}"
    end
  end

  def create_title(instance)
    variable = "ticket_" + instance
    if @ticket.send(variable).count > 0
      "<h3>#{instance.capitalize}</h3>".html_safe
    end
  end

  def lookup_ticket_name(ticket)
    if ticket.name == ""
      'Unnamed'
    else
      ticket.name
    end
  end


  def us_states
    [
        ['Alabama', 'AL'],
        ['Alaska', 'AK'],
        ['Arizona', 'AZ'],
        ['Arkansas', 'AR'],
        ['California', 'CA'],
        ['Colorado', 'CO'],
        ['Connecticut', 'CT'],
        ['Delaware', 'DE'],
        ['District of Columbia', 'DC'],
        ['Florida', 'FL'],
        ['Georgia', 'GA'],
        ['Hawaii', 'HI'],
        ['Idaho', 'ID'],
        ['Illinois', 'IL'],
        ['Indiana', 'IN'],
        ['Iowa', 'IA'],
        ['Kansas', 'KS'],
        ['Kentucky', 'KY'],
        ['Louisiana', 'LA'],
        ['Maine', 'ME'],
        ['Maryland', 'MD'],
        ['Massachusetts', 'MA'],
        ['Michigan', 'MI'],
        ['Minnesota', 'MN'],
        ['Mississippi', 'MS'],
        ['Missouri', 'MO'],
        ['Montana', 'MT'],
        ['Nebraska', 'NE'],
        ['Nevada', 'NV'],
        ['New Hampshire', 'NH'],
        ['New Jersey', 'NJ'],
        ['New Mexico', 'NM'],
        ['New York', 'NY'],
        ['North Carolina', 'NC'],
        ['North Dakota', 'ND'],
        ['Ohio', 'OH'],
        ['Oklahoma', 'OK'],
        ['Oregon', 'OR'],
        ['Pennsylvania', 'PA'],
        ['Puerto Rico', 'PR'],
        ['Rhode Island', 'RI'],
        ['South Carolina', 'SC'],
        ['South Dakota', 'SD'],
        ['Tennessee', 'TN'],
        ['Texas', 'TX'],
        ['Utah', 'UT'],
        ['Vermont', 'VT'],
        ['Virginia', 'VA'],
        ['Washington', 'WA'],
        ['West Virginia', 'WV'],
        ['Wisconsin', 'WI'],
        ['Wyoming', 'WY']
    ]
  end

  def auth_button(groups, path, text)
=begin
    if authenticate_group(groups, false)
=end
        display_nav_item(text, path)
=begin
    end
=end
  end

end
