# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = sign_in(users(:one))
  end

  test 'should GET admin/bulletins#index' do
    get admin_bulletins_path
    assert_response :success
  end

  test 'reject GET admin/bulletins#index' do
    sign_in(users(:two))
    get admin_root_path
    assert_response :redirect
  end

  test 'should PATCH admin/bulletins#publish' do
    bulletin = bulletins(:two)

    patch publish_admin_bulletin_path(bulletin)
    bulletin.reload
    assert { bulletin.published? }
  end

  test 'should PATCH admin/bulletins#rejected' do
    bulletin = bulletins(:two)

    patch reject_admin_bulletin_path(bulletin)
    bulletin.reload
    assert { bulletin.rejected? }
  end

  test 'should PATCH admin/bulletins archived' do
    bulletin = bulletins(:two)

    patch archive_admin_bulletin_path(bulletin)
    bulletin.reload
    assert { bulletin.archived? }
  end
end
