.PHONY: pull-images phi-engine phi-server

pull-images:
	sudo docker pull ishandhanani/tensorrtllm:tensorrt-24.03-py3_tensorrtllm-0.8.0_phi2
	sudo docker pull nvcr.io/nvidia/tritonserver:24.03-trtllm-python-py3

phi-engine:
	sudo docker run -it --net host --shm-size=2g --ulimit memlock=-1 --ulimit stack=67108864 --gpus all -v ~/model_workspace/brev_model_repository/tensorrt_llm/1:/tmp/engine -v $(pwd)/model_workspace/tokenizer_dir:/tmp/tokenizer ishandhanani/tensorrtllm:tensorrt-24.03-py3_tensorrtllm-0.8.0_phi2

phi-server:
	sudo docker run --rm -it --net host --shm-size=2g --ulimit memlock=-1 --ulimit stack=67108864 --gpus all -v ~/model_workspace:/tensorrtllm_backend/model_repo nvcr.io/nvidia/tritonserver:24.03-trtllm-python-py3 tritonserver --strict-model-config false --model-repository /tensorrtllm_backend/model_repo/brev_model_repository --http-port 8005 --log-verbose=1
