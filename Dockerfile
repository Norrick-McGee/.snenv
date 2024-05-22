# Use the latest Arch Linux image
FROM debian:latest 

# Set the user and home directory variables
ARG USER=snorks
ARG HOME_DIR=/home/snorks

RUN useradd -m -d ${HOME_DIR} ${USER}
ENV HOME ${HOME_DIR} 
WORKDIR ${HOME_DIR}


# Update the system and install software as root
RUN apt-get update && apt-get install -y vim zsh tmux git

# change $USER's shell
RUN chsh -s /usr/bin/zsh ${USER}

USER ${USER}
RUN git clone https://github.com/Norrick-McGee/.dotfiles.git $HOME/.dotfiles
CMD /usr/bin/zsh
