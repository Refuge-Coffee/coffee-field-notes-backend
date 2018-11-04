class Api::V1::RoastersController < JSONAPI::ResourceController
  def index
    if params["sort_by"]
      query = "#{params['sort_by']} #{params['direction']}"
      @roasters = Roaster.order(query).limit(25)
    else
      @roasters = Roaster.all.limit(25)
    end
    @roasters = @roasters.map { |roaster| Api::V1::RoasterResource.new(roaster, nil) }
    render json: JSONAPI::ResourceSerializer.new(Api::V1::RoasterResource).serialize_to_hash(@roasters),
      content_type: "text/json"
  end

  def show
    @roaster = Roaster.find(params[:id])
    render json: serialize_roaster(@roaster)
  end

  def create
    @roaster = Roaster.new(build_roaster_params(request_json["data"]))
    if @roaster.save
      render json: serialize_roaster(@roaster), content_type: "text/json", status: 201
    else
      render json: serialize_roaster(@roaster), content_type: "text/json", status: 500
    end
  end

private

  def build_roaster_params(data)
    roaster_params = ActionController::Parameters.new(data)
    attributes = [
      :name
    ]

    roaster_params.permit(
      attributes: attributes
    )[:attributes]
  end

  def request_json
    @request_json ||= JSON.parse(request.body.read)
  end

  def serialize_roaster(roaster)
    JSONAPI::ResourceSerializer.new(Api::V1::RoasterResource).serialize_to_hash(Api::V1::RoasterResource.new(roaster, nil))
  end
end
