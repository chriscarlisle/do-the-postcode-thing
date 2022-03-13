# Do the thing!

## Demo App

It's not running permanently. Please contact me to 'turn it on'

Demo app available on: https://do-the-postcode-thing.herokuapp.com/

Admin panel available at https://do-the-postcode-thing.herokuapp.com/admin

Username: admin

Password: password

## Local Installation

Clone the repository:

```
git clone git@github.com:chriscarlisle/do-the-postcode-thing.git
```

Install dependencies:
```
cd do-the-postcode-thing
bundle install
```

Setup the database:
```
bin/rake db:migrate RAILS_ENV=development
bin/rake db:migrate RAILS_ENV=test
```

Start the dev server:
```
bin/dev
```

### Running Tests

```
bin/rails test:all
```

## What got done

This meets the requirements of a usable application for checking postcodes against a list of specifically serviced postcodes, or checking the LSOA of a postcode against a list of serviced LSOAs.

The app can be configured by the user to add or remove postcodes and LSOAs using an authenticated admin panel.

LSOA lookups are powered using the postcodes.io api, with a graceful fallback if the service isn't available.

## What could be improved upon

The authentication is hard-coded basic auth, this would ideally be swapped out for a more robust authentication system including all the user management tooling that would come with that.

The application provides unlimited unauthenticated access to create requests to postcodes.io via our servers. Rate limiting would be something I would consider, however postcodes.io is free and there is a graceful fallback should they implement rate limiting on their end.

There is no reporting, monitoring or statistics gathering mechanism. Logging searched postcodes would provide useful data when making expansion decisions.

The admin panel is 'functional', but not particularly slick. I'd prefer to have a single page for managing both the postcodes and the lsoas from.

There is plenty of opportunity for further refactoring. There is quite a lot of duplication in the tests specifically.

## Standing on the shoulders of giants

Although this was a technical test, I chose to use off-the-shelf packages to achieve the solution. This is likely the approach that would have been taken in a real-world situation too:

* [threedaymonk/uk_postcode](https://github.com/threedaymonk/uk_postcode) was used for postcode parsing and validation.
* [jamesruston/postcodes_io](https://github.com/jamesruston/postcodes_io) was used for interacting with the postcodes.io api. This was recommended from the postcodes.io documenation.
* [superadministration/super](https://github.com/superadministration/super) was used for the admin panel.
