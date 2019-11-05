# Prebuilt Tensorflow Runtime Docker image for non-AVX machine

## Description
Prebuild Tensorflow Runtime downloaded from Tensorflow Docker repository doesn't support CPU which don't have 
AVX, so people who have CPU older than Sandy Bridge may have to compile the runtime from the source.

This is a prebuild runtime built on Intel® Xeon(R) CPU E5645 and NVIDIA Titan XP. Note that this build is for GPU
and dedicated to those CPU and GPU. Please look at (my github)[https://github.com/aperture147/tensorflow-non-avx-docker] for build template. 

## Tags
`bionic-slim`: GPU build without AWS, GPU, HDFS, Apache Ignite, Kafka and NCCL support

more build template will be made
