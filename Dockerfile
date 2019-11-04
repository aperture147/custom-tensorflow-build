FROM nvidia/cuda:10.1-cudnn7-devel

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
		curl \
                python-dev python-pip \
		python3-dev python3-pip \
		pkg-config \
		zip unzip \
		g++ \
		zlib1g-dev \
		git \
		python3-setuptools python-setuptools \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /build 

COPY ./requirements.txt ./requirements.txt

RUN pip3 install wheel && pip3 install -r requirements.txt

RUN curl -L https://github.com/bazelbuild/bazel/releases/download/0.26.1/bazel-0.26.1-installer-linux-x86_64.sh \
         -o bazel.sh && \
    chmod +x bazel.sh && ./bazel.sh

COPY ./tensorflow ./tensorflow

# RUN cd tensorflow && \
#     bazel build --config=opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
