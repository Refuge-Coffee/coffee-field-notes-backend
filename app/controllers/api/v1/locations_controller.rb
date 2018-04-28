class Api::V1::LocationsController < JSONAPI::ResourceController
  def index
    if params["sort_by"]
      query = "#{params['sort_by']} #{params['direction']}"
      @locations = Location.order(query).limit(25)
    else
      @locations = Location.all.limit(25)
    end
    @locations = @locations.map { |location| Api::V1::LocationResource.new(location, nil) }
    render json: JSONAPI::ResourceSerializer.new(Api::V1::LocationResource).serialize_to_hash(@locations),
      content_type: "text/json"
  end

  def show
    @location = Location.find(params[:id])
    render json: serialize_location(@location)
  end

  def create
    @location = Location.new(build_location_params(request_json["data"]))
    if @location.save
      render json: serialize_location(@location), content_type: "text/json", status: 201
    else
      render json: serialize_location(@location), content_type: "text/json", status: 500
    end
  end

private

  def build_location_params(data)
    location_params = ActionController::Parameters.new(data)
    attributes = [
      :name, :website, :rating, :address
    ]

    location_params.permit(
      attributes: attributes
    )[:attributes]
  end

  def request_json
    @request_json ||= JSON.parse(request.body.read)
  end

  def serialize_location(location)
    JSONAPI::ResourceSerializer.new(Api::V1::LocationResource).serialize_to_hash(Api::V1::LocationResource.new(location, nil))
  end
end
