ARG PYTHON_IMAGE=python:3.10.6-bullseye
FROM ${PYTHON_IMAGE}

ARG UID=1000
ARG GID=1000
ARG A1111_BUILD_ARGS="--skip-torch-cuda-test --no-download-sd-model --skip-version-check --exit"

ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PYTHONUNBUFFERED=1
ENV HOME=/home/sd
ENV install_dir=/opt
ENV clone_dir=stable-diffusion-webui
ENV venv_dir=venv
ENV python_cmd=python3.10
ENV PATH=/opt/stable-diffusion-webui/venv/bin:${PATH}

RUN apt-get update && apt-get install -y --no-install-recommends \
    bc \
    build-essential \
    ca-certificates \
    git \
    libgl1 \
    libglib2.0-0 \
    libgoogle-perftools4 \
    pciutils \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid "${GID}" sd \
    && useradd --uid "${UID}" --gid "${GID}" --create-home --shell /bin/bash sd \
    && mkdir -p /opt/stable-diffusion-webui \
    && chown -R sd:sd /opt /home/sd

COPY --chown=sd:sd stable-diffusion-webui/ /opt/stable-diffusion-webui/

USER sd
WORKDIR /opt/stable-diffusion-webui

RUN mkdir -p tmp
RUN COMMANDLINE_ARGS="${A1111_BUILD_ARGS}" ./webui.sh

EXPOSE 7860

CMD ["bash", "-lc", "./webui.sh"]
