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

  def us_states
    [
        ['Alabama', 'AL', 1],
        ['Alaska', 'AK', 1],
        ['Arizona', 'AZ', 1],
        ['Arkansas', 'AR', 1],
        ['California', 'CA', 1],
        ['Colorado', 'CO', 1],
        ['Connecticut', 'CT', 1],
        ['Delaware', 'DE', 1],
        ['District of Columbia', 'DC', 1],
        ['Florida', 'FL', 1],
        ['Georgia', 'GA', 1],
        ['Guam', 'GU', 1],
        ['Hawaii', 'HI', 1],
        ['Idaho', 'ID', 1],
        ['Illinois', 'IL', 1],
        ['Indiana', 'IN', 1],
        ['Iowa', 'IA', 1],
        ['Kansas', 'KS', 1],
        ['Kentucky', 'KY', 1],
        ['Louisiana', 'LA', 1],
        ['Maine', 'ME', 1],
        ['Maryland', 'MD', 1],
        ['Massachusetts', 'MA', 1],
        ['Michigan', 'MI', 1],
        ['Minnesota', 'MN', 1],
        ['Mississippi', 'MS', 1],
        ['Missouri', 'MO', 1],
        ['Montana', 'MT', 1],
        ['Nebraska', 'NE', 1],
        ['Nevada', 'NV', 1],
        ['New Hampshire', 'NH', 1],
        ['New Jersey', 'NJ', 1],
        ['New Mexico', 'NM', 1],
        ['New York', 'NY', 1],
        ['North Carolina', 'NC', 1],
        ['North Dakota', 'ND', 1],
        ['Northern Mariana Islands', 'MP', 0, 1],
        ['Ohio', 'OH', 1],
        ['Oklahoma', 'OK', 1],
        ['Oregon', 'OR', 1],
        ['Pennsylvania', 'PA', 1],
        ['Puerto Rico', 'PR', 1],
        ['Rhode Island', 'RI', 1],
        ['South Carolina', 'SC', 1],
        ['South Dakota', 'SD', 1],
        ['Tennessee', 'TN', 1],
        ['Texas', 'TX', 1],
        ['United States Virgin Islands', 'VI', 1],
        ['Utah', 'UT', 1],
        ['Vermont', 'VT', 1],
        ['Virginia', 'VA', 1],
        ['Washington', 'WA', 1],
        ['West Virginia', 'WV', 1],
        ['Wisconsin', 'WI', 1],
        ['Wyoming', 'WY', 1]
    ]
  end

  def can_provinces
    [
        ['Alberta', 'AB', 1],
        ['British Columbia', 'BC', 1],
        ['Manitoba', 'MB', 1],
        ['New Brunswick', 'NB', 1],
        ['Newfoundland and Labrador', 'NL', 1],
        ['Northwest Territories', 'NT', 0],
        ['Nova Scotia', 'NS', 1],
        ['Nunavut', 'NU', 0],
        ['Ontario', 'ON', 1],
        ['Prince Edward Island', 'PE', 1],
        ['Quebec', 'QC', 1],
        ['Saskatchewan', 'SK', 1],
        ['Yukon', 'YT', 0]

    ]
  end

  def auth_button(groups, path, text)
    if auth_groups(groups)
        display_nav_item(text, path)
    end
  end

end
