rule metabat_depth:
    input: 
        contigs = "results/megahit/final.contigs.fa",
        sorted_bam = get_all_bams
    output:
        depth = "results/megahit_coverage/depth.txt"
    conda:
        "../envs/metabat.yaml"
    resources:
        mem="10g",
        time="10:00:00",
    threads: 4
    shell:
        """
        jgi_summarize_bam_contig_depths \
        --referenceFasta {input.contigs} \
        --outputDepth {output.depth} \
        --minContigLength 500 \
        {input.sorted_bam}
        """

checkpoint metabat_bin:
    input: 
        contigs = "results/megahit/final.contigs.fa",
        depth = "results/megahit_coverage/depth.txt"
    output:
        directory("results/metabat/")
    params:
        "results/metabat/"
    conda:
        "../envs/metabat.yaml"
    resources:
        mem="20g",
        time="01:00:00"
    threads: 1
    shell:
        """
        metabat2 -t {threads} \
        --inFile {input.contigs} --outFile {params} --abdFile {input.depth} \
        --unbinned --verbose
        """

def get_bins(wildcards):
    checkpoint_output = checkpoints.metabat_bin.get(**wildcards).output[0]
    bin = glob_wildcards(os.path.join(checkpoint_output, "{bin}.fa")).bin
    return expand(f"{checkpoint_output}/{{bin}}.fa", bin=bin)

rule checkm_metabat:
    input:
        get_bins
    output:
        "results/metabat_checkm/checkm_output.txt"
    params: 
        metabat_dir = "results/metabat/",
        checkm_dir = "results/metabat_checkm/"
    threads: 6
    resources:
        mem="50G",
        time="03:00:00"
    shell:
        """
        module load checkm/1.0.7
        checkm lineage_wf \
        --threads {threads} \
        --extension 'fa' \
        --file {output} \
        --tab_table \
        {params.metabat_dir} {params.checkm_dir}
        """