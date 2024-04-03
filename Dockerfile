# Use the NVIDIA CUDA image as the base
FROM nvcr.io/nvidia/tensorrt:24.03-py3 

# Install TensorRT-LLM release
RUN pip3 install --no-cache-dir tensorrt_llm -U --extra-index-url https://pypi.nvidia.com

# Clone the TensorRT-LLM repository
RUN git clone -b rel https://github.com/NVIDIA/TensorRT-LLM.git trtllm

# Set working directory to examples folder
WORKDIR trtllm/examples

# Copy engine build script into container
COPY build_phi_engine.sh .
COPY save_tokenizer.py .

# Make it executable
RUN chmod +x build_phi_engine.sh
RUN chmod +x save_tokenizer.py

CMD ["./build_phi_engine.sh"]
