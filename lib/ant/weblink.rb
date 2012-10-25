class Ant::Weblink < Ant::Client

  private

    def post path, secret, options={}
      page   = parse_page(options.delete(:url))
      params = { body: { http_body: page.body,
                         http_header: page.headers,
                         url: page.request.path.to_s }.to_json
                }
      super path, secret, params.merge(options)
    end

    def resource_path options={}
      library_id = options[:library_id] || 'default'
      id = options[:id]
      raise ArgumentError, "id is nil for Weblink resource" if id.nil?
      "/api/libraries/#{library_id}/weblinks/#{id}"
    end

    def collection_path options={}
      library_id = options[:library_id] || 'default'
      "/api/libraries/#{library_id}/weblinks"
    end

end
