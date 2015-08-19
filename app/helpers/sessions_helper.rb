module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by_id session[:user_id]
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by_id cookies.signed[:user_id]
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def authenticate_user_and_group(group_name, is_id = true)
    if logged_in?
      unless authenticate_group(group_name, is_id)
        flash[:alert] = 'You do not have authorization to view that page.'
        redirect_to root_path
      end
    else
      authenticate_user
    end
  end

  def authenticate_group(group_name, is_id = true)
    ## todo: improve to not hit DB so many times.
    if group_name.kind_of?(Array)
      group_name.each do |group|
        if is_id
          then group_id = group_name
          else group_id = Group.find_by_name(group)
        end
        if current_user.groups.include?(Group.find(group_id))
        then
          @authenticated_user = true
          return true
        end
      end
    else
      if
      is_id ?
          current_user.groups.include?(Group.find(group_name)) :
          current_user.groups.include?(Group.find_by_name(group_name))
        @authenticated_user = true
        return true
      end
    end
    false
  end

  def authenticate_user
    unless logged_in?
      store_location
      flash[:alert] = 'Please log in to view that page.'
      redirect_to login_url
    end
  end

  def auth (user_id, group_id)
    session[:user_id]
  end

  def lookup_user_id

  end

  def auth_user(user_id, allowed_id)

  end

end
