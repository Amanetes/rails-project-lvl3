# frozen_string_literal: true

module ApplicationHelper
  def flash_class(level)
    mapping = {
      success: 'alert-success',
      notice: 'alert-info',
      alert: 'alert-danger',
      error: 'alert-danger',
      warn: 'alert-warning'
    }
    mapping[level.to_sym]
  end
end
