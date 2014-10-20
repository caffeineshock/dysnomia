# Add middleware to postprocess user-defined content as first filter
Rails.configuration.middleware.insert_before 0, "PostprocessText"