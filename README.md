# Custom Tensorflow Dockerfile

## Description

You can use this Dockerfile to build your Tensorflow on any machine to get a better optimization.

## How to build
* Clone this repository to a directory and move to that.
* Run:
```
docker build . -t <your-image-name> --build-arg comp_cap=<your-gpu-compute-capabilites>
```
* Wait for the building process
