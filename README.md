# Docker, Flask and React

The React client is served at [localhost:3000](http://localhost:3000), the Flask application at [localhost:5000](http://localhost:5000).

## Development

```sh
sudo docker-compose -f docker.development.yml up
```

## Production

```sh
sudo docker-compose -f docker.production.yml build
```
