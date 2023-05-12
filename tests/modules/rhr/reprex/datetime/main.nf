#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { REPREX_DATETIME } from '../../../../../modules/rhr/reprex/datetime/main.nf'

workflow test_reprex_datetime {
    
    input = [ 
        [ id:'test', single_end:true ], // meta map
        file(params.test_data['homo_sapiens']['illumina']['test_1_fastq_gz'], checkIfExists: true)
    ]

    REPREX_DATETIME ( input )
}
