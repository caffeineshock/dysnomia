class SingleSignOnService
  ACCESSORS = [:nonce, :name, :username, :email, :about_me, :external_email, :external_username, :external_name, :external_id]
  FIXNUMS = []
  NONCE_EXPIRY_TIME = 10.minutes

  attr_accessor(*ACCESSORS)
  attr_accessor :secret, :query_string, :user, :base_url

  def initialize(opts = {})
    {
      secret: "",
      query_string: "",
      user: nil,
      base_url: ""
    }.merge(opts).each do |k,v|
      send("#{k}=", v)
    end
  end

  def redirect_url
    parse_request(@query_string)
    map_user_to_discourse(@user)
    to_url
  end

  private

  def parse_request(payload)
    parsed = Rack::Utils.parse_query(payload)
    
    unless parsed.has_key?("sso")
      raise RuntimeError, "Missing SSO parameter"
    end

    if sign(parsed["sso"]) != parsed["sig"]
      raise RuntimeError, "Bad signature for payload"
    end

    decoded = Base64.decode64(parsed["sso"])
    decoded_hash = Rack::Utils.parse_query(decoded)

    ACCESSORS.each do |k|
      val = decoded_hash[k.to_s]
      val = val.to_i if FIXNUMS.include? k
      send("#{k}=", val)
    end
  end

  def map_user_to_discourse user
    @email = user.email
    @name = user.username
    @username = user.email
    @external_id = user.id
  end

  def sign(payload)
    OpenSSL::HMAC.hexdigest("sha256", @secret, payload)
  end

  def to_url
    "#{@base_url}?#{payload}"
  end

  def payload
    payload = Base64.encode64(unsigned_payload)
    "sso=#{CGI::escape(payload)}&sig=#{sign(payload)}"
  end

  def unsigned_payload
    payload = {}
    ACCESSORS.each do |k|
     next unless (val = send k)

     payload[k] = val
    end

    Rack::Utils.build_query(payload)
  end
end