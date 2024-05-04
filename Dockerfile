FROM pytorch/pytorch:2.1.0-cuda11.8-cudnn8-runtime

ARG USER="user"
ARG UID="1000"
ARG GID="100"

USER "root"

RUN apt-get update && apt-get install -y gnupg

# tzdata is required below. To avoid hanging, install it first.
RUN DEBIAN_FRONTEND="noninteractive" apt-get install tzdata -y

RUN apt-get update && apt-get -yqq install ssh git vim ctags zsh curl \
            python-opengl ffmpeg xvfb build-essential rar unzip \
            libglib2.0-0 wget libgl1-mesa-glx \
            swig4.0 python3-opencv

# Alias
RUN ln -s /usr/bin/swig4.0 /usr/bin/swig

RUN pip3 install --upgrade pip


# Create user
RUN useradd -l -m -s /bin/zsh -N -u "${UID}" "${USER}"

# Switch to the created user
USER $UID

# Install Oh-My-Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Set a custom theme to distinguish the shell.
# See also https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
RUN sed -i 's/robbyrussell/apple/g' $HOME/.zshrc

RUN conda init zsh
RUN echo "conda activate base" >> "/home/${USER}/.zshrc"

RUN pip3 install jupyter
RUN pip3 install pyvirtualdisplay
RUN pip3 install pygame
# There was a bug in gymnasium==0.28.1 with RescaleAction
# https://github.com/Farama-Foundation/Gymnasium/issues/568
RUN pip3 install gymnasium==0.29.1
RUN pip3 install gymnasium[atari]
RUN pip3 install gymnasium[accept-rom-license]
RUN pip3 install matplotlib
RUN pip3 install tensorboard
RUN pip3 install gin-config==0.4.0
RUN pip3 install opencv-python-headless
RUN pip3 install pybullet
RUN pip3 install stable-baselines3==2.1.0

# Render episode videos
RUN pip3 install moviepy

# https://stackoverflow.com/questions/73929564/entrypoints-object-has-no-attribute-get-digital-ocean
RUN pip3 install importlib-metadata==4.13.0

# Generating command-line interfaces and configuration objects (if using cleanrl)
RUN pip3 install tyro

WORKDIR /workspace/

CMD "ls"
