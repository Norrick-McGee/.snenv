# Use the latest Arch Linux image
FROM archlinux:multilib-devel-20240101.0.204074

# Set the user and home directory variables
ARG USER=snorks
ARG HOME_DIR=/home/snorks

RUN useradd -m -d ${HOME_DIR} ${USER}
ENV HOME ${HOME_DIR} 
WORKDIR ${HOME_DIR}


# Update the system and install software as root
RUN pacman -Syu --noconfirm \
             sudo \
	     vi \
	     vim \
	     zsh \
	     cmake \
	     git \
	     tmux
# change $USER's shell
RUN chsh -s /usr/bin/zsh ${USER}

# Install softare as $USER
USER ${USER}
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN /bin/bash -c "source $HOME/.cargo/env \
		    && cargo install exa bat starship bob-nvim \
		    && bob install 0.9.5"

RUN git clone https://github.com/Norrick-McGee/.dotfiles.git $HOME/.dotfiles

CMD /usr/sbin/zsh
