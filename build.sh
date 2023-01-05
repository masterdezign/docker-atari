docker build -f $(pwd)/docker-atari/Dockerfile . \
  --build-arg UID=$(id -u) \
  --build-arg GID=$(id -g) \
  --build-arg USER=$(whoami) \
  -t gym-atari-$(whoami)
