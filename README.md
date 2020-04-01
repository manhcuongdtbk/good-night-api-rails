# TRIPLA ASSIGNMENT

**Note: This documentation is still in-progress**

## Requirements

We would like you to implement a "good night" application to let users track when they go to bed and when they wake up.
We require some restful APIs to achieve the following:

1. Clock In operation, and return all clocked-in times, ordered by created time.
2. Users can follow and unfollow other users.
3. See the sleep records over the past week for their friends, ordered by the length of their sleep.

```ruby
{
  [
    {
      user_id: 1
      sleeps: [
        {
          id: 1,
          duration: 1 hour,
          started_at: 10h 23/4,
          stopped_at: 11h 23/4
        }
      ]
    },
    {
      user_id: 2
    }
  ]
}

user = User.find(user_id)
following_ids = user.following_ids
sleeps = Sleep.includes(:operation_start, :operation_stop).where(user_id: following_ids).order(:user_id, duration: :desc)

cuong = following_ids.map do |following_id|
  current_sleeps = sleeps.select {|sleep| sleep.user_id == following_id && sleep.duration}
  final_sleeps = current_sleeps.map |sleep| do
    {
      id: sleep.id,
      duration: sleep.duration,
      started_at: sleep.operation_start.operated_at,
      stopped_at: sleep.operation_stop.operated_at
    }
  end
  {user_id: following_id, sleeps: final_sleeps}
end

```

Please implement the model, DB migrations, and JSON API.
You can assume that there are only two fields on the users: "id" and "name”.
You do not need to implement any user registration API.
You can use any gems you like.

## Assumptions

- Due to not having to implement any user registration API, let's assume that we have all the users that we need in the database.
  I'm using seed data to illustrate this assumption about user records. Each user must have an id and a name.
- API consumer is assumed to be trusty. Because of not having authentication and authorization, any user can interact with any other user's data.
- There's no API standard is specified, let's assume that our API consumer need a compact API that returns enough information to understand what's going on

## Database design

<https://dbdiagram.io/d/5e78c3654495b02c3b88a44d>

## API Endpoints

| Endpoints                              | Parameters  | Functionalities                                                                       |
| -------------------------------------- | ----------- | ------------------------------------------------------------------------------------- |
| POST /api/v1/users/:user_id/follow     | followed_id | Create relationship between follower with user id and followed with followed user id  |
| DELETE /api/v1/users/:user_id/unfollow | followed_id | Destroy relationship between follower with user id and followed with followed user id |

## For your curiosity

- I don't add any extra migrations and modify existed migrations because I don't want to have a long list of migrations running each time I do a fully manual test.
On the other hand, I'm the only developer of this project for now. Because of that, there should not any conflicts between my migrations and other developer.
