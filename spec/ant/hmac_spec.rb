require 'spec_helper'

describe Ant::HMAC do

  it 'should generate token' do
    opts = { user_id: 1, ts: Time.now.to_i }
    token = Ant::HMAC.hmac 'secret', opts
    hmac = OpenSSL::HMAC.new 'secret', 'SHA1'
    hmac << opts[:user_id].to_s << opts[:ts].to_s
    token.should == hmac.hexdigest
  end

  it 'should raise ArgumentError if user_id or ts not given' do
    expect { Ant::HMAC.hmac 'secret', user_id: 1 }.to raise_error(ArgumentError)
    expect { Ant::HMAC.hmac 'secret', ts: Time.now }.to raise_error(ArgumentError)
  end

  it 'should generate random secret' do
    secret = Ant::HMAC.generate_secret
    secret.size.should be(32)
  end

  describe 'Verification' do
    before do
      @time    = Time.now.to_i
      @secret  = Ant::HMAC.generate_secret
      @token   = Ant::HMAC.hmac @secret, { user_id: 1, ts: @time }
      @object  = OpenStruct.new(api_key: @secret)
    end

    it 'verify HMAC by token' do
      result = Ant::HMAC.verify? @object, user_id: 1, ts: @time, token: @token
      result.should be(@object)
    end

    it 'should not verify HMAC if time is more than 300 sec' do
      result = Ant::HMAC.verify? @object, user_id: 1, ts: @time + 300, token: @token
      result.should be_nil
    end

    it 'should not verify HMAC if time is not the same' do
      result = Ant::HMAC.verify? @object, user_id: 1, ts: @time - 1, token: @token
      result.should be_nil
    end

    it 'should not verify HMAC if user_id is not the same' do
      result = Ant::HMAC.verify? @object, user_id: 2, ts: @time, token: @token
      result.should be_nil
    end
  end

end