####################################################
####################################################
# Import a base docker image
####################################################
####################################################

FROM nvcr.io/nvidia/tensorrt:19.05-py3

LABEL maintainer "M. Amine Hadj-Youcef  <hadjyoucef.amine@gmail.com>"



####################################################
####################################################
# Install python dependencies 
####################################################
####################################################

Run /opt/tensorrt/python/python_setup.sh




####################################################
####################################################
# install prerequisites
####################################################
####################################################


RUN apt-get update && apt-get install -y --no-install-recommends \
	protobuf-compiler \
	geany \
	libprotoc-dev \
	python3-tk \
	eog \
	gedit \
	build-essential \
	cmake \
	git \
	wget \
	unzip \
	yasm \
	pkg-config \
	libswscale-dev \
	libtbb2 \
	libtbb-dev \
	libjpeg-dev \
	libpng-dev \
	libtiff-dev \
	libavformat-dev \
	libpq-dev \
	libgtk2.0-dev \
	python3-pip \
	libhdf5-dev \
	python3-dev \
	&& rm -rf /var/lib/apt/lists/*

####################################################
####################################################
# Install pip packages
####################################################
####################################################

RUN cd /usr/local/src && \
    wget https://bootstrap.pypa.io/get-pip.py && \
    python2 get-pip.py && \
    pip2 install --upgrade pip && \
    python3 get-pip.py && \
    pip3 install --upgrade pip && \
    rm -f get-pip.py

# RUN python3 -m pip --version
RUN pip3 install --user --upgrade pip

####################################################
####################################################
# Install requirements.txt
####################################################
####################################################

# COPY requirements.txt /tmp/
# RUN pip3 install --requirement /tmp/requirements.txt
# find ./sample -name requirements.txt

#####################################################
####################################################
# Install opencv
####################################################
####################################################

WORKDIR /

ENV OPENCV_VERSION="3.4.6"

RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
	&& unzip ${OPENCV_VERSION}.zip \
	&& mkdir /opencv-${OPENCV_VERSION}/cmake_binary \
	&& cd /opencv-${OPENCV_VERSION}/cmake_binary \
	&& cmake -DBUILD_TIFF=ON \
	-DBUILD_opencv_java=OFF \
	-DWITH_CUDA=OFF \
	-DWITH_OPENGL=ON \
	-DWITH_OPENCL=ON \
	-DWITH_IPP=ON \
	-DWITH_TBB=ON \
	-DWITH_EIGEN=ON \
	-DWITH_V4L=ON \
	-DBUILD_TESTS=OFF \
	-DBUILD_PERF_TESTS=OFF \
	-DCMAKE_BUILD_TYPE=RELEASE \
	-DCMAKE_INSTALL_PREFIX=$(python3.5 -c "import sys; print(sys.prefix)") \
	-DPYTHON_EXECUTABLE=$(which python3.5) \
	-DPYTHON_INCLUDE_DIR=$(python3.5 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
	-DPYTHON_PACKAGES_PATH=$(python3.5 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
	.. \
	&& make install \
	&& rm /${OPENCV_VERSION}.zip \
	&& rm -r /opencv-${OPENCV_VERSION}

RUN  ln -s \
    /usr/lib/python3.5/dist-packages/cv2/python-3.5/cv2.cpython-35m-x86_64-linux-gnu.so \
	/usr/local/lib/python3.5/dist-packages/cv2.so

####################################################
####################################################
# set the working directory
####################################################
####################################################

WORKDIR /workspace



