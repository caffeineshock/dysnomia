class EtherpadService
  attr_accessor :api_key, :url, :version

  def initialize(opts = {})
    {
      api_key: "",
      url: "",
      version: "1.2.9",
    }.merge(opts).each do |k,v|
      send("#{k}=", v)
    end
  end

  def assume_existing url
    
  end

  def create title, initial_text = nil
  	@pad = Pad.new(title: title)

  	if @pad.validate!
      create_remote_pad initial_text
      @pad.internal_name = @internal_name
      @pad.save!
      @pad
  	end
  end

  private

  def create_remote_pad initial_text
    @internal_name = generate_secret
    remote_pad = ether.pad(@internal_name)
    remote_pad.text = initial_text unless initial_text.blank?
  end

  def generate_secret
    SecureRandom.uuid
  end

  def ether
    @ether ||= EtherpadLite.connect(@url, @api_key, @version)
  end
end