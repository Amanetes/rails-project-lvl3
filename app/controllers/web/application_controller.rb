# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  before_action :authenticate_user!

  private

  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end

end
