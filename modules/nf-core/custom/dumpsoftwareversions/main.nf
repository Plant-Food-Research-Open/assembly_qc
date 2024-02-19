process CUSTOM_DUMPSOFTWAREVERSIONS {
    label 'process_single'

    // Requires `pyyaml` which does not have a dedicated container but is in the MultiQC container
    conda "${moduleDir}/environment.yml"
    container "${ workflow.containerEngine == 'singularity' || workflow.containerEngine == 'apptainer' ?
        'https://depot.galaxyproject.org/singularity/multiqc:1.20--pyhdfd78af_0' :
        'quay.io/biocontainers/multiqc:1.20--pyhdfd78af_0' }"

    input:
    path versions

    output:
    path "software_versions.yml"    , emit: yml
    path "software_versions_mqc.yml", emit: mqc_yml
    path "versions.yml"             , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    template 'dumpsoftwareversions.py'
}
