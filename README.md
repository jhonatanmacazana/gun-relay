# gun-relay

Simple files to run a peer-relay of Gun.

## Development

```bash
# Install dependencies
pnpm install

# Start server
pnpm start
```

This will start the relay on `http://localhost:8000/gun`

## Docker

### Using the image from Dockerhub

```bash
# Run image on background (remove -d to not run on background)
docker run -p 8000:8000 -p 8765:8765 -d jmacazana/gun-relay
```

### Building from scratch

```bash
# Build image
docker build . -t gun-relay

# Run image on background (remove -d to not run on background)
docker run -p 8000:8000 -p 8765:8765 -d gun-relay
```
