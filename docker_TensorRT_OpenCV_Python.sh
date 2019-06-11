
if  [ "$1" == 'build' ]; then
	echo "[info] Build a docker image from the Dockefile"
	docker build -t aminehy/tensorrt-opencv-python3:v1.0 .
elif [ "$1" == "push" ]; then
	echo "[info] Push the docker image to docker hub"
	docker push aminehy/tensorrt-opencv-python3:v1.0
elif [ "$1" == "run" ]; then
	echo "[info] Run the docker container"
	xhost +
	docker run -it --rm -v $(pwd):/workspace --runtime=nvidia -w /workspace -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY aminehy/tensorrt-opencv-python3:v1.0
fi
