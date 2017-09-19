## This Dockerfile describes the R analysis environment for:
##
## Kamvar, Z.N., Amadarasa, B.S., Jhala, R., McCoy, S., Steadman, S., and 
## Everhart, S.E. (2017). Population structure and phenotypic variation of
## _Sclerotinia sclerotiorum_ from dry bean in the United States
##
## package versions here are locked to those present on 2017-09-19
##
## Note: this Dockerfile was modified from
## https://github.com/NESCent/popgen-docker/blob/193387d3f1e5484ef8a1ddf6d66cfca64ccd40d7/Rpopgen/Dockerfile
## Start with the tidyverse image from Rocker, then add other images on top.

FROM rocker/verse@sha256:b673a3429f7e74c477dc62a320b99bb9faa991ec60a6267a8d89e02fd21f567e
MAINTAINER Zhian Kamvar zkamvar@gmail.com

# Prevent error messages from debconf about non-interactive frontend
ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

## Some of the R packages depend on package gsl, which requires gsl-dev
## to be installed in order to succeed
RUN apt-get update \
    && apt-get install -y libgsl0-dev

## The nloptr package is needed by lme4, and it itself needs to download the
## NLopt code from http://ab-initio.mit.edu/wiki/index.php/NLopt, which is
## unstable. Hence we put this upfront, so that we fail fast on this step,
## which makes it easier to redo.
RUN install2.r --repos https://mran.microsoft.com/snapshot/2017-09-19 \
    nloptr \
&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds

## Bioconductor dependencies of packages we install from CRAN (specifically pegas)
RUN Rscript -e 'source("http://bioconductor.org/biocLite.R"); biocLite("Biostrings");'

# ggforce requires units which required udunits2
RUN apt-get install -y libudunits2-dev

## Install population genetics packages from MRAN
## Note that we are going to be re-installing some of these packages from 
## github, but are installing them here initially to ensure that we have the
## correct dependencies
RUN rm -rf /tmp/*.rds \
&&  install2.r --error --repos https://mran.microsoft.com/snapshot/2017-09-19 \
    igraph \
    viridis \
    poppr \
    vegan \
    readxl \
    assertr \
    ezknitr \
    visNetwork \
    rticles \
    huxtable \
    agricolae \
    ggraph \
    ggforce \
    ggridges \
    ggrepel \
    cowplot \
    bookdown \
&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds

## Install packages from Github
RUN installGithub.r \
    slowkow/ggrepel@fd15d0a7d8afa873f4baced087dd38132f3484c4 \
    rstudio/rticles@4111a3946de40f787b8115d29e6751246cb9c5d2 \
    zkamvar/ggcompoplot@bcf007d1ffd4d39afd9ac347213d2416163f380c \
&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds

