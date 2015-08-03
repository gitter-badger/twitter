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
200
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

We'll be dividing our implementations into polling (REST-based), and streaming (non-REST, probably web sockets).

Twitter REST API: https://dev.twitter.com/rest/public
Twitter streaming API: https://dev.twitter.com/streaming/overview

### Synthetic Twitter Feeds Using Twitter's REST API
We'll start with the REST API as it is probably easier to do.

#### Rate Limiting
Twitter limits the rate at which our client will be able to make requests to its API. Not clear whether we will want to implement anything similar for our own services. Probably not.

Commence distributed systems complications:
```
Lastly, there may be times in which the rate limit values that we return are inconsistent, or cases where no headers are returned at all. Perhaps memcache has been reset, or one memcache was busy so the system spoke to a different instance: the values may be inconsistent now and again. We will make a best effort to maintain consistency, but we will err toward giving an application extra calls if there is an inconsistency.
```
Interesting. This is a problem that will occur in only particular implementations. When might we encounter it in our own sytems? (supposing we don't use memcache)

More good system design:
```
###Caching
Store API responses in your application or on your site if you expect a lot of use. For example, don’t try to call the Twitter API on every page load of your website landing page. Instead, call the API infrequently and load the response into a local cache. When users hit your website load the cached version of the results.
```
This is probably one of the biggest possible wins in optimizing our system design. We'll be careful to profile performance to see what actual payoff we get from different caching strategies.


