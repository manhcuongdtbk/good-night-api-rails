# GOOD NIGHT API RAILS

**Note: This documentation is still in-progress**

## Requirements

We would like you to implement a "good night" application to let users track when they go to bed and when they wake up.
We require some restful APIs to achieve the following:

1. Clock In operation, and return all clocked-in times, ordered by created time.
2. Users can follow and unfollow other users.
3. See the sleep records over the past week for their friends, ordered by the length of their sleep.

Please implement the model, DB migrations, and JSON API.
You can assume that there are only two fields on the users: "id" and "name”.
You do not need to implement any user registration API.
You can use any gems you like.

## Assumptions

- Due to not having to implement any user registration API, let's assume that we have all the users that we need in the database.
  I'm using seed data to illustrate this assumption about user records. Each user must have an id and a name.
- API consumer is assumed to be trusty. Because of not having authentication and authorization, any user can interact with any other user's data.
- There's no API standard is specified, let's assume that our API consumer need a compact API that returns enough information to understand what's going on

## Development

### Docker

To be continued...

### Mac OS

1. Create your own database config file

   `cp config/database.yml.example config/database.yml`

2. Install redis

   `brew install redis`

3. Install gems

   `bundle install`

4. Seed data

   `rails db:drop db:create db:migrate db:seed`

5. Start Rails server on localhost:3000

   `rails s`

6. Start sidekiq

   `bundle exec sidekiq`

7. (Optional) If you want to read the explainations and documentations

   Install javascript dependencies

   ```console
   brew install node
   brew install yarn
   yarn install
   ```

   Start docs server on localhost:8080

   `yarn docs:dev`

## Production

To be continued...
