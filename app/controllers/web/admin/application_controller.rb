# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  before_action :authenticate_admin!
  skip_before_action :authenticate_user!
end
