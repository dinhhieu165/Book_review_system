module UsersHelper
  def is_admin
    current_user.admin == 1
  end
end
