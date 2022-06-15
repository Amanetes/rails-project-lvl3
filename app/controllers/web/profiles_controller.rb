# frozen_string_literal: true

class Web::ProfilesController < Web::ApplicationController
  def show
    @q = current_user.bulletins.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc).page(params[:page])
  end
end
