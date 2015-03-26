class SingleSignOnService
  ACCESSORS = [:nonce, :name, :username, :email, :avatar_url, :avatar_force_update, :about_me, :external_id, :return_sso_url, :admin, :moderator]
  FIXNUMS = []
  NONCE_EXPIRY_TIME = 10.minutes

  attr_accessor(*ACCESSORS)
  attr_accessor :secret, :query_string, :user, :discourse_base_url, :dysnomia_base_url

  def initialize(opts = {})
    {
      secret: "",
      query_string: "",
      user: nil,
      discourse_base_url: "",
      dysnomia_base_url: ""
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
    @username = user.username
    @email = user.email
    @admin = boolean(user.admin?)
    @moderator = boolean(user.moderator?)
    @external_id = user.id

    if user.avatar.exists?
      @avatar_url = @dysnomia_base_url + user.avatar.url
      @avatar_force_update = 'true'
    end
  end

  def sign(payload)
    OpenSSL::HMAC.hexdigest("sha256", @secret, payload)
  end

  def to_url
    "#{@discourse_base_url}?#{payload}"
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

  private

  def boolean value
    value ? 'true' : 'false'
  end
end
