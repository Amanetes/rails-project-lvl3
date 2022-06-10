# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    email = auth[:info][:email].downcase
    name = auth[:info][:name]
    existing_user = User.find_or_initialize_by(name: name, email: email)
    if existing_user.save
      sign_in existing_user
      flash[:info] = 'Signed In'
      redirect_to root_path
    else
      flash.now[:error] = 'Failed'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
