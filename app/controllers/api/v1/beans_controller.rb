class Api::V1::BeansController < JSONAPI::ResourceController
  def index
    @beans = Bean.last(9)
    @beans = @beans.map { |bean| Api::V1::BeanResource.new(bean, nil) }
    render json: JSONAPI::ResourceSerializer.new( Api::V1::BeanResource).serialize_to_hash(@bean),
      content_type: "text/json"
  end

  def show
    @bean = Bean.find(params[:id])
    render json: serialize_bean(@bean)
  end

  def create
    @bean = Bean.new(build_bean_params(request_json["data"]))
    if @bean.save
      render json: serialize_bean(@bean), content_type: "text/json", status: 201
    else
      render json: serialize_bean(@bean), content_type: "text/json", status: 500
    end
  end

private

  def build_bean_params(data)
    bean_params = ActionController::Parameters.new(data)
    attributes = [
      :name, :origin, :elevation
    ]

    bean_params.permit(
      attributes: attributes
    )[:attributes]
  end

  def request_json
    @request_json ||= JSON.parse(request.body.read)
  end

  def serialize_bean(bean)
    JSONAPI::ResourceSerializer.new(Api::V1::BeanResource).serialize_to_hash(Api::V1::BeanResource.new(bean, nil))
  end

end
