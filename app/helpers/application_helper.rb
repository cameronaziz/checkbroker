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
        ['Guam', 'GU'],
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
        ['Northern Mariana Islands', 'MP'],
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
        ['United States Virgin Islands', 'VI'],
        ['Utah', 'UT'],
        ['Vermont', 'VT'],
        ['Virginia', 'VA'],
        ['Washington', 'WA'],
        ['West Virginia', 'WV'],
        ['Wisconsin', 'WI'],
        ['Wyoming', 'WY']
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

  def non_nav_pages
    pages = [
        login_path,
        register_path,
        root_path,
        brokerages_signup_path,
        privacy_path,
        legal_path
    ]
    pages.each do |page|
      return true if current_page?(page)
    end
    false
  end
end
