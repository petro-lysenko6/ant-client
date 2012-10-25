class Ant::Client

  VERSION = "1.0.5"

  include Ant::HMAC
  include HTTParty

  def initialize server=nil
    self.class.base_uri url_from(server)
  end

  def create secret, options={}
    post collection_path(options), secret, options
  end

  def show secret, options={}
    get resource_path(options), secret, options
  end

  def all secret, options={}
    get collection_path(options), secret, options
  end

  private

    def post path, secret, params={}
      opts = ant_options(params[:user_id], secret).merge(params)
      self.class.post(path, opts)
    end

    def get path, secret, params={}
      self.class.get(path, ant_options(params[:user_id], secret))
    end

    def ant_options user_id, secret
      time  = Time.now.to_i
      token = Ant::HMAC.hmac secret, user_id: user_id, ts: time
      { headers: { 'Content-Type'     => 'application/json',
                   'X-Requested-With' => 'XMLHttpRequest' },
        query: { user_id: user_id, ts: time, token: token } }
    end

    def parse_page url
      options = { headers: { 'Content-Type' => 'text/html; charset=utf-8',
                             'User-Agent'   => 'Mozilla/5.0' } }
      self.class.get(url_from(url), options)
    end

    def url_from url
      if url =~ /^https?:\/\//
        url
      else
        "http://#{url}"
      end
    end

end