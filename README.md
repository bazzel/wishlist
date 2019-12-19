# Wishlist

[![Build Status](https://travis-ci.org/bazzel/wishlist.svg?branch=master)](https://travis-ci.org/bazzel/wishlist)

## Prerequisites
- Install [all requirements](https://gorails.com/setup/osx/10.15-catalina) on your machine

## Installation

```
$ git clone <repository-url>
$ cd wishlist
$ rbenv install `cat .ruby-version` # assuming you use rbenv.
$ bundle install
$ yarn install
$ bin/rails db:setup
```

## Running / Development

- `bin/rails s`
- `bin/webpack-dev-server`
- Visit your app at [http://localhost:3000](http://localhost:3000).

## Running tests

    bin/rails ci
    
Or individually:

    bin/rails rubocop # or `rubocop`
    bin/rails rspec # or `bin/spec`
    bin/rails cucumber # or `bin/cucumber`

## Deployment

The application is hosted by [Heroku](https://quiet-eyrie-13648.herokuapp.com/). Instruction about the deployment process can be found [here](https://devcenter.heroku.com/articles/getting-started-with-rails5).