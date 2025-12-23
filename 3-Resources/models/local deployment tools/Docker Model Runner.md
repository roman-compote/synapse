---
tags:
  - local-deployment
  - docker-desktop
  - cli-tool
  - native-performance
---

# Docker Model Runner

Docker's latest innovation for running AI models locally, integrated directly into Docker Desktop 4.40+. Treats AI models as first-class citizens alongside containers, images, and volumes with native host performance.

## Key Features
- **Native Performance**: Models run on host system, not in containers
- **First-Class CLI**: AI models are core Docker objects
- **OpenAI-Compatible API**: Standard API integration
- **Apple Silicon Optimized**: GPU acceleration on M1/M2 Macs
- **OCI Artifacts**: Models packaged as standard container registry artifacts
- **No Container Overhead**: Direct host execution for maximum performance

## Installation & Requirements

### System Requirements
- **Docker Desktop**: 4.40+ (Beta/GA)
- **Platform**: macOS on Apple Silicon (M1/M2/M3)
- **Memory**: 8GB+ RAM recommended
- **Storage**: Varies by model size (1GB-10GB+)

### Availability
```bash
# Check if Docker Model Runner is available
docker model version

# Check status
docker model status
```

## Core Commands

### Model Management
```bash
# List available models
docker model list

# Pull a model from registry
docker model pull ai/smollm2:360M-Q4_K_M

# Remove a downloaded model
docker model rm ai/smollm2:360M-Q4_K_M

# Check Docker Model Runner status
docker model status
```

### Running Models
```bash
# Basic model execution
docker model run ai/smollm2:360M-Q4_K_M "Tell me about machine learning"

# Run with specific prompt
docker model run ai/llama3:8b "What is quantum computing?"

# Interactive mode (if available)
docker model run ai/mistral:7b --interactive
```

## Available Models

### Popular Pre-built Models
```bash
# Small models (good for testing)
docker model pull ai/smollm2:360M-Q4_K_M      # 360M parameters
docker model pull ai/tinyllama:1.1b           # 1.1B parameters

# Medium models (balanced performance)
docker model pull ai/llama3:8b                # 8B parameters
docker model pull ai/mistral:7b               # 7B parameters
docker model pull ai/phi3:mini                # 3.8B parameters

# Large models (high performance)
docker model pull ai/llama3:70b               # 70B parameters
docker model pull ai/codellama:13b            # 13B for coding
```

### Model Naming Convention
```yaml
# Model tags follow this pattern:
# registry/namespace/model:size-quantization

Examples:
  ai/smollm2:360M-Q4_K_M     # 360M params, Q4_K_M quantization
  ai/llama3:8b-Q4_0          # 8B params, Q4_0 quantization
  ai/mistral:7b-f16          # 7B params, full precision

Quantization Types:
  Q4_K_M: 4-bit quantization (balanced)
  Q8_0: 8-bit quantization (higher quality)
  f16: 16-bit float (full precision)
```

## Usage Examples

### Command Line Interface
```bash
# Single prompt execution
docker model run ai/llama3:8b "Explain artificial intelligence in simple terms"

# Multiple prompts
docker model run ai/mistral:7b "What is Python?" && \
docker model run ai/mistral:7b "What is machine learning?"

# Redirect output to file
docker model run ai/codellama:7b "Write a Python hello world program" > output.txt
```

### API Server Mode
```bash
# Start model as API server (if supported)
docker model serve ai/llama3:8b --port 8080

# The model becomes available at:
# http://localhost:8080/v1/chat/completions
```

### Integration with Scripts
```bash
#!/bin/bash
# automated_analysis.sh

MODEL="ai/llama3:8b"
INPUT_FILE="documents.txt"

while read -r line; do
    echo "Processing: $line"
    docker model run $MODEL "Summarize this text: $line" >> summaries.txt
done < "$INPUT_FILE"
```

## API Integration

### Python Client Example
```python
# If Docker Model Runner exposes OpenAI-compatible API
import subprocess
import json

def run_docker_model(prompt, model="ai/llama3:8b"):
    """Run Docker model via CLI and capture output"""
    try:
        result = subprocess.run([
            "docker", "model", "run", model, prompt
        ], capture_output=True, text=True, check=True)

        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        return f"Error: {e.stderr}"

# Usage
response = run_docker_model("What is machine learning?")
print(f"Response: {response}")
```

### API Server Integration (if available)
```python
# If model is served as API server
from openai import OpenAI

# Connect to local Docker Model Runner API
client = OpenAI(
    base_url="http://localhost:8080/v1",
    api_key="not-needed"  # Local execution doesn't require key
)

def chat_with_docker_model(message, model="ai/llama3:8b"):
    response = client.chat.completions.create(
        model=model,
        messages=[
            {"role": "user", "content": message}
        ],
        temperature=0.7
    )

    return response.choices[0].message.content

# Usage
response = chat_with_docker_model("Explain quantum computing")
print(response)
```

## Docker Compose Integration

### AI Services in Compose (Docker Compose v2.35+)
```yaml
version: '3.8'

services:
  # Define AI model as a service
  llama-model:
    type: model
    image: ai/llama3:8b
    ports:
      - "8080:8080"

  # Application service that depends on the model
  web-app:
    image: my-app:latest
    depends_on:
      - llama-model
    environment:
      # Docker automatically injects these variables
      - LLAMA_MODEL_URL=${LLAMA_MODEL_URL}
      - LLAMA_MODEL_MODEL=${LLAMA_MODEL_MODEL}
    ports:
      - "3000:3000"

  # Another service using a different model
  code-assistant:
    type: model
    image: ai/codellama:7b

  development-tools:
    image: dev-tools:latest
    depends_on:
      - code-assistant
    environment:
      - CODE_ASSISTANT_URL=${CODE_ASSISTANT_URL}
```

### Multi-Model Application
```yaml
# docker-compose.yml for multi-model AI application
version: '3.8'

services:
  # Chat model for general conversation
  chat-model:
    type: model
    image: ai/llama3:8b

  # Code-specific model
  code-model:
    type: model
    image: ai/codellama:7b

  # Small model for quick tasks
  quick-model:
    type: model
    image: ai/smollm2:360M-Q4_K_M

  # Main application
  ai-app:
    build: .
    depends_on:
      - chat-model
      - code-model
      - quick-model
    environment:
      - CHAT_MODEL_URL=${CHAT_MODEL_URL}
      - CODE_MODEL_URL=${CODE_MODEL_URL}
      - QUICK_MODEL_URL=${QUICK_MODEL_URL}
    ports:
      - "8000:8000"
```

## Advanced Usage

### Model Performance Optimization
```bash
# Check model status and resource usage
docker model status

# Monitor system resources while running models
top -p $(pgrep -f "docker.*model")

# Run multiple models efficiently (if supported)
docker model run ai/smollm2:360M-Q4_K_M "Quick task" &
docker model run ai/llama3:8b "Complex task" &
wait
```

### Automated Model Management
```bash
#!/bin/bash
# model_manager.sh

# List of models to maintain
MODELS=(
    "ai/llama3:8b"
    "ai/mistral:7b"
    "ai/codellama:7b"
    "ai/smollm2:360M-Q4_K_M"
)

# Update all models
for model in "${MODELS[@]}"; do
    echo "Updating $model..."
    docker model pull "$model"
done

# Clean up old models
echo "Cleaning up unused models..."
docker model prune
```

### Batch Processing Script
```python
#!/usr/bin/env python3
# batch_processor.py

import subprocess
import sys
import json
from concurrent.futures import ThreadPoolExecutor, as_completed

def process_with_model(prompt, model="ai/llama3:8b"):
    """Process single prompt with Docker model"""
    try:
        result = subprocess.run([
            "docker", "model", "run", model, prompt
        ], capture_output=True, text=True, check=True)
        return {"prompt": prompt, "response": result.stdout.strip(), "error": None}
    except subprocess.CalledProcessError as e:
        return {"prompt": prompt, "response": None, "error": e.stderr}

def batch_process(prompts, model="ai/llama3:8b", max_workers=3):
    """Process multiple prompts in parallel"""
    results = []

    with ThreadPoolExecutor(max_workers=max_workers) as executor:
        # Submit all tasks
        future_to_prompt = {
            executor.submit(process_with_model, prompt, model): prompt
            for prompt in prompts
        }

        # Collect results
        for future in as_completed(future_to_prompt):
            result = future.result()
            results.append(result)
            print(f"Processed: {result['prompt'][:50]}...")

    return results

if __name__ == "__main__":
    prompts = [
        "What is artificial intelligence?",
        "Explain machine learning",
        "What is deep learning?",
        "Describe neural networks",
        "What is natural language processing?"
    ]

    results = batch_process(prompts, "ai/llama3:8b")

    # Save results
    with open("batch_results.json", "w") as f:
        json.dump(results, f, indent=2)

    print(f"\nProcessed {len(results)} prompts. Results saved to batch_results.json")
```

## Creating Custom Models

### Packaging GGUF Models as OCI Artifacts
```dockerfile
# Dockerfile for custom model
FROM scratch

# Copy GGUF model file
COPY my-custom-model.gguf /model.gguf

# Add metadata
LABEL org.opencontainers.image.title="My Custom Model"
LABEL org.opencontainers.image.description="Custom AI model for specific tasks"
LABEL ai.model.format="gguf"
LABEL ai.model.quantization="Q4_K_M"
LABEL ai.model.parameters="7B"
```

### Building and Publishing
```bash
# Build custom model OCI artifact
docker buildx build -t myregistry/my-model:latest .

# Push to registry
docker push myregistry/my-model:latest

# Use the custom model
docker model pull myregistry/my-model:latest
docker model run myregistry/my-model:latest "Test prompt"
```

## Troubleshooting

### Common Issues
```yaml
Model Not Found:
  - Check model name and tag
  - Ensure Docker Desktop 4.40+ is running
  - Verify model is available in registry

Performance Issues:
  - Monitor memory usage during model execution
  - Try smaller/quantized models
  - Close other memory-intensive applications
  - Check Apple Silicon optimization is enabled

Command Not Available:
  - Update Docker Desktop to 4.40+
  - Check if feature is enabled in settings
  - Restart Docker Desktop
```

### Diagnostic Commands
```bash
# Check Docker Model Runner installation
docker model version

# Verify system status
docker model status

# List local models
docker model list

# Check Docker Desktop version
docker version

# Monitor resource usage
docker stats
```

## Use Cases
- **Rapid AI Prototyping**: Quick model testing without complex setup
- **Local Development**: Private, offline AI development
- **CI/CD Integration**: Automated testing with AI models
- **Educational Tools**: Easy AI model distribution
- **Performance Testing**: Native execution for benchmarking
- **Multi-Model Applications**: Orchestrate different AI capabilities

## Advantages
- **Native Performance**: No container virtualization overhead
- **Familiar Workflow**: Standard Docker CLI commands
- **Registry Integration**: Use existing container infrastructure
- **Apple Silicon Optimized**: GPU acceleration on M-series Macs
- **Compose Integration**: AI services in Docker Compose
- **Zero Configuration**: Works out-of-the-box with Docker Desktop

## Limitations
- **Platform Specific**: Currently macOS Apple Silicon only
- **GGUF Only**: Limited to GGUF model format
- **Single Model**: One model loaded at a time
- **Beta Status**: Some features still in development
- **Memory Requirements**: Models loaded entirely in memory

## Requirements
- **Docker Desktop**: 4.40+ with Model Runner enabled
- **macOS**: Apple Silicon (M1/M2/M3) required
- **Memory**: 8GB+ RAM (varies by model size)
- **Storage**: SSD recommended for model caching
- **Network**: For initial model downloads

Back to [[models]]