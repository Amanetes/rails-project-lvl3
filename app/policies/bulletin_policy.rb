# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    author? || record.published?
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
    author? && (record.draft? || record.rejected?)
  end

  def publish?
    admin? && record.under_moderation?
  end

  def reject
    admin? && record.under_moderation?
  end

  def archive?
    (author? || admin?) && !record.archived?
  end

  private

  def admin?
    user&.admin?
  end

  def author?
    record.user_id == user&.id
  end
end
