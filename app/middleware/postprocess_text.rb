class PostprocessText
  def initialize(app)
    @app = app
  end
  
  def call(env)
    if env["PATH_INFO"] == "/postprocess"
      [200, {"Content-Type" => "text/html"}, [PostprocessorService.instance.toHTML(env['rack.input'].read)]]
    else
      @app.call(env)
    end
  end
end