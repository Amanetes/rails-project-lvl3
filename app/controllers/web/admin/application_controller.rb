# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  before_action :authenticate_admin!
  before_action :authenticate_user!
end
