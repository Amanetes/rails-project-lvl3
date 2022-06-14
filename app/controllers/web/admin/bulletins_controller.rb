# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  before_action :set_bulletin, only: %i[publish archive reject]

  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc)
  end

  def publish
    if @bulletin.publish!
      flash[:success] = t('.success')
      redirect_to admin_root_path
    else
      flash.now[:error] = t('.error')
      render :index
    end
  end

  def reject
    if @bulletin.reject!
      flash[:success] = t('.success')
      redirect_to admin_root_path
    else
      flash.now[:error] = t('.error')
      render :index
    end
  end

  def archive
    if @bulletin.archive!
      flash[:success] = t('.success')
      redirect_to admin_root_path
    else
      flash.now[:error] = t('.error')
      render :index
    end
  end

  private

  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end
end
