# Atari Games for Deep Reinforcement Learning

The repository helps to quickly prepare an environment for deep
reinforcement learning, specifically Atari games Gym environments.

The project makes use of Docker (check the
[tutorial](https://www.docker.com/101-tutorial/) if unfamiliar). The
`Dockerfile` itself is based on the Pytorch Docker image.


## How to use

    git clone https://github.com/masterdezign/docker-atari
    docker-atari/build.sh
    docker-atari/run.sh

Within the Docker container, your current directory ./ is available from /workspace.

Test e.g. running [cleanrl](https://github.com/vwxyzjn/cleanrl) scripts.

    python cleanrl/ppo_atari.py \
       --seed 1 \
       --env-id BreakoutNoFrameskip-v4 \
       --total-timesteps 10000000

