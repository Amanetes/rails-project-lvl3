# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = sign_in(users(:one))
    @category = categories(:one)
    @attrs = {
      name: Faker::TvShows::BigBangTheory.character
    }
  end

  test 'should GET admin/categories#index' do
    get admin_categories_path
    assert_response :success
  end

  test 'should GET admin/categories#new' do
    get new_admin_category_path
    assert_response :success
  end

  test 'should POST admin/categories#create' do
    post admin_categories_path, params: { category: @attrs }

    category = Category.find_by! name: @attrs[:name]
    assert { category }
  end

  test 'should GET admin/categories#edit' do
    get edit_admin_category_path(@category)
    assert_response :success
  end

  test 'should PATCH admin/categories#update' do
    patch admin_category_path(@category), params: { category: @attrs }
    assert_redirected_to admin_categories_path

    @category.reload
    assert { @category.name == @attrs[:name] }
  end

  test 'should DELETE admin/categories#destroy' do
    delete admin_category_path(@category)

    assert { !Category.exists?(@category.id) }

    assert_redirected_to admin_categories_path
  end
end
