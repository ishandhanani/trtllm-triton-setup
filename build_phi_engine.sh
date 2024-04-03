#!/bin/bash

model_name="microsoft/phi-2"

# Navigate to the phi folder where the convert_checkpoint.py script is located
cd phi

# Convert weights from HF Transformers to TensorRT-LLM checkpoint
# TODO: tp_size is static
python3 convert_checkpoint.py \
	--model_dir "microsoft/phi-2" \
        --dtype float16 \
        --tp_size 1 \
        --output_dir ../phi_fp16_1gpu

# Build TensorRT engines
# These arguemnts allow you to do inflight batching 
# https://github.com/NVIDIA/TensorRT-LLM/issues/1203#issuecomment-1972833436
trtllm-build --checkpoint_dir ../phi_fp16_1gpu \
        --gpt_attention_plugin float16 \
        --remove_input_padding enable \
        --paged_kv_cache enable \
        --gemm_plugin float16 \
        --output_dir /tmp/engine

# Leave phi directory
cd ..

# Run the tokenizer download 
python save_tokenizer.py $model_name /tmp/tokenizer 
