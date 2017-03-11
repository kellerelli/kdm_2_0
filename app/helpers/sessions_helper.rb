module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= begin
      puts 'session'
      #pp session
      pp "request"
      #pp request.headers
      if !session[:user_id].nil?
        puts "found userid"
        User.where(id: session[:user_id]).all.first
      elsif !request.headers['HTTP_KEY_ID'].nil? && !request.headers['HTTP_AUTH_TOKEN'].nil?
        user = User.where(key_id: request.headers['HTTP_KEY_ID']).all.first
        x= request.headers['HTTP_AUTH_TOKEN']
        if user.auth_token.eql? request.headers['HTTP_AUTH_TOKEN']
          puts "found user"
          user
        else
          puts "Auth token does not match key id given"
          nil
        end
      else
        puts "Not loged in or no keyid or auth token recieved"
        nil
      end
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
