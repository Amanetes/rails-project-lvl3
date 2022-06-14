# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :set_bulletin, only: %i[show edit update send_to_moderation archive]
  before_action :authorize_bulletin!
  skip_before_action :authenticate_user!, only: %i[index show]
  after_action :verify_authorized

  def index
    @q = Bulletin.published.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc).includes(:category).joins(:category)
  end

  def new
    @bulletin = Bulletin.new
  end

  def show; end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save
      flash[:success] = 'Объявление создано'
      redirect_to @bulletin
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @bulletin.update(bulletin_params)
      flash[:success] = 'Объявление обновлено'
      redirect_to @bulletin
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def send_to_moderation
    if @bulletin.send_to_moderation!
      flash[:success] = 'Отправлено на модерацию'
      redirect_to profile_path
    else
      flash.now[:error] = 'Нельзя отправить на модерацию'
      render :show
    end
  end

  def archive
    if @bulletin.archive!
      flash[:success] = 'Отправлено в архив'
      redirect_to profile_path
    else
      flash.now[:error] = 'Нельзя отправить в архив'
      render :show
    end
  end

  private

  def authorize_bulletin!
    authorize(@bulletin || Bulletin)
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :image, :category_id)
  end
end
