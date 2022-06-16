# frozen_string_literal: true

class GithubAuthService
  def self.login(auth)
    User.find_or_create_by(name: auth[:info][:name], email: auth[:info][:email].downcase)
  end
end
