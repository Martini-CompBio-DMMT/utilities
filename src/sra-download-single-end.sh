#!/bin/bash

srr=$1

localfile=${srr}.fastq.gz

echo "Download in local"
# Change ${srr}.sra in remote if need be
# remote="$HOME/sra/user_rep/sra/${srr}.sra"

if [ -f  $localfile ]; then
    echo "${localfile} exist" >/dev/stderr
else
    echo "Downloading ..."
    prefetch -O . --max-size 50G $srr

    echo "Dumping ${srr}" >/dev/stderr
    # fastq-dump  --defline-seq '@$si-$sg'  SRR10343102 --split-3
				     
    fasterq-dump ${srr}/${srr}.sra && \
    gzip *.fastq

    if [ $? == 0 ]; then
        rm -r ${srr}
    fi

fi
