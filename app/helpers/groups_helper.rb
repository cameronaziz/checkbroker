module GroupsHelper
  def exclude_link_to(group_id)
    (group_id == 1 || group_id == 2) ? value = false : value = true
    value
  end
end
