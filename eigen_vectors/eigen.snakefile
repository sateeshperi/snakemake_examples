DATASETS = "0 1 2 3 4 5 6 7".split()

rule all:
    """
    Collect the main outputs of the workflow.
    """
    input:
        "output/sort-output.txt",
        "output/rulegraph.png",
        "output/jobgraph.png"

rule create_random:
    input:
    output:
        "data/random-data-{dataset}.npy"
    threads: 4
    script:
        "scripts/create-random.py"

rule find_eigh:
    input:
        "data/random-data-{dataset}.npy"
    output:
        "data/eigh-output-{dataset}.npy"
    threads: 16
    script:
        "scripts/find-eigh.py"

rule sum_eigh:
    input:
        "data/eigh-output-{dataset}.npy"
    output:
        "data/sum-eigh-{dataset}.npy"
    threads: 4
    script:
        "scripts/sum-eigh.py"

rule sort_eigh:
    input:
        expand("data/sum-eigh-{dataset}.npy", dataset=DATASETS)
    output:
        "output/sort-output.txt"
    threads: 8
    script:
        "scripts/sort-eigh.py"
        
rule generate_rulegraph:
    """
    Generate a rulegraph for the workflow.
    """
    output:
        "output/rulegraph.png"
    shell:
        """
        snakemake -s eigen.snakefile --rulegraph | dot -Tpng > {output}
        """        
        
rule generate_jobgraph:
    """
    Generate a rulegraph for the workflow.
    """
    output:
        "output/jobgraph.png"
    shell:
        """
        snakemake -s eigen.snakefile --dag | dot -Tpng > {output}
        """         