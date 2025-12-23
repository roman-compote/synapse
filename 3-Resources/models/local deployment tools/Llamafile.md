---
tags:
  - local-deployment
  - single-executable
  - portable
  - mozilla
---

# Llamafile

Revolutionary approach to LLM deployment by Mozilla, packaging models into single executable files for maximum portability and simplicity. Run LLMs with just one file - no installation required.

## Key Features
- **Single Executable**: Entire model in one portable file
- **Zero Installation**: No dependencies or setup required
- **Cross-Platform**: Works on Windows, macOS, Linux
- **Instant Deployment**: Double-click to run
- **Web Interface**: Built-in browser-based chat
- **API Server**: OpenAI-compatible endpoints

## How It Works
```bash
# Llamafile combines:
# 1. llama.cpp inference engine
# 2. Model weights
# 3. Web interface
# 4. HTTP server
# All in a single executable file
```

## Installation and Usage

### Download and Run
```bash
# Download a llamafile (example: TinyLlama)
wget https://huggingface.co/Mozilla/TinyLlama-1.1B-Chat-v1.0-llamafile/resolve/main/TinyLlama-1.1B-Chat-v1.0.Q5_K_M.llamafile

# Make executable (Linux/macOS)
chmod +x TinyLlama-1.1B-Chat-v1.0.Q5_K_M.llamafile

# Run the model
./TinyLlama-1.1B-Chat-v1.0.Q5_K_M.llamafile

# Windows: Double-click the .llamafile or run in cmd
# TinyLlama-1.1B-Chat-v1.0.Q5_K_M.llamafile
```

### Command Line Options
```bash
# Basic usage with options
./model.llamafile --server --host 0.0.0.0 --port 8080

# GPU acceleration
./model.llamafile --n-gpu-layers 35

# Custom context length
./model.llamafile --ctx-size 4096

# Multiple options
./model.llamafile \
  --server \
  --host 0.0.0.0 \
  --port 8080 \
  --n-gpu-layers 32 \
  --ctx-size 2048 \
  --threads 8
```

## Available Models

### Popular Llamafiles
```bash
# TinyLlama (1.1B) - Great for testing
wget https://huggingface.co/Mozilla/TinyLlama-1.1B-Chat-v1.0-llamafile/resolve/main/TinyLlama-1.1B-Chat-v1.0.Q5_K_M.llamafile

# Llama 3 8B
wget https://huggingface.co/Mozilla/Meta-Llama-3-8B-Instruct-llamafile/resolve/main/Meta-Llama-3-8B-Instruct.Q4_K_M.llamafile

# Mistral 7B
wget https://huggingface.co/Mozilla/Mistral-7B-Instruct-v0.2-llamafile/resolve/main/Mistral-7B-Instruct-v0.2.Q4_K_M.llamafile

# Code Llama 7B
wget https://huggingface.co/Mozilla/CodeLlama-7b-Instruct-hf-llamafile/resolve/main/CodeLlama-7b-Instruct.Q4_K_M.llamafile

# Phi-3 Mini
wget https://huggingface.co/Mozilla/Phi-3-mini-4k-instruct-llamafile/resolve/main/Phi-3-mini-4k-instruct.Q4_K_M.llamafile
```

### Model Sizes and Requirements
```yaml
TinyLlama 1.1B:
  - Size: ~700MB
  - RAM: 2GB minimum
  - Use case: Testing, lightweight applications

Phi-3 Mini (3.8B):
  - Size: ~2.3GB
  - RAM: 4GB minimum
  - Use case: Efficient general purpose

Mistral/Llama 7B:
  - Size: ~4-5GB
  - RAM: 8GB minimum
  - Use case: High-quality responses

Llama 13B:
  - Size: ~8-10GB
  - RAM: 16GB minimum
  - Use case: Advanced reasoning
```

## API Usage

### Starting the Server
```bash
# Start server mode
./model.llamafile --server --host 0.0.0.0 --port 8080

# Server will be available at:
# http://localhost:8080 (web interface)
# http://localhost:8080/v1 (API endpoint)
```

### API Examples
```python
# Python client
import requests
import json

# Chat completion
def chat_with_llamafile(message, model="llamafile"):
    url = "http://localhost:8080/v1/chat/completions"

    data = {
        "model": model,
        "messages": [
            {"role": "user", "content": message}
        ],
        "temperature": 0.7,
        "max_tokens": 500
    }

    response = requests.post(url, json=data)
    return response.json()["choices"][0]["message"]["content"]

# Example usage
response = chat_with_llamafile("What is machine learning?")
print(response)
```

### cURL Examples
```bash
# Chat completions
curl http://localhost:8080/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "llamafile",
    "messages": [
      {"role": "user", "content": "Hello!"}
    ],
    "temperature": 0.7
  }'

# Text completions
curl http://localhost:8080/completion \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "The future of AI is",
    "n_predict": 100,
    "temperature": 0.8
  }'

# Model information
curl http://localhost:8080/v1/models
```

### Streaming Responses
```python
import requests
import json

def stream_llamafile_chat(message):
    url = "http://localhost:8080/v1/chat/completions"

    data = {
        "model": "llamafile",
        "messages": [{"role": "user", "content": message}],
        "stream": True,
        "temperature": 0.7
    }

    with requests.post(url, json=data, stream=True) as response:
        for line in response.iter_lines():
            if line:
                try:
                    json_str = line.decode('utf-8').replace('data: ', '')
                    if json_str.strip() == '[DONE]':
                        break

                    chunk = json.loads(json_str)
                    content = chunk['choices'][0]['delta'].get('content', '')
                    if content:
                        print(content, end='', flush=True)
                except json.JSONDecodeError:
                    continue

# Usage
stream_llamafile_chat("Write a short poem about technology")
```

## Creating Custom Llamafiles

### Build Your Own
```bash
# Install llamafile tools
git clone https://github.com/Mozilla-Ocho/llamafile.git
cd llamafile

# Convert GGUF model to llamafile
./llamafile-convert \
  --input model.gguf \
  --output model.llamafile \
  --template chatml

# Create from HuggingFace model
python -m llamafile.convert \
  --model microsoft/DialoGPT-medium \
  --output DialoGPT.llamafile
```

### Customization Options
```bash
# Add custom system prompt
./model.llamafile --system "You are a helpful coding assistant"

# Custom stopping strings
./model.llamafile --stop "Human:" --stop "Assistant:"

# Adjust sampling parameters
./model.llamafile \
  --temperature 0.8 \
  --top-p 0.9 \
  --top-k 40 \
  --repeat-penalty 1.1
```

## Integration Examples

### Docker Integration
```dockerfile
# Dockerfile for llamafile
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y wget

# Download llamafile
RUN wget -O /app/model.llamafile \
  https://huggingface.co/Mozilla/TinyLlama-1.1B-Chat-v1.0-llamafile/resolve/main/TinyLlama-1.1B-Chat-v1.0.Q5_K_M.llamafile

# Make executable
RUN chmod +x /app/model.llamafile

# Expose port
EXPOSE 8080

# Run server
CMD ["/app/model.llamafile", "--server", "--host", "0.0.0.0", "--port", "8080"]
```

### Service Deployment
```bash
# Systemd service file (/etc/systemd/system/llamafile.service)
[Unit]
Description=Llamafile LLM Server
After=network.target

[Service]
Type=simple
User=llamafile
WorkingDirectory=/opt/llamafile
ExecStart=/opt/llamafile/model.llamafile --server --host 0.0.0.0 --port 8080
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target

# Enable and start
sudo systemctl enable llamafile
sudo systemctl start llamafile
```

### Load Balancer Setup
```yaml
# nginx.conf for load balancing multiple llamafiles
upstream llamafile_backend {
    server 127.0.0.1:8080;
    server 127.0.0.1:8081;
    server 127.0.0.1:8082;
}

server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://llamafile_backend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    location /v1/ {
        proxy_pass http://llamafile_backend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

## Advanced Usage

### Multi-Model Deployment
```bash
# Run multiple models on different ports
./model1.llamafile --server --port 8080 &
./model2.llamafile --server --port 8081 &
./model3.llamafile --server --port 8082 &

# Create a simple router
python -c "
import http.server
import socketserver
from urllib.parse import urlparse

class ModelRouter(http.server.SimpleHTTPRequestHandler):
    def do_POST(self):
        # Route based on model parameter
        # Implementation here...
        pass
"
```

### Batch Processing
```python
import asyncio
import aiohttp

async def batch_process_llamafile(prompts, base_url="http://localhost:8080"):
    async with aiohttp.ClientSession() as session:
        tasks = []

        for prompt in prompts:
            task = process_single_prompt(session, prompt, base_url)
            tasks.append(task)

        results = await asyncio.gather(*tasks)
        return results

async def process_single_prompt(session, prompt, base_url):
    url = f"{base_url}/v1/chat/completions"
    data = {
        "model": "llamafile",
        "messages": [{"role": "user", "content": prompt}],
        "temperature": 0.7
    }

    async with session.post(url, json=data) as response:
        result = await response.json()
        return result["choices"][0]["message"]["content"]

# Usage
prompts = ["Explain AI", "What is Python?", "Describe quantum computing"]
results = asyncio.run(batch_process_llamafile(prompts))
for i, result in enumerate(results):
    print(f"Result {i+1}: {result}")
```

## Use Cases
- **Edge Deployment**: Single file deployment at the edge
- **Rapid Prototyping**: Quick AI integration without setup
- **Offline Applications**: Complete offline AI capability
- **Educational Tools**: Easy distribution to students
- **Embedded Systems**: AI in resource-constrained environments
- **Demo Applications**: Portable AI demonstrations

## Advantages
- **Ultimate Portability**: Single file contains everything
- **Zero Dependencies**: No installation or setup required
- **Instant Deployment**: Double-click to run
- **Cross-Platform**: Works everywhere
- **Offline Capable**: No internet connection needed
- **Distribution Friendly**: Easy to share and distribute

## Limitations
- **Large File Sizes**: Single file contains entire model
- **Limited Customization**: Fewer options than dedicated tools
- **Update Complexity**: Entire file must be replaced for updates
- **Memory Usage**: Full model loaded into memory
- **Model Selection**: Limited to llamafile-compatible formats

## Requirements
- **Storage**: Model size + overhead (700MB - 10GB+)
- **Memory**: 1.5x model size in RAM
- **OS**: Windows 10+, macOS 10.15+, Linux
- **Architecture**: x86_64, ARM64 supported
- **GPU**: Optional CUDA/Metal acceleration

Back to [[models]]