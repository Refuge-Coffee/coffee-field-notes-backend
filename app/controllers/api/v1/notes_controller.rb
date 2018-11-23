class Api::V1::NotesController < JSONAPI::ResourceController
  def index
    if params["sort_by"]
      query = "#{params['sort_by']} #{params['direction']}"
      @notes = Note.order(query).limit(25)
    else
      @notes = Note.all.limit(25)
    end
    @notes = @notes.map { |note| Api::V1::NoteResource.new(note, nil) }
    render json: JSONAPI::ResourceSerializer.new(Api::V1::NoteResource).serialize_to_hash(@notes),
      content_type: "text/json"
  end

  def show
    @note = Note.find(params[:id])
    render json: serialize_note(@note)
  end

  def update
    @note = Note.find(params[:id])
    @note.update(build_note_params(request_json["data"]))
    render json: serialize_note(@note)
  end

  def create
    @note = Note.new(build_note_params(request_json["data"]))
    if @note.save
      render json: serialize_note(@note), content_type: "text/json", status: 201
    else
      render json: serialize_note(@note), content_type: "text/json", status: 500
    end
  end

private

  def build_note_params(data)
    data["attributes"]["bean_id"] = data["relationships"]["bean"]["data"]["id"]
    note_params = ActionController::Parameters.new(data)
    attributes = [
      :content, :time_of_day, :bean_id
    ]
  
    note_params.permit(
      attributes: attributes
    )
  end

  def request_json
    @request_json ||= JSON.parse(request.body.read)
  end

  def serialize_note(note)
    JSONAPI::ResourceSerializer.new(Api::V1::NoteResource).serialize_to_hash(Api::V1::NoteResource.new(note, nil))
  end
end
