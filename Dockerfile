FROM pytorch/pytorch:1.12.0-cuda11.3-cudnn8-runtime
# FROM pytorch/pytorch:1.9.1-cuda11.1-cudnn8-runtime

ARG UID="1000"
ARG USER="user"
ARG GID="1000"

USER "root"

RUN apt-get update
# tzdata is required below. To avoid hanging, install it first.
RUN DEBIAN_FRONTEND="noninteractive" apt-get install tzdata -y
RUN apt-get install git wget libgl1-mesa-glx -y
RUN apt-get install rar unzip -y
RUN apt-get -yqq install vim ctags zsh curl
RUN apt-get -yqq install python-opengl ffmpeg xvfb

# For Open CV
RUN apt-get install -y libglib2.0-0

# libx264 (to visualize videos)
RUN apt-get -yqq install libavcodec-extra libx264-dev

RUN mkdir /roms
COPY docker-atari/Roms.rar /roms/

RUN rar x /roms/Roms.rar /roms/
RUN unzip /roms/ROMS.zip -d /roms

RUN useradd -l -m -s /bin/zsh -N -u "${UID}" "${USER}"

USER "${UID}"

# Install ROMs
RUN pip install atari_py ale-py
RUN python -m atari_py.import_roms /roms
RUN $HOME/.local/bin/ale-import-roms /roms

# Install OpenAI Gym, tensorboard
RUN pip install gym[box2d]==0.21 tensorboard

# Instal OpenCV (Environment/atari.py dependency)
RUN pip install opencv-python

RUN pip install stable-baselines3[extra]
RUN pip install huggingface_sb3
RUN pip install huggingface_hub
RUN pip install jupyter
RUN pip install pyvirtualdisplay

WORKDIR "/workspace"
