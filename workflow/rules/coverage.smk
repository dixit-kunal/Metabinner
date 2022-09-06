# To generate BAM files from assembly and reads

rule coverage:
    input:
        expand(os.path.join(RESULTS_DIR,"Bam/{sample}/{sample}.bam"), sample=SAMPLES)
    output:
        touch("status/coverage.done")


rule filter_length:
    input:
        cont=os.path.join(RESULTS_DIR, "Assembly/{sample}/scaffolds.fasta")
    output:
        os.path.join(RESULTS_DIR, "Assembly/{sample}_filter.fasta")
    conda:
        os.path.join(ENV_DIR, "mapping.yaml")
    threads:
        config["filter_length"]["threads"]
    message:
        "Remove contigs less than 1.5kb from {wildcards.sample}"
    shell:
        "(date && seqkit seq -j {threads} -o {output} -m 1499 {input} && date)"

rule mapping_index:
    input:
        rules.filter_length.output
    output:
        os.path.join(RESULTS_DIR,"Assembly/{sample}_filter.fasta.sa")
    log:
        os.path.join(RESULTS_DIR, "logs/mapping/{sample}_mapping.bwa.index.log")
    conda:
        os.path.join(ENV_DIR, "mapping.yaml")
    message:
        "Mapping: BWA index for assembly mapping for {wildcards.sample}"
    shell:
        "(date && bwa index {input} && date) &> {log}"

rule mapping:
    input:
        read1=os.path.join(READS_DIR, "{sample}_R1.fastq.gz"),
        read2=os.path.join(READS_DIR, "{sample}_R2.fastq.gz"),
        cont=rules.filter_length.output,
        idx=rules.mapping_index.output
    output:
        os.path.join(RESULTS_DIR,"Bam/{sample}/{sample}.bam")
    threads:
        config["mapping"]["threads"]
    conda:
        os.path.join(ENV_DIR, "mapping.yaml")
    log:
        out=os.path.join(RESULTS_DIR, "logs/mapping/{sample}.out.log"),
        err=os.path.join(RESULTS_DIR, "logs/mapping/{sample}.err.log")
    message:
        "Running bwa to produce sorted bams"
    shell:
        "(date && bwa mem -t {threads} {input.cont} {input.read1} {input.read2} | samtools sort -@{threads} -o {output} - && " 
        "samtools index {output} && date) 2> {log.err} > {log.out}"
