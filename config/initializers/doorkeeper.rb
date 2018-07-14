Doorkeeper.configure do
  # Change the ORM that doorkeeper will use (needs plugins)
  orm :active_record

  # This block will be called to check whether the resource owner is authenticated or not.
  resource_owner_authenticator do
    user = User.find_by_id(session[:user_id])
    return user if user.present?
  end

  resource_owner_from_credentials do |routes|
    user = User.find_for_database_authentication(email: params[:email])
    if user && user.valid_for_authentication? { user.valid_password?(params[:password]) }
      return user
    end
  end

end

module CustomTokenResponse
  def body
    user_details = User.find(@token.resource_owner_id)
    # call original `#body` method and merge its result with the additional data hash
   	super.merge({
   		status_code: 200,
   		message: I18n.t('devise.sessions.signed_in'),
   		result: user_details
   	})
  end
end

module CustomTokenErrorResponse
  def body
    {
      status_code: 401,
      message: I18n.t('devise.failure.invalid', authentication_keys: User.authentication_keys.join('/')),
      result: []
    }
    # or merge with existing values by
    # super.merge({key: value})
  end
end

Doorkeeper::OAuth::TokenResponse.send :prepend, CustomTokenResponse
Doorkeeper::OAuth::ErrorResponse.send :prepend, CustomTokenErrorResponse