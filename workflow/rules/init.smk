##############################
# MODULES
import os, re
import sys
import glob
import pandas as pd
from Bio import SeqIO

# ##############################
# # Parameters
# CORES=int(os.environ.get("CORES", 4))


##############################
# Paths
SRC_DIR = srcdir("../scripts")
ENV_DIR = srcdir("../envs")
# NOTES_DIR = srcdir("../notes")
# SUBMODULES= srcdir("../../submodules")

##############################
# default executable for snakemake
shell.executable("bash")


##############################
# working directory
workdir:
  config["data_dir"]

##############################
# Relevant directories
DATA_DIR = config["data_dir"]
# DB_DIR = config["db_dir"]
# FASTQ_DIR = config["fastq_dir"]
RESULTS_DIR = config["results_dir"]


##############################
# Steps
STEPS = config["steps"]


##############################
# Input
SAMPLES = [line.strip() for line in open("config/mice_list").readlines()]
