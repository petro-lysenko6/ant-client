module Ant::Command
  class Weblink < Thor
    class_option :server, type: :string,
                          desc: 'Ant server API host',
                          default: 'beta.ant.com'

    desc 'weblink create [user_id] [api_key] [url]', 'Create weblink for user_id api_key url'
    def create user_id, api_key, url
      weblink = Ant::Weblink.new(options[:server])
      resp = weblink.create api_key, user_id: user_id, url: url
      if resp.code == 200
        say "Weblink created"
      else
        say "Error status: #{resp.code}"
      end
      say resp.body
    end

    desc 'weblink show [user_id] [api_key] [id]', 'Show weblink for user_id api_key'
    def show user_id, api_key, id
      weblink = Ant::Weblink.new(options[:server])
      resp = weblink.show api_key, user_id: user_id, id: id
      say resp.body
    end

  end

  class Library < Thor
    class_option :server, type: :string,
                          desc: 'Ant server API host',
                          default: 'beta.ant.com'

    desc 'library create [user_id] [api_key] [name] [description]', 'Create library for user_id api_key'
    def create user_id, api_key, name, description
      library = Ant::Library.new(options[:server])
      resp = library.create api_key, user_id: user_id, name: name, description: description
      if resp.code == 200
        say "Library created"
      else
        say "Error status: #{resp.code}"
      end
      say resp.body
    end

    desc 'library show [user_id] [api_key] [id]', 'Create library for user_id api_key'
    def show user_id, api_key, id
      library = Ant::Library.new(options[:server])
      resp = library.show api_key, user_id: user_id, id: id
      say resp.body
    end
  end
end