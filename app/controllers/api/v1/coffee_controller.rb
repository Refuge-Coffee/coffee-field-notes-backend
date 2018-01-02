class Api::V1::CoffeeController < JSONAPI::ResourceController
  def index
    @coffee = Coffee.last(9)
    @coffee = @coffee.map { |coffee| Api::V1::CoffeeResource.new(coffee, nil) }
    render json: JSONAPI::ResourceSerializer.new( Api::V1::CoffeeResource).serialize_to_hash(@coffee),
      content_type: "text/json"
  end

  def show
    @coffee = Coffee.find(params[:id])
    render json: serialize_coffee(@coffee)
  end

  def create
    @coffee = Coffee.new(build_coffee_params(request_json["data"]))
    if @coffee.save
      render json: serialize_coffee(@coffee), content_type: "text/json", status: 201
    else
      render json: serialize_coffee(@coffee), content_type: "text/json", status: 500
    end
  end

private

  def build_coffee_params(data)
    coffee_params = ActionController::Parameters.new(data)
    attributes = [
      :name, :origin, :elevation
    ]

    coffee_params.permit(
      attributes: attributes
    )[:attributes]
  end

  def request_json
    @request_json ||= JSON.parse(request.body.read)
  end

  def serialize_coffee(coffee)
    JSONAPI::ResourceSerializer.new(Api::V1::CoffeeResource).serialize_to_hash(Api::V1::CoffeeResource.new(coffee, nil))
  end

end
