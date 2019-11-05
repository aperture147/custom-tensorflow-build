FROM nvidia/cuda:10.1-cudnn7-devel as build-env

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

RUN cd tensorflow && \
    echo "/usr/bin/python3\n\nn\n\n\ny\n\n6.1\n\n\n\n\n\n" | ./configure && \
    cat .tf_configure.bazelrc && \
    bazel build --config=opt --config=cuda --config=noaws --config=nogcp --config=nohdfs --config=noignite --config=nokafka --config=nonccl //tensorflow/tools/pip_package:build_pip_package

RUN cd tensorflow && \
    ./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg && \
    pip3 install /tmp/tensorflow_pkg/tensorflow-1.15.0-cp36-cp36m-linux_x86_64.whl



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

COPY --from=build-env /tmp/tensorflow_pkg/tensorflow-1.15.0-cp36-cp36m-linux_x86_64.whl /tmp/tensorflow_pkg/tensorflow-1.15.0-cp36-cp36m-linux_x86_64.whl 

RUN pip3 install /tmp/tensorflow_pkg/tensorflow-1.15.0-cp36-cp36m-linux_x86_64.whl
