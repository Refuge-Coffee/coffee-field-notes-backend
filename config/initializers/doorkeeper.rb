Doorkeeper.configure do
  # Change the ORM that doorkeeper will use (needs plugins)
  orm :active_record

  # This block will be called to check whether the resource owner is authenticated or not.
  resource_owner_authenticator do
    User.find_by_id(session[:user_id]) || nil
  end

  # In this flow, a token is requested in exchange for the resource owner credentials (username and password)
  resource_owner_from_credentials do |routes|
    user = User.find_for_database_authentication(email: params[:username])
    if user && user.valid_for_authentication? { user.valid_password?(params[:password]) }
      user
    end
  end

  # Access token expiration time (default 2 hours).
  # If you want to disable expiration, set this to nil.
  access_token_expires_in 5.days

  #
  # implicit and password grant flows have risks that you should understand
  # before enabling:
  #   http://tools.ietf.org/html/rfc6819#section-4.4.2
  #   http://tools.ietf.org/html/rfc6819#section-4.4.3
  #
  # grant_flows %w(authorization_code client_credentials)
  grant_flows %w(password)

  # Under some circumstances you might want to have applications auto-approved,
  # so that the user skips the authorization step.
  # For example if dealing with a trusted application.
  # skip_authorization do |resource_owner, client|
  #   client.superapp? or resource_owner.admin?
  # end
  skip_authorization do
    true
  end

end

module CustomTokenResponse
  def body
    user = User.find(@token.resource_owner_id)
   	super.merge({
   		status_code: 200,
   		message: I18n.t('devise.sessions.signed_in'),
   		result: user
   	})
  end
end

module CustomTokenErrorResponse
  def body
    {
      status_code: 401,
      error: {
        message: I18n.t('devise.failure.invalid', authentication_keys: User.authentication_keys.join('/'))
      },
      result: []
    }
  end
end

Doorkeeper::OAuth::TokenResponse.send :prepend, CustomTokenResponse
Doorkeeper::OAuth::ErrorResponse.send :prepend, CustomTokenErrorResponse