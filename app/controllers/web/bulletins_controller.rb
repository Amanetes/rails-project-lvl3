# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :set_bulletin, only: %i[show edit update send_to_moderation archive]
  before_action :authorize_bulletin!
  before_action :authenticate_user!, except: %i[index show]
  after_action :verify_authorized

  def index
    @q = Bulletin.published.ransack(params[:q])
    @bulletins = @q.result
                   .order(created_at: :desc)
                   .includes(:category)
                   .joins(:category)
                   .page(params[:page])
  end

  def new
    @bulletin = Bulletin.new
  end

  def show; end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save
      flash[:success] = t('.success')
      redirect_to @bulletin
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @bulletin.update(bulletin_params)
      flash[:success] = t('.success')
      redirect_to @bulletin
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def send_to_moderation
    if @bulletin.send_to_moderation!
      flash[:success] = t('.success')
      redirect_to profile_path
    else
      flash.now[:error] = t('.error')
      render :show
    end
  end

  def archive
    if @bulletin.archive!
      flash[:success] = t('.success')
      redirect_to profile_path
    else
      flash.now[:error] = t('.error')
      render :show
    end
  end

  private

  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end

  def authorize_bulletin!
    authorize(@bulletin || Bulletin)
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :image, :category_id)
  end
end
