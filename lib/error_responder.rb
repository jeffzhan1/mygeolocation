module ErrorResponder
  JSON_422 = {
    "title": "Unprocessable Entity",
    "status": 422,
    "error": {}
  }.freeze
  
  def render422(opts = {})
    respond_to do |format|
      format.html { render file: Rails.root.join('public/422.html'), status: :unprocessable_entity, layout: false }
      format.json { render422_json(opts) }
      format.any { head :unprocessable_entity }
    end
  end

  def render422_json(opts = {})
    response.headers['Content-Type'] = 'application/problem+json'
    json_ext = opts.dig(:json_ext)
    if json_ext.present?
      render json: JSON_422.merge(json_ext), status: :unprocessable_entity, layout: false
    else
      render json: JSON_422, status: :unprocessable_entity, layout: false
    end
  end

end
