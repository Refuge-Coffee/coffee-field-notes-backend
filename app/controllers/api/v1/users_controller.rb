class Api::V1::UsersController < ApplicationController

  def new
    @user = User.new
    render json: serialize_user(@user)
  end

  def create
    @user = User.new(build_user_params(request_json["data"]))
    if @user.save
      render json: serialize_user(@user), content_type: "text/json", status: 201
    else
      render json: serialize_user(@user), content_type: "text/json", status: 500
    end
  end

private

  def build_user_params(data)
    user_params = ActionController::Parameters.new(data)
    attributes = [
      :email, :password, :password_confirmation
    ]

    user_params.permit(
      attributes: attributes
    )[:attributes]
  end

  def request_json
    @request_json ||= JSON.parse(request.body.read)
  end

  def serialize_user(user)
    JSONAPI::ResourceSerializer.new(Api::V1::UserResource).serialize_to_hash(Api::V1::UserResource.new(user, nil))
  end
end
