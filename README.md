# README
[![ruby](https://img.shields.io/badge/ruby-v2.6.3-red.svg)](https://www.ruby-lang.org/en/)
[![rails](https://img.shields.io/badge/rails-v6.0.2-orange.svg)](https://rubyonrails.org/)
[![Maintainability](https://api.codeclimate.com/v1/badges/85e7b18479b14f3cb801/maintainability)](https://codeclimate.com/github/mikeyduece/he_test/maintainability)
[![codecov](https://codecov.io/gh/mikeyduece/he_test/branch/master/graph/badge.svg)](https://codecov.io/gh/mikeyduece/he_test)
[![CircleCI](https://circleci.com/gh/mikeyduece/he_test.svg?style=svg)](https://circleci.com/gh/mikedyuece/he_test)

# Table of Contents
* [Description](#description)
* [Endpoints](#endpoints)
* [System Requirements](#system-requirements)
* [Initial Setup](#initial-setup)
* [Running Tests](#running-tests)
* [Dependencies](#dependencies)


Description
---
This is a small Rails API for searching breweries in the US. A user must be registered and logged in to access
the endpoints relating to the breweries.

A logged in user can see a paginated list of breweries or add parameters to the url in order to
scope the results. Approved query parameters are as follows:
```
by_type by_city by_state by_tags by_name page per_page sort
```

A logged in user will also be able to sort the results by adding a `+` or `-` in front of the value they wish to 
sort by along with the `sort` query parameter:

```
- for ASC (default)
+ for DESC
/api/v1/breweries?by_city=Denver&sort=+name
```

The app is hosted on Heroku @ [he-test.herokuapp.com/](https://he-test.herokuapp.com/)


#### Endpoints
  * The base url for all requests on Heroku is `https://he-test.herokuapp.com/`
  * The base url for all local requests is `http://localhost:5000`
##### POST `/api/v1/users`
> Creates/Registers a user in the database using the following body structure
```
POST /api/v1/users
{
	"user": {
		"first_name": "Test",
		"last_name": "User",
		"email": "my_email@gmail.com",
		"password": "password"
	}
}

# Sample Return
{
    "status": 201,
    "message": null,
    "user": {
        "id": 1,
        "email": "my_email@gmail.com",
        "first_name": "Test",
        "last_name": "User"
    }
}
```
##### POST `/oauth/token`
> Logs the user in receiving a Bearer token that is needed for all subsequent requests
> and will need to be added as a header `'Authorization': Bearer {{token}}'`
```
# Submitted params to login
{
    "grant_type" : "password",
    "client_id" : "{{client_id}}",
    "client_secret": "{{client_secret}}",
    "email" : "my_email@gmail.com",
    "password" : "password",
    "scopes" : "basic"
}

# Return with token
{
    "access_token": "POoRfOwc6QBCQCE7Vh381Zf8GmBkKQhIj0JWmnTvRtQ",
    "token_type": "Bearer",
    "expires_in": 7200,
    "created_at": 1584868430
}
```

##### GET `/api/v1/breweries`
> Returns a list of breweries, which can be scoped using the authorized query params listed above.
> `/api/v1/breweries?by_city=Birmingham` will return the first page of breweries in Birmingham. Example below:
```
{
    "status": 200,
    "message": null,
    "breweries": [
        {
            "id": 2,
            "brewery_type": "micro",
            "city": "Birmingham",
            "name": "Avondale Brewing Co",
            "phone": "2057775456",
            "postal_code": "35222-1932",
            "state": "Alabama",
            "street": "201 41st St S",
            "website_url": "http://www.avondalebrewing.com"
        },
        ...
    ]
```

##### GET `/api/v1/breweries/:id`
> Returns a specific brewery for the given id. Example below:
```
# /api/v1/breweries/1296

{
    "status": 200,
    "message": null,
    "brewery": {
        "id": 1296,
        "brewery_type": "micro",
        "city": "Denver",
        "name": "Chain Reaction Brewing Company",
        "phone": "3039220960",
        "postal_code": "80223-2717",
        "state": "Colorado",
        "street": "902 S Lipan St",
        "website_url": "http://www.chainreactionbrewingco.com"
    }
}
```

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


