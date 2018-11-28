# Leaders

Our suite of tools for Hack Club Leaders. Built with Rails.

## Getting Started

1. Install Docker.
2. Clone this repo.
3. ```sh
    docker-compose build
    docker-compose run web bundle
    docker-compose run web bundle exec rails db:create db:migrate
    docker-compose up
   ```
4. Open [localhost:3000](http://localhost:3000)

## Import Heroku PG capture

```
pg_restore --verbose --clean --no-acl --no-owner -h db -U postgres -d leaders_development latest.dump
```

MIT License
