# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  before_action :set_bulletin, only: %i[publish archive reject]
  before_action :authorize_bulletin!
  after_action :verify_authorized

  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc)
  end

  def publish
    if @bulletin.publish!
      flash[:success] = 'Опубликовано'
      redirect_to admin_root_path
    else
      flash.now[:error] = 'Нельзя опубликовать'
      render :index
    end
  end

  private

  def authorize_bulletin!
    authorize(@bulletin || Bulletin)
  end
end
