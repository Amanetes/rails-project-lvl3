# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user
  end

  def new?
    user
  end

  def edit?
    author? || admin?
  end

  def update?
    author? || admin?
  end

  def destroy?
    admin?
  end

  def send_to_moderation?
    author?
  end

  def archive?
    author? || admin?
  end

  private

  def author?
    record.user_id == user&.id
  end
end
