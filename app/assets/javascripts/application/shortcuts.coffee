$.turboInit -> 
  Mousetrap.bind 's', (e) -> $('.search-box').foundation 'reveal', 'open'
  Mousetrap.bind 'h', (e) -> $('#help').foundation 'reveal', 'open'
  Mousetrap.bind 'l', (e) -> $('#logout').trigger('click')
  Mousetrap.bind 'V', (e) -> $('#version').foundation 'reveal', 'open'
  Mousetrap.bind 'T', (e) -> window.location = Routes.tenants_path()
  Mousetrap.bind 'S', (e) -> window.location = Routes.sidekiq_web_path()
  Mousetrap.bind 'L', (e) -> window.location = Routes.letter_opener_web_letters_path()