class AddAdminRole < ActiveRecord::Migration[6.1]
  def change
    User.find_by!(email: 'ser_8904@mail.ru')&.update(admin: true)
  end
end
