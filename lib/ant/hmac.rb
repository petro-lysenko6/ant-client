module Ant::HMAC

  def verify? object, options={}
    raise ArgumentError, "HMAC object not found." if object.nil?
    return if Time.now.to_i - options[:ts].to_i > 300
    return object if options[:token] == hmac(object.api_key, options)
  end

  def hmac secret, options={}
    user_id, ts = options[:user_id], options[:ts]
    raise ArgumentError, "user_id: #{user_id.nil? ? 'is nil' : user_id}
                          ts: #{ts.nil? ? 'is nil' : ts}
                          for HMAC" if user_id.nil? || ts.nil?
    hmac = OpenSSL::HMAC.new secret, 'SHA1'
    hmac << user_id.to_s << ts.to_s
    hmac.hexdigest
  end

  def generate_secret
    SecureRandom.base64(24).tr('+/=', 'xyz')
  end

  module_function :hmac, :verify?, :generate_secret

end