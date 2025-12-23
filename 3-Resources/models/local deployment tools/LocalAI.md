---
tags:
  - local-deployment
  - openai-compatible
  - enterprise
  - self-hosted
---

# LocalAI

Enterprise-grade, self-hosted OpenAI-compatible API server for running local AI models. Designed as a drop-in replacement for OpenAI API with support for multiple model types and formats.

## Key Features
- **OpenAI-Compatible**: Complete API compatibility
- **Multi-Modal**: Text, image, audio, and embedding models
- **Multiple Backends**: Support for various inference engines
- **Enterprise Ready**: Production-grade deployment options
- **No Internet Required**: Fully offline operation
- **Model Agnostic**: Works with many model formats

## Installation

### Docker (Recommended)
```bash
# Quick start
docker run -p 8080:8080 --name local-ai \
  -ti localai/localai:latest

# With GPU support
docker run -p 8080:8080 --gpus all --name local-ai \
  -ti localai/localai:latest-gpu-nvidia-cuda-11

# With model directory
docker run -p 8080:8080 \
  -v /path/to/models:/models \
  --name local-ai \
  localai/localai:latest
```

### Docker Compose
```yaml
version: '3.6'
services:
  api:
    image: localai/localai:latest-gpu-nvidia-cuda-11
    ports:
      - 8080:8080
    environment:
      - DEBUG=true
      - MODELS_PATH=/models
      - THREADS=4
      - CONTEXT_SIZE=512
    volumes:
      - ./models:/models:cached
      - ./images/:/tmp/generated/images/
    command: ["/usr/bin/local-ai"]
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
```

### Binary Installation
```bash
# Download binary for your OS
curl -Lo local-ai "https://github.com/go-skynet/LocalAI/releases/download/{{< version >}}/local-ai-$(uname -s)-$(uname -m)" && chmod +x local-ai && sudo mv local-ai /usr/local/bin/

# Run with models directory
./local-ai --models-path ./models --debug
```

### Kubernetes Deployment
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: localai
  labels:
    app: localai
spec:
  selector:
    matchLabels:
      app: localai
  template:
    metadata:
      labels:
        app: localai
    spec:
      containers:
      - name: localai
        image: localai/localai:latest
        ports:
        - containerPort: 8080
        env:
        - name: MODELS_PATH
          value: /models
        volumeMounts:
        - name: models
          mountPath: /models
      volumes:
      - name: models
        persistentVolumeClaim:
          claimName: localai-models
```

## Model Configuration

### Model Installation
```bash
# Download models via API
curl http://localhost:8080/models/apply -H "Content-Type: application/json" -d '{
  "url": "github:go-skynet/model-gallery/gpt4all-j.yaml",
  "name": "gpt-4all-j",
  "overrides": {"f16": true}
}'

# Download specific model files
wget -O models/ggml-gpt4all-j.bin https://gpt4all.io/models/ggml-gpt4all-j-v1.3-groovy.bin
```

### Model Configuration Files
```yaml
# models/mistral.yaml
name: mistral-7b
backend: llama-cpp
parameters:
  model: mistral-7b-instruct-v0.1.Q4_K_M.gguf
  top_k: 40
  top_p: 0.9
  temperature: 0.1
  max_tokens: 512
  context_size: 2048
  threads: 4
  f16: true
  mirostat: 2
  mirostat_tau: 0.8
  mirostat_eta: 0.1

template:
  chat: |
    [INST] {{.Input}} [/INST]
  completion: |
    {{.Input}}

stopwords:
- "[INST]"
- "[/INST]"
```

### Advanced Configuration
```yaml
# models/advanced-config.yaml
name: custom-model
backend: llama-cpp
parameters:
  model: model.gguf
  context_size: 4096
  threads: 8
  gpu_layers: 35
  batch: 512
  f16: true
  low_vram: false

# Model-specific overrides
roles:
  assistant: "### Assistant:"
  user: "### Human:"
  system: "### System:"

template:
  chat: |
    ### System:
    {{.SystemPrompt}}
    ### Human:
    {{.Input}}
    ### Assistant:

# Function calling support
tools: true
functions:
  weather:
    description: "Get weather information"
    properties:
      location:
        type: string
        description: "The city name"
```

## API Usage

### Chat Completions
```python
from openai import OpenAI

# Initialize client
client = OpenAI(
    base_url="http://localhost:8080/v1",
    api_key="dummy"  # Not required but OpenAI library needs it
)

# Chat completion
def chat_with_localai(message, model="gpt-3.5-turbo"):
    response = client.chat.completions.create(
        model=model,
        messages=[
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": message}
        ],
        temperature=0.7,
        max_tokens=500
    )

    return response.choices[0].message.content

# Usage
response = chat_with_localai("What is machine learning?")
print(response)
```

### Embeddings
```python
# Generate embeddings
def get_embeddings(texts, model="text-embedding-ada-002"):
    response = client.embeddings.create(
        model=model,
        input=texts
    )

    return [embedding.embedding for embedding in response.data]

# Usage
texts = ["Hello world", "Machine learning is fascinating"]
embeddings = get_embeddings(texts)
print(f"Generated {len(embeddings)} embeddings")
```

### Image Generation
```python
# Generate images (if stable-diffusion backend is configured)
def generate_image(prompt, model="dall-e-2"):
    response = client.images.generate(
        model=model,
        prompt=prompt,
        n=1,
        size="512x512"
    )

    return response.data[0].url

# Usage
image_url = generate_image("A futuristic city at sunset")
print(f"Generated image: {image_url}")
```

### Audio Transcription
```python
# Transcribe audio (if whisper model is configured)
def transcribe_audio(audio_file_path, model="whisper-1"):
    with open(audio_file_path, "rb") as audio_file:
        response = client.audio.transcriptions.create(
            model=model,
            file=audio_file
        )

    return response.text

# Usage
transcription = transcribe_audio("audio.mp3")
print(f"Transcription: {transcription}")
```

## Advanced Features

### Function Calling
```python
# Define functions
functions = [
    {
        "name": "get_weather",
        "description": "Get current weather in a location",
        "parameters": {
            "type": "object",
            "properties": {
                "location": {
                    "type": "string",
                    "description": "The city and state, e.g. San Francisco, CA"
                },
                "unit": {
                    "type": "string",
                    "enum": ["celsius", "fahrenheit"],
                    "description": "The unit for temperature"
                }
            },
            "required": ["location"]
        }
    }
]

# Chat with function calling
response = client.chat.completions.create(
    model="gpt-3.5-turbo",
    messages=[
        {"role": "user", "content": "What's the weather in New York?"}
    ],
    functions=functions,
    function_call="auto"
)

# Handle function calls
if response.choices[0].message.function_call:
    function_call = response.choices[0].message.function_call
    print(f"Function called: {function_call.name}")
    print(f"Arguments: {function_call.arguments}")
```

### Streaming Responses
```python
def stream_chat(message):
    stream = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=[{"role": "user", "content": message}],
        stream=True,
        temperature=0.7
    )

    for chunk in stream:
        if chunk.choices[0].delta.content is not None:
            print(chunk.choices[0].delta.content, end="")

# Usage
stream_chat("Tell me a story about artificial intelligence")
```

### Custom Backends
```yaml
# models/custom-backend.yaml
name: custom-model
backend: custom-backend
parameters:
  custom_parameter: value
  executable_path: /path/to/custom/executable
  args:
    - --model
    - model.bin
    - --threads
    - "4"

template:
  chat: |
    Human: {{.Input}}
    Assistant:
```

## Integration Examples

### LangChain Integration
```python
from langchain_openai import ChatOpenAI
from langchain.schema import HumanMessage

# Initialize with LocalAI
llm = ChatOpenAI(
    openai_api_base="http://localhost:8080/v1",
    openai_api_key="dummy",
    model_name="gpt-3.5-turbo",
    temperature=0.7
)

# Use with LangChain
messages = [HumanMessage(content="What is quantum computing?")]
response = llm(messages)
print(response.content)
```

### FastAPI Integration
```python
from fastapi import FastAPI, HTTPException
from openai import OpenAI
import uvicorn

app = FastAPI()
client = OpenAI(base_url="http://localhost:8080/v1", api_key="dummy")

@app.post("/chat")
async def chat_endpoint(message: str, model: str = "gpt-3.5-turbo"):
    try:
        response = client.chat.completions.create(
            model=model,
            messages=[{"role": "user", "content": message}],
            temperature=0.7
        )
        return {"response": response.choices[0].message.content}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/models")
async def list_models():
    models = client.models.list()
    return {"models": [model.id for model in models.data]}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
```

### Multi-Modal Application
```python
class LocalAIClient:
    def __init__(self, base_url="http://localhost:8080/v1"):
        self.client = OpenAI(base_url=base_url, api_key="dummy")

    def chat(self, message, model="gpt-3.5-turbo"):
        response = self.client.chat.completions.create(
            model=model,
            messages=[{"role": "user", "content": message}]
        )
        return response.choices[0].message.content

    def embed(self, text, model="text-embedding-ada-002"):
        response = self.client.embeddings.create(
            model=model,
            input=text
        )
        return response.data[0].embedding

    def generate_image(self, prompt, model="dall-e-2"):
        response = self.client.images.generate(
            model=model,
            prompt=prompt,
            n=1,
            size="512x512"
        )
        return response.data[0].url

    def transcribe(self, audio_path, model="whisper-1"):
        with open(audio_path, "rb") as audio_file:
            response = self.client.audio.transcriptions.create(
                model=model,
                file=audio_file
            )
        return response.text

# Usage
ai = LocalAIClient()
print(ai.chat("Hello!"))
print(ai.embed("Sample text"))
```

## Production Deployment

### High Availability Setup
```yaml
# docker-compose-ha.yml
version: '3.8'
services:
  localai-1:
    image: localai/localai:latest-gpu-nvidia-cuda-11
    environment:
      - MODELS_PATH=/models
    volumes:
      - ./models:/models

  localai-2:
    image: localai/localai:latest-gpu-nvidia-cuda-11
    environment:
      - MODELS_PATH=/models
    volumes:
      - ./models:/models

  localai-3:
    image: localai/localai:latest-gpu-nvidia-cuda-11
    environment:
      - MODELS_PATH=/models
    volumes:
      - ./models:/models

  nginx:
    image: nginx:alpine
    ports:
      - "8080:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    depends_on:
      - localai-1
      - localai-2
      - localai-3
```

### Monitoring and Metrics
```python
import requests
import time

def monitor_localai(base_url="http://localhost:8080"):
    try:
        # Health check
        health = requests.get(f"{base_url}/readiness")

        # List models
        models = requests.get(f"{base_url}/v1/models").json()

        # Get metrics (if available)
        metrics = {
            "status": "healthy" if health.status_code == 200 else "unhealthy",
            "models_loaded": len(models.get("data", [])),
            "timestamp": time.time()
        }

        return metrics
    except Exception as e:
        return {"error": str(e), "timestamp": time.time()}

# Monitoring loop
while True:
    metrics = monitor_localai()
    print(f"LocalAI Status: {metrics}")
    time.sleep(30)
```

## Use Cases
- **Enterprise AI**: Self-hosted alternative to OpenAI
- **Privacy-Critical Applications**: Complete data control
- **Offline AI Systems**: No internet dependency
- **Multi-Modal Applications**: Text, image, audio processing
- **Cost Optimization**: Reduce API costs
- **Regulatory Compliance**: Meet data residency requirements

## Advantages
- **Drop-in Replacement**: OpenAI API compatibility
- **Multi-Modal Support**: Various AI capabilities
- **Self-Hosted**: Complete control and privacy
- **No Vendor Lock-in**: Use any compatible models
- **Cost Effective**: Eliminate API costs
- **Offline Operation**: No internet required

## Requirements
- **Hardware**: CPU/GPU depending on models
- **Memory**: 8GB+ RAM for basic models
- **Storage**: SSD recommended for model storage
- **Network**: For initial model downloads
- **OS**: Linux, Windows, macOS supported
- **Container Runtime**: Docker for containerized deployment

Back to [[models]]