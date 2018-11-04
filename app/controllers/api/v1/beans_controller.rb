class Api::V1::BeansController < JSONAPI::ResourceController
  def index
    
    if params[:filter] && params[:filter][:query]
      @beans = beans_matching_search(params[:filter][:query])
    else 
      @beans = Bean.all.limit(25)
    end

    @beans = @beans.map { |bean| Api::V1::BeanResource.new(bean, nil) }
    
    render json: JSONAPI::ResourceSerializer.new(Api::V1::BeanResource).serialize_to_hash(@beans),
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

  def beans_matching_search(term)
    matches = []
    regex_term = Regexp.new(term)
    Bean.find_each do |bean|
      if regex_term =~ bean.name
        matches.push(bean)
      end
    end
    matches
  end

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
