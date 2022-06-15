# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  skip_before_action :authenticate_user!
  def callback
    email = auth[:info][:email].downcase
    name = auth[:info][:name]
    existing_user = User.find_or_initialize_by(name: name, email: email)
    if existing_user.save
      sign_in existing_user
      flash[:notice] = t('.notice')
      redirect_to root_path
    else
      flash.now[:error] = t('.error')
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
