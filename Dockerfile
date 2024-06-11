FROM debian:latest 

ARG USER=snenv
ARG HOME_DIR=/home/${USER}

RUN useradd -m -d ${HOME_DIR} ${USER}
ENV HOME ${HOME_DIR} 
WORKDIR ${HOME_DIR}

RUN apt-get update \
    && apt-get install -y \
      curl \ 
      sudo \
      cmake \ 
      vim \
      zsh \
      tmux \
      git \
      zsh-syntax-highlighting \
      zsh-autosuggestions \
      fzf \
      neovim \
      man \ 
      most

# change $USER's shell
RUN chsh -s /usr/bin/zsh ${USER}

USER ${USER}
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN /bin/bash -c "source $HOME/.cargo/env \
		    && cargo install exa bat starship bob-nvim \
		    && bob install 0.9.5"

RUN git clone https://github.com/Norrick-McGee/.dotfiles.git $HOME/.dotfiles
RUN ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

ENV PAGER=most
USER root
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers


USER ${USER}
CMD /usr/bin/zsh
