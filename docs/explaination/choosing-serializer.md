# Choosing Serializer

There is one huge thing to consider in the requirement: **restful APIs**.

## Abstract

In the modern API world, normally when you hear the **API** abbreviation, you could immediately come up with a JSON API
architecture. That's exactly what I tried to build in this assignment, Rails backend API. However, after working with a
huge amount of data, how do I serve them to the user in the JSON format? To answer that question, I found some
interesting ways of doing just that. During those days of finishing the assignment, I had a chance to experiment with
all of them. Let's see what they are and how I found the way that I think is the best for this assignment. I took the
"returning all clocked-in times" to be the problem that needs to be solved for all the ways below.

## Jbuilder

The first way that comes built-in with Rails which every developer can see in the Gemfile after initialize project
is Jbuilder. Like it or not, Jbuilder still goes along with Rails until now (not like the "dead" Coffeescript).

Jbuilder is considered the slowest way amongst others to serialize large amount of JSON data, especially collections and
nester arrays / objects. On the other hand, the _\*.json.jbuilder_ file must stay in the correct position like any other
_\*.html.erb_ file which makes me really confuse at first. Sometimes API providers do not provide the API for consumers
who use their fetched API data to display on the view, so why do I have to put my json file in the views folder?

Having cons doesn't mean Jbuilder having no pros. One easiest to spot pro is that it **just work out of the box**.
No extra gem is needed, no extra configurations (after all, still conventions over configurations, isn't it?). The
syntax of Jbuilder is simple as well, it looks much like the output JSON. The serializing speed on single object is not
much different from others serializers. Code base is still up-to-date and has good backward / forward compatibility.

So how did I serve the JSON output for all clocked-in times of, for example, user with id 1, ordered by created time
using Jbuilder?

I had a RESTful route **/api/v1/users/1/operations**.

That's for sure goes to the _index_ action in the _API::V1::OperationsController_

```ruby
def index
  @user = User.find(params[:user_id])
  @operations = @user.operations.select(:id, :operation_type, :operated_at, :created_at).order(created_at: :desc)
end
```

And... that's it for the controller :o (of course there are some magic things happen on the model and the database, and
the whole Rails framework so we can actually get all the operations we need, but just pass it for now)

Now we get all the operations that satisfy the requirement. The jbuilder part is below:

```ruby
json.data do
  json.user do |json|
    json.extract! @user, :id, :name
  end

  json.operations do |json|
    json.array! @operations
  end
end
```

Testing on Postman shows us the output JSON like:

```json
{
  "data": {
    "user": {
      "id": 1,
      "name": "cuong"
    },
    "operations": [
      {
        "id": 20600,
        "operation_type": "stop",
        "operated_at": "2020-04-05T13:34:20.000+09:00",
        "created_at": "2020-04-04T21:42:38.310+09:00"
      },
      ...
    ]
  }
}
```

It took about **4,25s** on my machine to GET the JSON serialized response for 1 user record and 10.000 operation records
with selected fields. It's horribly slow for one request-response and if this happens on a production server, for sure
in the normal cases, you will loose your customer (or not even have 1 after they use the trial version ;()

Having this nightmare is not comfortable for us, the developer, also our our boss (who pays us every month, oh dear),
and also (another also, huh) our customer (who pays entire company). How do we fix that?

There are 2 solutions which came up in my mind at the very moment.

- Seek for a faster JSON serializer.
- Apply caching methods.

The first solution leads us to the next section of this article and the last leads us to a new article (it's long to
explain and takes time to get all the real performance benchmark results to prove which method should or should not
be used). Let's move on to the next section to see which faster JSON serializer that I found.

You can read more about Jbuilder in the following articles, some are old and maybe not so true nowaday:

- [Official documentation](https://github.com/rails/jbuilder)
- [ActiveModel::Serializers vs Jbuilder](https://kirillplatonov.com/2014/11/04/active_model_serializer_vs_jbuilder/)
- [Google's answer for "jbuilder very slow"](https://www.google.com/search?sxsrf=ALeKk006z8v9NaBGvQvxi1TmH5R1Q3gIGA%3A1586072914839&ei=Uo2JXo3qMuSQr7wPvLiWqAw&q=jbuilder+very+slow&oq=jbuilder+is+ver&gs_lcp=CgZwc3ktYWIQAxgCMgYIABAWEB4yBggAEBYQHjIGCAAQFhAeMgUIABDNAjoECCMQJ0oNCBcSCTEwLTEwNGc5OEoKCBgSBjEwLTVnNlDcK1jjYGDybWgFcAB4AIABdIgBjwmSAQM3LjWYAQCgAQGqAQdnd3Mtd2l6&sclient=psy-ab)

## Active Model Serializer

Back in the day when I was working with my doraemon-like leader (hello Nhat-san, if you can read this somehow), every
other leaders seemed to love Active Model Serializer, also called AMS in the Rails community. I had a chance to work
in a project using this gem, but at that time, I was not interested in JSON and related stuffs (we all have our past,
right?). However, nowaday when my day-to-day tasks frequently include working with JSON, the ecosystem, architectures,
API, microservices,... all the complexing but interesting things, I truly feel regret for my old self not working hard
enough with all JSON things in those days. As a famous actor who I saw on the movie once said, "You can fool me once,
it's not all my fault, but if you can fool me twice, that's exactly my own fault, too naive, too foolish.", me nowaday
is better and have fully experimented on all JSON things that I touched. Thanks to the old day, I know the name of AMS
and it's still popular now in the Rails community.

Despite being popular, in the official documentation, AMS maintainer stated that it's no longer be developing and maybe
just has a minor version upgrade to close all the open issues and removing all deprecated warning. Such a sad story for
a long lived gem with so many love and contributions from the Rails community.

Because of the "dead" state of AMS, I won't give you more details about how I experimented it in this assignment and
how it can't also solve the caching problem in general and for this assignment
([huge warning since 2016](https://github.com/rails-api/active_model_serializers/blob/0-10-stable/docs/general/caching.md))

The thing that I like about this gem, still worth to say is:

- Serializer does not stay in the views folder.
- Support [JSON:API](https://jsonapi.org/) standard format.
- Support lots of customizations for the JSON output.
- Huge community supports until the day of writing this article.
- Used in a lot of productions built with Rails.

You can read more about AMS in the following articles:

- [Official documentation](https://github.com/rails-api/active_model_serializers)

## Fast JSON API

Now for the last serializing solution that I experimented on this assignment. But why it's the last when there are still
others gem public on the internet? Well... first and foremost reason is that I **don't have time** for all of them!
Needless to say other reason, you know what problems we all know.

For the pros, this gem is developed by [Netflix](https://www.netflix.com) (one of the FAANG gang). Netflix is a big
enough company to not use arbitrary, not carefully tested solution on their product as I believe. The developer of this
gem also states on the first
[introduction](https://netflixtechblog.com/fast-json-api-serialization-with-ruby-on-rails-7c06578ad17f)
of this gem on their blog and the README file which we can see on the first time visiting it's Github page that:

- Fast JSONAPI is aimed at providing all the major functionality that Active Model Serializer (AMS) provides,
  along with an emphasis on speed and performance by meeting a benchmark requirement of being 25 times faster than AMS.
- The gem also enforces performance testing as a discipline.
- Comparison graph on everything they say "faster".
- And more...

Those above reason convinced me enough to choose it to be the thing that I can use to solve all the headache problems
while keeping what I like in AMS without what I don't like in Jbuilder. Then how did I implemented it in the assignment?

Using the controller above in the [Jbuilder section](#jbuilder) with a little modification:

To be continued...
