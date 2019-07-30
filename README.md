# Docker-TensorRT-OpenCV-Python3

### The container includes 
- Ubuntu 16.04
- NVIDIA CUDA 10.1 Update 1 including cuBLAS 10.1 Update 1
- NVIDIA cuDNN 7.6.0
- NVIDIA NCCL 2.4.6 (optimized for NVLink™ )
- OpenCV 3.4.6
- Python 3.5
- jupyter-lab

## Run the docker container

	`xhost +`
	`docker run -it --rm -v $(pwd):/workspace --runtime=nvidia -w /workspace -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY -p 8888:8888 aminehy/tensorrt-opencv-python3:v1.1`

## Build a docker image from the Dockefile

	`docker build -t aminehy/tensorrt-opencv-python3:v1.1 .`

## Push the docker image to docker hub

	`docker push aminehy/tensorrt-opencv-python3:v1.1`


