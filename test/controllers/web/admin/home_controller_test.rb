# frozen_string_literal: true

require 'test_helper'

class Web::Admin::HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = sign_in(users(:one))
  end

  test 'should GET admin/home#index' do
    get admin_root_path
    assert_response :success
  end

  test 'reject GET admin/home#index' do
    sign_in(users(:two))
    get admin_root_path
    assert_response :redirect
  end
end
