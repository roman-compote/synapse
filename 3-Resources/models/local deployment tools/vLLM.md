---
tags:
  - local-deployment
  - high-performance
  - production
  - inference-engine
---

# vLLM

High-performance inference engine for large language models optimized for throughput and concurrent requests. Uses advanced PagedAttention technology for efficient memory management.

## Key Features
- **High Throughput**: Up to 24x faster than standard transformers
- **PagedAttention**: Revolutionary memory management technique
- **Concurrent Requests**: Efficient handling of multiple simultaneous requests
- **OpenAI-Compatible API**: Drop-in replacement for OpenAI API
- **Production Ready**: Designed for enterprise deployment
- **GPU Optimized**: Maximum utilization of GPU resources

## Installation

### Docker (Recommended)
```bash
# CPU version
docker run --rm -it \
  -p 8000:8000 \
  vllm/vllm-openai:latest \
  --model microsoft/DialoGPT-medium

# GPU version (NVIDIA)
docker run --gpus all --rm -it \
  -p 8000:8000 \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  vllm/vllm-openai:latest \
  --model microsoft/DialoGPT-medium

# With specific model
docker run --gpus all --rm -it \
  -p 8000:8000 \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  vllm/vllm-openai:latest \
  --model meta-llama/Llama-2-7b-chat-hf \
  --trust-remote-code
```

### Python Installation
```bash
# Install vLLM
pip install vllm

# For ROCm (AMD GPUs)
pip install vllm[rocm]

# Development version
pip install git+https://github.com/vllm-project/vllm.git
```

### From Source
```bash
# Clone repository
git clone https://github.com/vllm-project/vllm.git
cd vllm

# Install dependencies
pip install -r requirements.txt

# Build and install
pip install -e .
```

## Basic Usage

### Command Line Server
```bash
# Start OpenAI-compatible server
vllm serve microsoft/DialoGPT-medium \
  --host 0.0.0.0 \
  --port 8000

# With GPU optimization
vllm serve meta-llama/Llama-2-7b-chat-hf \
  --host 0.0.0.0 \
  --port 8000 \
  --tensor-parallel-size 2 \
  --gpu-memory-utilization 0.9

# Advanced configuration
vllm serve meta-llama/Llama-2-13b-chat-hf \
  --host 0.0.0.0 \
  --port 8000 \
  --max-model-len 4096 \
  --swap-space 4 \
  --disable-log-requests
```

### Python API
```python
from vllm import LLM, SamplingParams

# Initialize model
llm = LLM(
    model="microsoft/DialoGPT-medium",
    tensor_parallel_size=1,
    gpu_memory_utilization=0.8
)

# Set sampling parameters
sampling_params = SamplingParams(
    temperature=0.8,
    top_p=0.95,
    max_tokens=100
)

# Generate responses
prompts = [
    "Hello, my name is",
    "The capital of France is",
    "The future of AI is"
]

outputs = llm.generate(prompts, sampling_params)

for output in outputs:
    prompt = output.prompt
    generated_text = output.outputs[0].text
    print(f"Prompt: {prompt!r}, Generated text: {generated_text!r}")
```

## API Usage

### OpenAI-Compatible API
```python
from openai import OpenAI

# Initialize client
client = OpenAI(
    base_url="http://localhost:8000/v1",
    api_key="dummy"  # vLLM doesn't require API key
)

# Chat completion
def chat_with_vllm(message, model="microsoft/DialoGPT-medium"):
    response = client.chat.completions.create(
        model=model,
        messages=[
            {"role": "user", "content": message}
        ],
        temperature=0.7,
        max_tokens=150
    )

    return response.choices[0].message.content

# Usage
response = chat_with_vllm("Explain machine learning")
print(response)
```

### Batch Processing
```python
# Efficient batch processing
def batch_generate(prompts, model="microsoft/DialoGPT-medium"):
    responses = client.completions.create(
        model=model,
        prompt=prompts,
        temperature=0.7,
        max_tokens=100,
        n=1
    )

    return [choice.text for choice in responses.choices]

# Example
prompts = [
    "What is Python?",
    "Explain quantum computing",
    "Describe machine learning",
    "What is blockchain?"
]

results = batch_generate(prompts)
for i, result in enumerate(results):
    print(f"Prompt {i+1}: {result}")
```

### Streaming Responses
```python
def stream_chat(message):
    stream = client.chat.completions.create(
        model="microsoft/DialoGPT-medium",
        messages=[{"role": "user", "content": message}],
        stream=True,
        temperature=0.7
    )

    for chunk in stream:
        if chunk.choices[0].delta.content is not None:
            print(chunk.choices[0].delta.content, end="")

# Usage
stream_chat("Write a story about AI")
```

## Advanced Configuration

### Multi-GPU Setup
```python
# Tensor parallel across multiple GPUs
llm = LLM(
    model="meta-llama/Llama-2-13b-chat-hf",
    tensor_parallel_size=4,  # Use 4 GPUs
    gpu_memory_utilization=0.9,
    max_model_len=4096
)
```

### Memory Optimization
```bash
# Command line options for memory optimization
vllm serve meta-llama/Llama-2-7b-chat-hf \
  --gpu-memory-utilization 0.95 \
  --swap-space 8 \
  --max-model-len 4096 \
  --block-size 16 \
  --max-num-seqs 64
```

### Custom Sampling Parameters
```python
# Advanced sampling configuration
sampling_params = SamplingParams(
    n=1,                    # Number of output sequences
    best_of=1,             # Number of sequences to generate internally
    presence_penalty=0.0,   # Penalize new tokens based on presence
    frequency_penalty=0.0,  # Penalize based on frequency
    repetition_penalty=1.0, # Penalize repetitions
    temperature=0.8,        # Randomness
    top_p=0.95,            # Nucleus sampling
    top_k=50,              # Top-k sampling
    min_p=0.0,             # Minimum probability threshold
    use_beam_search=False,  # Use beam search
    length_penalty=1.0,     # Length penalty for beam search
    early_stopping=False,   # Stop early in beam search
    stop=["\n"],           # Stop sequences
    stop_token_ids=[],     # Stop token IDs
    include_stop_str_in_output=False,
    ignore_eos=False,
    max_tokens=100,
    min_tokens=0,
    skip_special_tokens=True,
    spaces_between_special_tokens=True
)
```

## Production Deployment

### Docker Compose
```yaml
version: '3.8'
services:
  vllm:
    image: vllm/vllm-openai:latest
    ports:
      - "8000:8000"
    environment:
      - CUDA_VISIBLE_DEVICES=0,1,2,3
    volumes:
      - ~/.cache/huggingface:/root/.cache/huggingface
      - ./models:/models
    command: >
      --model meta-llama/Llama-2-7b-chat-hf
      --host 0.0.0.0
      --port 8000
      --tensor-parallel-size 4
      --gpu-memory-utilization 0.9
      --max-model-len 4096
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]

  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    depends_on:
      - vllm
```

### Kubernetes Deployment
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: vllm-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: vllm
  template:
    metadata:
      labels:
        app: vllm
    spec:
      containers:
      - name: vllm
        image: vllm/vllm-openai:latest
        ports:
        - containerPort: 8000
        command: ["vllm", "serve"]
        args:
          - "meta-llama/Llama-2-7b-chat-hf"
          - "--host"
          - "0.0.0.0"
          - "--port"
          - "8000"
          - "--tensor-parallel-size"
          - "2"
        resources:
          limits:
            nvidia.com/gpu: 2
          requests:
            nvidia.com/gpu: 2
        volumeMounts:
        - name: model-cache
          mountPath: /root/.cache/huggingface
      volumes:
      - name: model-cache
        persistentVolumeClaim:
          claimName: model-cache-pvc
---
apiVersion: v1
kind: Service
metadata:
  name: vllm-service
spec:
  selector:
    app: vllm
  ports:
    - protocol: TCP
      port: 8000
      targetPort: 8000
  type: LoadBalancer
```

### Load Balancing
```python
# Multiple vLLM instances with load balancing
import random
from openai import OpenAI

class vLLMLoadBalancer:
    def __init__(self, endpoints):
        self.endpoints = endpoints
        self.clients = [
            OpenAI(base_url=endpoint, api_key="dummy")
            for endpoint in endpoints
        ]

    def get_client(self):
        return random.choice(self.clients)

    def chat(self, message, model="microsoft/DialoGPT-medium"):
        client = self.get_client()
        response = client.chat.completions.create(
            model=model,
            messages=[{"role": "user", "content": message}],
            temperature=0.7
        )
        return response.choices[0].message.content

# Usage
balancer = vLLMLoadBalancer([
    "http://vllm-1:8000/v1",
    "http://vllm-2:8000/v1",
    "http://vllm-3:8000/v1"
])

response = balancer.chat("What is artificial intelligence?")
print(response)
```

## Performance Monitoring

### Metrics Collection
```python
import requests
import time

def get_vllm_metrics(base_url="http://localhost:8000"):
    try:
        # Get model info
        models = requests.get(f"{base_url}/v1/models").json()

        # Check health
        health = requests.get(f"{base_url}/health").json()

        # Performance metrics (if available)
        metrics = {
            "models_loaded": len(models.get("data", [])),
            "status": health.get("status", "unknown"),
            "timestamp": time.time()
        }

        return metrics
    except Exception as e:
        return {"error": str(e)}

# Monitor performance
metrics = get_vllm_metrics()
print(f"vLLM Metrics: {metrics}")
```

### Benchmarking
```python
import time
import asyncio
import aiohttp

async def benchmark_vllm(concurrent_requests=10, requests_per_client=5):
    base_url = "http://localhost:8000/v1/chat/completions"

    async def single_request(session, request_id):
        start_time = time.time()

        async with session.post(
            base_url,
            json={
                "model": "microsoft/DialoGPT-medium",
                "messages": [{"role": "user", "content": f"Hello {request_id}"}],
                "max_tokens": 50
            }
        ) as response:
            await response.json()
            return time.time() - start_time

    async with aiohttp.ClientSession() as session:
        tasks = []
        for client in range(concurrent_requests):
            for req in range(requests_per_client):
                request_id = f"client{client}_req{req}"
                tasks.append(single_request(session, request_id))

        response_times = await asyncio.gather(*tasks)

    total_requests = len(response_times)
    avg_response_time = sum(response_times) / total_requests
    throughput = total_requests / max(response_times)

    print(f"Total requests: {total_requests}")
    print(f"Average response time: {avg_response_time:.2f}s")
    print(f"Throughput: {throughput:.2f} req/s")

# Run benchmark
asyncio.run(benchmark_vllm())
```

## Use Cases
- **High-Throughput APIs**: Serving many concurrent requests
- **Production Chatbots**: Enterprise-grade chat services
- **Batch Processing**: Efficient processing of large datasets
- **Research Infrastructure**: High-performance model serving
- **Real-time Applications**: Low-latency AI responses
- **Multi-tenant Systems**: Serving multiple applications

## Advantages
- **Exceptional Performance**: 24x faster than standard inference
- **Memory Efficient**: PagedAttention reduces memory usage
- **Concurrent Processing**: Handle multiple requests simultaneously
- **Production Ready**: Enterprise-grade reliability
- **API Compatible**: Drop-in OpenAI replacement
- **GPU Optimized**: Maximum hardware utilization

## Requirements
- **GPU**: NVIDIA GPUs with CUDA (V100, A100, RTX series)
- **Memory**: 16GB+ GPU memory for 7B models
- **Python**: 3.8+ with CUDA toolkit
- **Storage**: Fast SSD for model loading
- **Network**: High bandwidth for concurrent requests

Back to [[models]]