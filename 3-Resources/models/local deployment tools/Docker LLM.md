---
tags:
  - local-deployment
  - docker
  - containerization
---

# Docker LLM

Containerized deployment solutions for running LLMs locally using Docker and Docker Compose. Offers scalable, reproducible, and isolated environments for LLM inference.

## Key Features
- **Containerization**: Isolated environments with consistent dependencies
- **Scalability**: Easy scaling with Docker Compose and orchestration
- **Reproducibility**: Consistent deployment across different systems
- **GPU Support**: CUDA acceleration for improved performance
- **Multi-service**: Complete AI stacks with databases and web interfaces

## Docker Model Runner (Beta)
Available with Docker Desktop 4.40+ for macOS on Apple silicon.

### Basic Usage
```bash
# Pull and run a model through Docker Desktop UI
# Or use CLI:
docker run --rm -it \
  -p 11434:11434 \
  docker.io/ollama/ollama:latest
```

### Features
- Local LLM inference powered by llama.cpp
- OpenAI-compatible API endpoint
- Integrated with Docker Desktop
- No complex setup required

## Docker Compose Stacks

### Basic LLM Stack
```yaml
version: '3.8'
services:
  ollama:
    image: ollama/ollama:latest
    ports:
      - "11434:11434"
    volumes:
      - ollama_data:/root/.ollama
    environment:
      - OLLAMA_HOST=0.0.0.0

  open-webui:
    image: ghcr.io/open-webui/open-webui:main
    ports:
      - "3000:8080"
    environment:
      - OLLAMA_BASE_URL=http://ollama:11434
    depends_on:
      - ollama
    volumes:
      - open_webui_data:/app/backend/data

volumes:
  ollama_data:
  open_webui_data:
```

### Complete AI Stack
```yaml
version: '3.8'
services:
  # Core LLM Service
  ollama:
    image: ollama/ollama:latest
    ports:
      - "11434:11434"
    volumes:
      - ollama_data:/root/.ollama
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]

  # Web Interface
  open-webui:
    image: ghcr.io/open-webui/open-webui:main
    ports:
      - "3000:8080"
    environment:
      - OLLAMA_BASE_URL=http://ollama:11434
    volumes:
      - open_webui_data:/app/backend/data
    depends_on:
      - ollama

  # Vector Database
  qdrant:
    image: qdrant/qdrant:latest
    ports:
      - "6333:6333"
      - "6334:6334"
    volumes:
      - qdrant_data:/qdrant/storage

  # Workflow Automation
  n8n:
    image: docker.io/n8nio/n8n:latest
    ports:
      - "5678:5678"
    environment:
      - N8N_HOST=0.0.0.0
      - N8N_PORT=5678
      - WEBHOOK_URL=http://localhost:5678/
    volumes:
      - n8n_data:/home/node/.n8n

volumes:
  ollama_data:
  open_webui_data:
  qdrant_data:
  n8n_data:
```

## GPU Support Setup

### NVIDIA GPU Support
```bash
# Install NVIDIA Container Toolkit
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg

# Add repository
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Install
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

# Configure Docker
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
```

### Docker Compose with GPU
```yaml
services:
  ollama-gpu:
    image: ollama/ollama:latest
    ports:
      - "11434:11434"
    volumes:
      - ollama_data:/root/.ollama
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]
```

## Popular Docker Images

### Ollama
```bash
# CPU version
docker run -d -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama

# GPU version
docker run -d --gpus=all -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama

# Pull a model
docker exec -it ollama ollama pull llama3
```

### Text-generation-webui
```bash
# CPU version
docker run -d -p 7860:7860 \
  -v text_gen_models:/app/models \
  --name text-gen-webui \
  atinoda/text-generation-webui

# GPU version
docker run -d --gpus all -p 7860:7860 \
  -v text_gen_models:/app/models \
  --name text-gen-webui \
  atinoda/text-generation-webui:latest-cuda
```

### vLLM
```bash
# Run vLLM server
docker run --gpus all \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  -p 8000:8000 \
  --ipc=host \
  vllm/vllm-openai:latest \
  --model microsoft/DialoGPT-medium \
  --chat-template template_chatml.jinja
```

## Management Commands

### Start Stack
```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Check status
docker-compose ps
```

### Model Management
```bash
# Pull models in Ollama
docker exec ollama ollama pull llama3
docker exec ollama ollama pull mistral

# List models
docker exec ollama ollama list

# Remove models
docker exec ollama ollama rm llama3
```

### Maintenance
```bash
# Update images
docker-compose pull
docker-compose up -d

# Clean up
docker system prune -a
docker volume prune
```

## API Usage

### OpenAI-Compatible API
```python
import openai

client = openai.OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama"  # required but unused
)

response = client.chat.completions.create(
    model="llama3",
    messages=[
        {"role": "user", "content": "Hello, how are you?"}
    ]
)

print(response.choices[0].message.content)
```

### Direct API Calls
```bash
# Chat completion
curl http://localhost:11434/api/chat -d '{
  "model": "llama3",
  "messages": [
    {"role": "user", "content": "Why is the sky blue?"}
  ]
}'

# Generate completion
curl http://localhost:11434/api/generate -d '{
  "model": "llama3",
  "prompt": "Why is the sky blue?"
}'
```

## Use Cases
- **Development**: Consistent dev environments across teams
- **Production**: Scalable deployment with orchestration
- **Multi-service**: Complete AI stacks with databases and UIs
- **CI/CD**: Automated testing and deployment pipelines
- **Edge Deployment**: Portable containers for edge computing
- **Research**: Reproducible experimental environments

## Advantages
- **Isolation**: Each service in separate containers
- **Scalability**: Easy horizontal scaling
- **Portability**: Run anywhere Docker runs
- **Version Control**: Pin specific versions
- **Resource Management**: Control CPU/GPU allocation
- **Monitoring**: Built-in logging and metrics

## Requirements
- **Docker**: Docker Engine 20.10+
- **Docker Compose**: Version 2.0+
- **GPU Support**: NVIDIA Container Toolkit (for GPU)
- **Memory**: 8GB+ RAM recommended
- **Storage**: SSD recommended for model storage

Back to [[models]]