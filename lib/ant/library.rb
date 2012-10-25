class Ant::Library < Ant::Client

  private

    def post path, secret, options={}
      params = { body: { description: options.delete(:description),
                         name:        options.delete(:name) }.to_json }
      super path, secret, params.merge(options)
    end

    def resource_path options={}
      id = options[:id] || 'default'
      "/api/libraries/#{id}"
    end

    def collection_path options={}
      "/api/libraries/"
    end

end