# README
[![ruby](https://img.shields.io/badge/ruby-v2.6.3-red.svg)](https://www.ruby-lang.org/en/)
[![rails](https://img.shields.io/badge/rails-v6.0.2-orange.svg)](https://rubyonrails.org/)
[![Maintainability](https://api.codeclimate.com/v1/badges/85e7b18479b14f3cb801/maintainability)](https://codeclimate.com/github/mikeyduece/he_test/maintainability)
[![codecov](https://codecov.io/gh/mikeyduece/he_test/branch/master/graph/badge.svg)](https://codecov.io/gh/mikeyduece/he_test)
[![CircleCI](https://circleci.com/gh/mikeyduece/he_test.svg?style=svg)](https://circleci.com/gh/mikedyuece/he_test)

# Table of Contents
* 


Description
---
This is a small Rails API for searching for breweries in the US. A user must be registered and logged in to access
the endpoints relating to the breweries.

A logged in user can see a paginated list of breweries or add parameters to the url in order to
scope the results. Approved query parameters are as follows:
```
by_type by_city by_state by_tags by_name page per_page sort
```

A logged in user will also be able to sort the results by adding a `+` or `-` in front of the value they wish to 
sort by along with the `search` query parameter:

```
- for ASC (default)
+ for DESC
api_url/breweries?by_city=Denver&sort=+name
```

#### Endpoints
##### POST `/users`
> Creates/Registers user in the database using the following body structure
```
POST /users
{
	"user": {
		"first_name": "Test",
		"last_name": "User",
		"email": "my_email@gmail.com",
		"password": "password"
	}
}
```
##### POST `/oauth/token`
> Logs the user in receiving a Bearer token that is needed for all subsequent requests
```
{
    "grant_type" : "password",
    "client_id" : "{{client_id}}",
    "client_secret": "{{client_secret}}",
    "email" : "my_email@gmail.com",
    "password" : "password",
    "scopes" : "basic"
}
```

##### GET `/breweries`
> Returns a list of breweries, which can be scoped using the authorized query params listed above.
> `/breweries?by_city=Denver&page=2` will return the second page of breweries in Denver.

##### GET `/breweries/:id`
> Returns a specific brewery for the given id

System Requirements
---
>Ruby >= 2.6.3
>
>Rails >= 6.0.2

Initial Setup
---
1. Fork and or clone to your local machine
2. Run `bundle` in the project folder
3. Run `rails db:{create,migrate}` to setup the database
4. To use app locally `heroku local` to mimic the Heroku environment

Running Tests
---
Run `rspec` to run the full test suite.

Dependencies
---
##### All Environments
* [Rails](https://guides.rubyonrails.org/)
* [PostgreSQL](https://www.postgresql.org/)
* [Faraday](https://github.com/lostisland/faraday)
* [Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper)
* [Devise](https://github.com/heartcombo/devise)

##### Development
* [Rspec](https://github.com/rspec/rspec-rails)
* [Pry](https://github.com/rweng/pry-rails)

##### Test
* [VCR](https://github.com/vcr/vcr)
* [Webmock](https://github.com/bblimke/webmock)
* [Shoulda-Matchers](https://github.com/thoughtbot/shoulda-matchers)
* [Codecov](https://github.com/codecov/codecov-ruby)
* [DatabaseCleaner](https://github.com/DatabaseCleaner/database_cleaner)


