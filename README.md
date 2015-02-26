## Dysnomia

Dysnomia (greek: Δυσνομία) is the daemon of lawlessness and daughter of Eris.Dysnomia is also a Rails app to allow a remote team to collaborate via Internet. It specifically encourages a lawless collaboration by allowing users to edit each others contributions.

## Features

Currently Dysnomia encompasses:

 - A calendar
 - Todo lists
 - File uploads
 - Chats
 - A wiki

The app also supports multi-tenancy with a catch: User accounts can be linked with multiple tenants at once.

**But wait!** There's more: The app is only available in german at the moment - though that will hopefully change in the near future.

## 3rd party software

Instead of a reinventing the wheel and say providing a forum module, *Dysnomia* instead comes with some glue for existing 3rd-party products:

### Forum

Tenants can be configured to use an existing [Discourse](http://www.discourse.org) instance: *Dysnomia* will then function as a single-sign on/off endpoint and synchronizes changes to users with Discourse.

### Collaborative editor

*Dysnomia* can be configured to use an existing [Etherpad](http://www.etherpad.org) instance. Pads can be created, deleted and edited (via IFRAME) from the app.

## Installation

1. Install required gems (`bundle`)
2. Copy and customize files with extension .example
3. Edit `db/seeds.rb` to customize the admin account
4. Setup the database (`rake db:setup`)
5. Copy emoji images to public directory (`rake emoji`)
6. Start processes with [Foreman](https://github.com/ddollar/foreman) (`foreman start`)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

