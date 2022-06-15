# frozen_string_literal: true

require 'test_helper'

class Web::ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in(users(:one))
  end
  test 'should GET profiles#show' do
    get profile_path
    assert_response :success
  end
end
