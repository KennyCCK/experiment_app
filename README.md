# This is a sample Ruby app

This sample contains simple models, controllers, and DB design with Docker for easy testing.

## Installation / Setup

1. `$ docker-compose build`
2. `$ docker-compose up -d`
3. That's it!

```
Sample dataset are automatically initialized upon boot, see https://github.com/KennyCCK/experiment_app/blob/master/api/db/seeds.rb
```

## Valid basic routes

- `GET localhost:3002/v1/browse`
- `GET localhost:3002/v1/movies`
- `GET localhost:3002/v1/movies/:id`
- `POST localhost:3002/v1/movies/:id/purchase` requires "user_id" in data
- `GET localhost:3002/v1/seasons`
- `GET localhost:3002/v1/seasons/:id`
- `POST localhost:3002/v1/seasons/:id/purchase` requires "user_id" in data
- `GET localhost:3002/v1/library?user_id=1`

```
Example curl when purchasing content:
curl -H 'Content-Type:application/json' -X POST localhost:3002/v1/seasons/14/purchase -d '{"user_id": "1", "quality": "sd"}'
```

## Rspec test

Run `$ docker exec -it <container name> bash` to get into the container bash then enter `bundle exec rspec` to run rspec tests.

## Tips

- You may use docker tools such as `docker logs <container name>` to view logs.
- For live output, you can try `docker attach <container name>` to see container outputs to STDOUT.