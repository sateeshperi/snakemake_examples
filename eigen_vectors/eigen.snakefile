DATASETS = "0 1 2 3 4 5 6 7 8".split()

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
    group: "group1"
    threads: 4
    script:
        "scripts/create-random.py"

rule find_eigh:
    input:
        "data/random-data-{dataset}.npy"
    output:
        "data/eigh-output-{dataset}.npy"
    group: "group2"
    threads: 16
    script:
        "scripts/find-eigh.py"

rule sum_eigh:
    input:
        "data/eigh-output-{dataset}.npy"
    output:
        "data/sum-eigh-{dataset}.npy"
    group: "group3"
    threads: 4
    script:
        "scripts/sum-eigh.py"

rule sort_eigh:
    input:
        expand("data/sum-eigh-{dataset}.npy", dataset=DATASETS)
    output:
        "output/sort-output.txt"
    group: "group4"
    threads: 8
    script:
        "scripts/sort-eigh.py"
        
rule generate_rulegraph:
    """
    Generate a rulegraph for the workflow.
    """
    group: "group4"
    output:
        "output/rulegraph.png"
    shell:
        """
        snakemake -s eigen.snakefile2 --rulegraph | dot -Tpng > {output}
        """        
        
rule generate_jobgraph:
    """
    Generate a rulegraph for the workflow.
    """
    group: "group4"
    output:
        "output/jobgraph.png"
    shell:
        """
        snakemake -s eigen.snakefile2 --dag | dot -Tpng > {output}
        """
