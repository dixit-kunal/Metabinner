# Assembling reads using METASPADES

rule assembly:
    input:
        expand(os.path.join(RESULTS_DIR, "Assembly/{sample}/scaffolds.fasta"), sample=SAMPLES)
    output:
        touch("status/assembly.done")


rule metaspades:
    input: 
        read1=os.path.join(READS_DIR, "{sample}_R1.fastq.gz"),
        read2=os.path.join(READS_DIR, "{sample}_R2.fastq.gz")
    output:
        os.path.join(RESULTS_DIR, "Assembly/{sample}/scaffolds.fasta")
    log:
        os.path.join(RESULTS_DIR, "logs/Assembly/{sample}.log")
    conda:
        os.path.join(ENV_DIR, "spades.yaml")
    threads:
        config["spades"]["threads"]
    message:
        "Running metaSPADES on {wildcards.sample}"
    shell:
        "(date && metaspades.py -k 21,33,55,77 -t {threads} -1 {input.read1} -2 {input.read2} -o $(dirname {output} && date) &> {log}"
