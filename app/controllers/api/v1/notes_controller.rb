class Api::V1::NotesController < JSONAPI::ResourceController
  def index
    @notes = Note.all.limit(25)
    @notes = @notes.map { |note| Api::V1::NoteResource.new(note, nil) }
    render json: JSONAPI::ResourceSerializer.new(Api::V1::NoteResource).serialize_to_hash(@notes),
      content_type: "text/json"
  end

  def show
    @note = Note.find(params[:id])
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
    note_params = ActionController::Parameters.new(data)
    attributes = [
      :content, :time_of_day, :association
    ]

    note_params.permit(
      attributes: attributes
    )[:attributes]
  end

  def request_json
    @request_json ||= JSON.parse(request.body.read)
  end

  def serialize_note(note)
    JSONAPI::ResourceSerializer.new(Api::V1::NoteResource).serialize_to_hash(Api::V1::NoteResource.new(note, nil))
  end
end
