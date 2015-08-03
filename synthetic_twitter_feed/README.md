The goal here is to create a client program to learn the current Twitter API. 

We'll build a service that, given a collection of Twitter accounts, will generate the stream of tweets formed by merging the output streams of all the accounts. 

This will, for example, allow us to view any individual account's input stream as they themselves see it.

We will be picking some subset of Twitter's API to form the core of the common API that will be shared by all our implementations. 

Some usage: 
```
Request:
GET http://host:port/synthetic_feed
{
  "time_interval": {"start": "2pm August 8th, 2015", "end": "..."}, # probably have some sensible defaults for time_interval field
  "accounts": ["@a16z", "@foo", "@bar"]
}

Response:
200 OK
[
  { "source": "a16z",
    "text": "here's a tweet",
    "time_created": "4pm, August 10, 2015"
  },
  { "source": "foo",
    "text": "tweet tweet",
    "time_created": "5pm, August 11, 2015"
  },
]
```
