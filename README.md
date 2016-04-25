# Fluxx Ruby Bindings

### NOTE: Currently in pre-alpha. Not for use in production.

Ruby binding for [Fluxx](fluxx.io) API.

The Fluxx Ruby bindings offer a simple Ruby wrapper for convenient use with the
Fluxx REST API. It provides the `Fluxx` module with access to API resources (e.g.
`Fluxx::GrantRequest`) that initialize themselves dynamically from API responses.

Features:

* Easy configuration for fast setup and use.
* Syntax that cleanly mimics `ActiveRecord`.
* Automatic pagination.
* API communication that "just works." Serialization, query parameters, and request payload expectations are fulfilled.

## Requirements

* Ruby 1.9.3 or above

## Bundler

`Gemfile`:

``` ruby
gem 'fluxx', github: 'fluxxlabs/fluxx-ruby'
```

Support via rubygems on the way!

## Development

```
irb -I ./lib
```

## Configuration

### Prerequisite

* Login to your app ({yourorg}.fluxx.io)
* Navigate to {yourorg}.fluxx.io/oauth/applications
* Click on 'New Application'
* Add a name and redirect URL (just put the base URL)
* Note the Application ID and Secret. Click on Authorize.
* On the following page, click the Authorize button.

### Initialization

To require, configure, and authorize the gem for your app:

```ruby
require 'fluxx'

Fluxx.configure do |config|
  config.server_url          = "https://{yourorg}.fluxx.io"
  config.oauth_client_id     = {application_id}
  config.oauth_client_secret = {application_secret}
end
```

### Usage

An API resource can be consumed by using it's class.

For example, to load a list of all users:

```
  users = Fluxx::User.list
```

You can access data on an API resource:

```
  user = users.first
  user.first_name
  user.last_name
```

You can also access associations through this loaded API resource:

```
  profiles = user.user_profiles
```

Creating:

```
  @user = Fluxx::User.create(first_name: 'Test', last_name: 'Tester')
```

Updating:

```
  @user.update(last_name: 'McTestFace')
```

Deleting

```
  @user.destroy
```












