# frozen_string_literal: true

class Web::SessionsController < Web::ApplicationController
  def destroy
    sign_out
    flash[:notice] = t('.notice')
    redirect_to root_path
  end
end
