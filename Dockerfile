# All dependencies will be installed using miniconda.
FROM continuumio/miniconda3:latest

# Some metadata.
MAINTAINER Dina Tamás Pál

# Set defaults.
SHELL ["/bin/bash", "-c"]
WORKDIR /home/root/tranX/
ENV PYTHONPATH=/home/root/tranX/
EXPOSE 8081/tcp

# Copy NLTK data.
COPY nltk_data/ /home/root/nltk_data/
ENV NLTK_DATA=/home/root/nltk_data/

# Copy over the conda env files.
# Modifying the source code is the most likely reason
# for the docker build cache to be invalidated, thus
# copying those over is reserved for later.
# Getting the env files here is redundant, but it
# allows the conda env creation to be cached too.
COPY tranX/config/env/ /home/root/tranX/config/env/

# Create conda env.
RUN conda env create -f config/env/py3torch3cuda9.yml

# Copy TranX code to the image.
COPY tranX/ /home/root/tranX/

# Copy pre-runtime environment settings.
COPY bashrc /root/.bashrc

