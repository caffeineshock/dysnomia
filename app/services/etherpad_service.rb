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

  def create params
    @pad = Pad.new(params)

    if @pad.validate!
      if params[:url].present?
        assume_remote_pad params[:url]
      else
        create_remote_pad params[:initial_text]
      end

      @pad.internal_name = @internal_name
      @pad.save!
      @pad
    end
  rescue UrlInvalidException => e
    @pad.errors.add(:url, e.message)
    raise ActiveRecord::RecordInvalid.new(@pad)
  end

  def destroy id
    @pad = Pad.friendly.find(id)

    if @pad.destroy
      remote_pad = ether.pad(@pad.internal_name)
      remote_pad.delete
    end
  end

  private

  def assume_remote_pad url
    raise UrlInvalidException, "Instanze wird nicht unterstützt!" unless url.starts_with? @url

    if match = url.match(/\/p\/(.+)/)
      @internal_name = match[1]
      ether.pad(@internal_name)
    else
      raise UrlInvalidException, "URL konnte nicht verarbeitet werden!"
    end
  end

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
