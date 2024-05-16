# Snakemake workflow for co-assembly of shotgun metagenomic sequencing data
Written for Snakemake verison 8.4.12 for use on the Quest High Performance Computing cluster.  

This is my personal workflow for co-assembling shotgun metagenomic sequencing data. Use at your own risk.  

Snakemake directory structure:  
- config  
    - config.yaml  
    - sample_sheet.csv  
- simple (profile)  
    - config.yaml  
- workflow
    - envs
    - rules
    - scripts
    - Snakefile

Can also include folders for raw_reads and analysis. Results folder should be generated automatically on the first run of the snakemake. 

Important snakemake files:  
- config - turn modules (groups of rules) on and off  
- snakefile - which rules to include, globally import files  
- common.smk - rule file where rule_all lives as well as any global functions   

Pipeline:  
- fastqc - read trimming & qc
- megahit - co-assembly
- metabat - binning
- checkM - bin quality
- gtdbtk - taxonomic classification
