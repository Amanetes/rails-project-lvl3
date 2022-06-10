# frozen_string_literal: true

class Web::SessionsController < Web::ApplicationController

  def destroy
    sign_out
    flash[:info] = 'Вы вышли из системы'
    redirect_to root_path
  end
end
