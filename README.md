## Dysnomia

Dysnomia (greek: Δυσνομία) is the daemon of lawlessness and daughter of Eris.Dysnomia is also a Rails app to allow a remote team to collaborate via Internet. It specifically encourages a lawless collaboration by allowing users to edit each others contributions.

## Features

Currently Dysnomia encompasses:

 - Calendar
 - Todo lists
 - Forum
 - File uploads
 - Chats

Instead of a custom forum module, the app is designed to utilize an existing [Discourse](http://www.discourse.org) instance (because it's awesome): Dysnomia will function as a single-sign on endpoint and synchronizes changes to users with Discourse.

The app also supports multi-tenancy with a catch: User accounts can be linked multiple tenants at once.

**But wait!** There's more: The app is mostly only available in german - though that will hopefully change in the near future.

## Installation

1. Install required gems (`bundle`)
2. Copy and customize files with extension .example
3. Setup the database (`rake db:setup`)
4. Copy emoji images to public directory (`rake emoji`)
5. Start processes with Foreman (`foreman start`)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

