# API Endpoints

| Endpoints                              | Parameters                  | Functionalities                                                                       |
| -------------------------------------- | --------------------------- | ------------------------------------------------------------------------------------- |
| POST /api/v1/users/:user_id/follow     | followed_id                 | Create relationship between follower with user id and followed with followed user id  |
| DELETE /api/v1/users/:user_id/unfollow | followed_id                 | Destroy relationship between follower with user id and followed with followed user id |
| POST /api/v1/users/:user_id/operations | operation_type, operated_at | Clock in start or stop operation of a sleep                                           |
| GET /api/v1/users/:user_id/operations  |                             | Return all clocked in times of this user                                              |
