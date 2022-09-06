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
SRC_DIR = srcdir("../../scripts")
ENV_DIR = srcdir("../../envs")
# NOTES_DIR = srcdir("../notes")
# SUBMODULES= srcdir("../../submodules")

##############################
# default executable for snakemake
shell.executable("bash")


##############################
# working directory
workdir:
  config["work_dir"]

##############################
# Relevant directories
ASSEMBLY_DIR = config["assembly_dir"]
DB_DIR = config["db_dir"]
READ_DIR = config["read_dir"]
RESULTS_DIR = config["results_dir"]


##############################
# Steps
STEPS = config["steps"]


##############################
# Input
SAMPLES = [line.strip() for line in open("config/test_list.txt").readlines()]
SAMPLES_2 = SAMPLES
