# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:two)
    @bulletin = bulletins(:two)
    @category = categories(:one)

    @attrs = {
      title: Faker::Construction.heavy_equipment,
      description: Faker::Lorem.sentence,
      user: @user,
      category_id: @category.id,
      image: fixture_file_upload('hexlet.jpeg', 'image/jpeg')
    }
  end

  test 'should GET bulletins#index' do
    get root_path
    assert_response :success
  end

  test 'should GET bulletins#show' do
    get bulletin_path(bulletins(:three))
    assert_response :success
  end

  test 'should GET bulletins#new' do
    sign_in(@user)
    get new_bulletin_path
    assert_response :success
  end

  test 'should POST bulletins#create' do
    sign_in(@user)
    post bulletins_path, params: { bulletin: @attrs }

    bulletin = Bulletin.find_by! title: @attrs[:title]
    assert { bulletin }
  end

  test 'should GET bulletins#edit' do
    sign_in(@user)
    get edit_bulletin_path(@bulletin)
    assert_response :success
  end

  test 'should PATCH bulletins#update' do
    sign_in(@user)
    patch bulletin_path(@bulletin), params: { bulletin: @attrs }
    assert_redirected_to bulletin_path(@bulletin)

    @bulletin.reload

    assert { @bulletin.title == @attrs[:title] }
  end

  test 'should PATCH bulletins#send_to_moderation' do
    bulletin = bulletins(:draft)
    sign_in(@user)
    patch send_to_moderation_bulletin_path(bulletin)
    bulletin.reload
    assert { bulletin.under_moderation? }
  end

  test 'should PATCH bulletins#archive' do
    bulletin = bulletins(:draft)
    sign_in(@user)
    patch archive_bulletin_path(bulletin)
    bulletin.reload
    assert { bulletin.archived? }
  end
end
