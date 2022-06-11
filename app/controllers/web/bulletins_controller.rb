# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :set_bulletin, only: %i[show edit update destroy]
  before_action :authorize_bulletin!
  after_action :verify_authorized

  # TODO: заменить стейт в отображении объявлений
  def index
    @q = Bulletin.order(created_at: :desc).ransack(params[:q])
    @bulletins = @q.result.includes(:category).joins(:category)
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

  private

  def set_bulletin
    @bulletin = Bulletin.find(params[:id])
  end

  def authorize_bulletin!
    authorize(@bulletin || Bulletin)
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id)
  end
end
