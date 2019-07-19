# RestWebProxy

A simple rest web proxy implemented with Elixir and Phoenix framework.

## Installation

To setup this application you need to have `docker` and `docker-compose` installed.

* Build containers with `docker-compose build`
* Run containers with `docker-compose up`

And now you can use the application at `localhost:4000`.

## Usage

Available routes:

HTTP method | Route                  | Description
----------- | ---------------------- | -------------------------
POST        | /api/sync/:proxy       | POST :proxy endpoint synchronously
POST        | /api/async/:proxy      | POST :proxy endpoint asynchronously
GET         | /api/sync/:proxy       | GET :proxy endpoint synchronously
GET         | /api/async/:proxy      | GET :proxy endpoint asynchronously

All the endpoints would send recived headers.
Post params would be send accordingly.
Url params would be appended to the configured url.

## GET /api/async/:proxy

##### Request

```
curl -X GET -H "content-type: application/json" -H "test: 123"  'http://localhost:4000/api/async/test?paramq=1&param2=2'
```

##### Response
```
200 OK
{"success":true}
```

##### Proxy Call

```
GET https://en8m2ly5vtjxa.x.pipedream.net/?test=123&param2=2&paramq=1

headers:

host en8m2ly5vtjxa.x.pipedream.net
accept */*
content-type application/json
test 123
user-agent hackney/1.15.1
connection keep-alive
```

## GET /api/sync/:proxy

```
curl -X GET -H "content-type: application/json" -H "test: 123"  'http://localhost:4000/api/sync/test?paramq=1&param2=2'
```

##### Response
```
200 OK
{"success":true}
```

## POST /api/async/:proxy

```
curl -X POST -H "content-type: application/json" -H "test: 123" -d '{"transfer_amount": 100, "destination_account": "d0b0548b-4d09-475f-b6a4-bbb55a21cf7e"}' 'http://localhost:4000/api/async/test?paramq=1&param2=2'
```

##### Response
```
200 OK
{"success":true}
```

##### Proxy Call

```
POST https://en8m2ly5vtjxa.x.pipedream.net/?test=123&param2=2&paramq=1

headers:

host en8m2ly5vtjxa.x.pipedream.net
accept */*
content-type application/x-www-form-urlencoded; charset=utf-8
test 123
user-agent hackney/1.15.1
content-length 94
connection keep-alive

body:

destination_account=d0b0548b-4d09-475f-b6a4-bbb55a21cf7e&param2=2&paramq=1&transfer_amount=100
```

## POST /api/sync/:proxy

```
curl -X POST -H "content-type: application/json" -H "test: 123" -d '{"transfer_amount": 100, "destination_account": "d0b0548b-4d09-475f-b6a4-bbb55a21cf7e"}' 'http://localhost:4000/api/sync/test?paramq=1&param2=2'
```

##### Response
```
200 OK
{"success":true}
```

##### Proxy Call

```
POST https://en8m2ly5vtjxa.x.pipedream.net/?test=123&param2=2&paramq=1

headers:

host en8m2ly5vtjxa.x.pipedream.net
accept */*
content-type application/x-www-form-urlencoded; charset=utf-8
test 123
user-agent hackney/1.15.1
content-length 94
connection keep-alive

body:

destination_account=d0b0548b-4d09-475f-b6a4-bbb55a21cf7e&param2=2&paramq=1&transfer_amount=100
```
