class Api::V1::CoffeeController < JSONAPI::ResourceController
  def index
    @coffee = Coffee.all
    JSONAPI::ResourceSerializer.new(Api::V1::CoffeeResource).serialize_to_hash(Api::V1::CoffeeResource.new(coffee, nil))
  end

  def show
    @coffee = Coffee.find(params[:id])
    render json: serialize_coffee(@coffee)
  end

private

  def serialize_coffee(coffee)
    JSONAPI::ResourceSerializer.new(Api::V1::CoffeeResource).serialize_to_hash(Api::V1::CoffeeResource.new(coffee, nil))
  end

end
