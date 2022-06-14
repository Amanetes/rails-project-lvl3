# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  before_action :authenticate_user!
end
