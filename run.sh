docker run -it --rm --gpus=device=0 -u "$(id -u):$(id -g)" \
  --name gym-atari-container-$(whoami) \
  -v $(pwd):/workspace \
  -p 8899:8888 \
  gym-atari-$(whoami) bash
