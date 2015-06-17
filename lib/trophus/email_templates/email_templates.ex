defmodule Trophus.EmailTemplates do
  def register_template(user) do
    """
      <h1>This is the HTML the user will receive upon registering</h1>
      You can access the user attributes: #{user.email}
    """
  end

  def password_recovery_template(user) do
    """
      <h1>This is the HTML the user will receive upon requesting a new password</h1>
      You should provide a link to your app where the token will be processed:
      <a href="http://yourawesomeapp.com/recover_password?token=#{user.recovery_hash}">like this</a>
    """
  end
end