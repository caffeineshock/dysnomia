$("#pad_url").keyup ->
  if $(this).val() == ""
    $("#pad_initial_text").removeAttr('readonly')
  else
    $("#pad_initial_text").attr('readonly','readonly');