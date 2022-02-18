FROM jupyter/base-notebook

ENV HOME=/home/$NB_USER

USER root

RUN set -ex \
  && apt-get update -y \
  && apt-get upgrade -y \
  && apt-get install -y git imagemagick gdal-bin \
  && pip install papermill

USER $NB_USER

ADD https://api.github.com/repos/pymonger/downsample-landsat/git/refs/heads/main version.json

RUN set -ex \
  && cd $HOME \
  && git clone https://github.com/pymonger/downsample-landsat.git \
  && cd downsample-landsat \
  && python -c "import black; black.cache.CACHE_DIR.mkdir(parents=True, exist_ok=True)"

WORKDIR $HOME/hello-world

CMD ["/bin/bash"]
