# Snakemake workflow for co-assembly of shotgun metagenomic sequencing data

This is my personal workflow for co-assembling shotgun metagenomic sequencing data. Use at your own risk.  

Written for Snakemake verison 8.4.12.  

Minimum file structure needed to get the snakemake started:

config
    - config.yaml
    - sample_sheet.csv
simple (profile)
    - config.yaml
workflow
    - envs
    - rules
    - scripts
    - Snakefile


pipeline
- fastqc - read trimming & qc
- megahit - co-assembly
- metabat - binning
- checkM - bin quality
- gtdbtk - taxonomic classification
