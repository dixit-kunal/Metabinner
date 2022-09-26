# Metabinner

## Requirements

### Conda

[Conda user guide](https://docs.conda.io/projects/conda/en/latest/user-guide/index.html)

```bash
# install miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod u+x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh # follow the instructions
```

Getting the repository including sub-modules
```bash
git clone https://github.com/dixit-kunal/Metabinner.git
cd Metabinner
```

Create the main `snakemake` environment

```bash
# create venv
conda env create -f envs/requirements.yaml -n "snakemake"
```

## Setup

* Place your preprocessed/trim reads (e.g. `sample_R1.fastq.gz` and `sample_R2.fastq.gz` files) in a `reads` folder
* Place the individual assemblies (e.g. `sample.fasta`) into an `assembly` folder
* Modify the `config/config.yaml` file to change the different paths and eventually the different options
* Modify the `config/sample_list.txt` file to include your samples

### Without Slurm

`snakemake -rp --cores 28 --use-conda`

### With Slurm

* Modify the `config/slurm.yaml` file by checking `partition`, `qos` and `account` that heavily depends on your system
* Modify the `config/sbatch.sh` file by checking `#SBATCH -p`, `#SBATCH --qos=` and `#SBATCH -A` options that heavily depends on your system

`sbatch config/sbatch.sh`


## Folder structure
- Snakefiles: snakemake-based scripts for launching Metabinner, MAG taxonomy and quality analyses and integron coordinate retrieval 
- config: folder containing all config files required for Snakefiles
- workflow: folder containing rules and snakefile
- envs: folder containing all conda environments
- scripts: folder containing supplementary scripts
