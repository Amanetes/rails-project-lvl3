# frozen_string_literal: true

require 'test_helper'

class Web::SessionControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in(users(:one))
  end

  test 'should DELETE sessions#destroy' do
    delete session_path(@user)

    assert_redirected_to root_path
    assert { !signed_in? }
  end
end
