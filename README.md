# TRIPLA ASSIGNMENT

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
- There's no API standard is specified, let's assume that our API consumer need a compact API that returns enough information for the to understand what's going on

## Database design

<https://dbdiagram.io/d/5e78c3654495b02c3b88a44d>

## API Endpoints

| Endpoints                              | Parameters  | Functionalities                                                                       |
| -------------------------------------- | ----------- | ------------------------------------------------------------------------------------- |
| POST /api/v1/users/:user_id/follow     | followed_id | Create relationship between follower with user id and followed with followed user id  |
| DELETE /api/v1/users/:user_id/unfollow | followed_id | Destroy relationship between follower with user id and followed with followed user id |
