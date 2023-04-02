FROM --platform=${BUILDPLATFORM} docker.io/library/ubuntu:22.04 AS base

ARG USER=mpiuser
ENV USER=${USER}

# install dependencies
RUN apt-get update -y && \
    apt-get install -y \
        build-essential \
        cmake \
        curl \
        g++ \
        libmpich-dev \
        libomp-dev \
        libboost-all-dev \
        mpich \
        ncurses-bin \
        nfs-common \
        nfs-kernel-server \
        openssh-server \
        python2 \
        sudo \
        && \
    apt-get clean

# create user and ssh folder
RUN useradd ${USER} && \
    mkdir -p /home/${USER}/.ssh && \
    chown -R ${USER}:${USER} /home/${USER}/.ssh && \
    chmod 700 /home/${USER}/.ssh

# generate ssh key
RUN ssh-keygen -t rsa -b 4096 -f /home/${USER}/.ssh/id_rsa -N '' && \
    chown -R ${USER}:${USER} /home/${USER}/.ssh && \
    cat /home/${USER}/.ssh/id_rsa.pub >> /home/${USER}/.ssh/authorized_keys && \
    chmod 600 /home/${USER}/.ssh/id_rsa && \
    chmod 644 /home/${USER}/.ssh/id_rsa.pub && \
    chmod 644 /home/${USER}/.ssh/authorized_keys && \
    echo 'Host *' >> /home/${USER}/.ssh/config && \
    echo '    StrictHostKeyChecking no' >> /home/${USER}/.ssh/config && \
    echo '    UserKnownHostsFile=/dev/null' >> /home/${USER}/.ssh/config

# install docker-systemctl-replacement
RUN curl -fsSL https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl.py > /usr/bin/systemctl
RUN chmod +x /usr/bin/systemctl
ENV PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin"

# start services
RUN systemctl enable ssh && \
    systemctl enable nfs-kernel-server

# allow password authentication
RUN sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

# allow passwordless sudo
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USER}

# prepare shared folder
RUN mkdir -p /shared && \
    chown -R ${USER}:${USER} /shared

# copy entrypoint script
COPY --chown=${USER}:${USER} ./scripts/entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

# copy utils script
COPY --chown=${USER}:${USER} ./scripts/utils.sh /etc/utils.sh

# set user and workdir for the rest of the dockerfile
USER ${USER}
WORKDIR /home/${USER}

# set entrypoint
ENTRYPOINT [ "/bin/bash", "/bin/entrypoint.sh" ]
