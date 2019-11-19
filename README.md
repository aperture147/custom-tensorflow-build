# Custom Tensorflow Dockerfile

## Description

You can use this Dockerfile to build your Tensorflow on any machine to get a better optimization.

Image produced by the Dockerfile in this repo will not run correctly on AWS, GCP, does not support Apache Ignite, Apache Kafka, NCCL and HDFS. Please modify line 33 in the Dockerfile to fit your need.

```dockerfile
RUN cd tensorflow && \
    echo "/usr/bin/python3\n\nn\n\n\ny\n\n$comp_cap\n\n\n\n\n\n" | ./configure && \
    cat .tf_configure.bazelrc && \
    # Modify the line below
    bazel build --config=opt --config=cuda --config=noaws --config=nogcp --config=nohdfs --config=noignite --config=nokafka --config=nonccl //tensorflow/tools/pip_package:build_pip_package
```

## How to build
* Clone this repository to a directory and move to that.
* Run:
```
docker build . -t <your-image-name> --build-arg comp_cap=<your-gpu-compute-capabilites>
```
* Wait for the building process
