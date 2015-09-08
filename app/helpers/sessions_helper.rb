module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    session[:groups] = nil
    user.groups.each do |group|
      (session[:groups] ||= []) << group.name
    end
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


  def auth_group(group_name)
    if current_user
      session[:groups].each do |user_group|
        if user_group == group_name
          return true
        end
      end
      false
    else
      false
    end
  end

  def auth_groups(groups)
    if current_user
      groups.each do |group_name|
        session[:groups].each do |user_group|
          if user_group == group_name
            return true
          end
        end
      end
      false
    else
      false
    end
  end

  def auth_group_redirect(group)
    unless auth_group(group)
      flash[:alert] = 'You do not have authorization to view that page.'
      redirect_to profile_path
    end
  end

  def auth_groups_redirect(groups)
    unless auth_groups(groups)
      flash[:alert] = 'You do not have authorization to view that page.'
      redirect_to profile_path
    end
  end


  def authenticate_user
    unless logged_in?
      store_location
      flash[:alert] = 'Please log in to view that page.'
      redirect_to login_url
    end
  end
end
