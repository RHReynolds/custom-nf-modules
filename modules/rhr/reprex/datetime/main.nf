process REPREX_DATETIME {
    tag "$meta.id"
    label 'process_single'

    conda "conda-forge::sed=4.7"
    container "ubuntu:20.04"

    input:
    tuple val(meta), path(fastq)

    output:
    tuple val(meta), path("*/counts.csv"), emit: counts
    path "versions.yml"           , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"

    """
    # variable with system date and time
    DATE=`date +%Y-%m-%d_%H-%M-%S`

    # make directory with system date
    mkdir -p \$DATE

    # fastq file name into file in DATE directory
    echo $fastq > \$DATE/counts.csv

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        : \$(echo \$(sed --version 2>&1) | sed 's/^.*sed //; s/Using.*\$//' ))
    END_VERSIONS
    """
}
