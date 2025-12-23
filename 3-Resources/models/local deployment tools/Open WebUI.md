---
tags:
  - local-deployment
  - web-interface
  - open-source
  - feature-rich
---

# Open WebUI

Extensible, feature-rich, user-friendly web interface for running LLMs locally. Supports multiple backends including Ollama and OpenAI-compatible APIs with built-in RAG capabilities.

## Key Features
- **Web Interface**: Browser-based chat interface
- **Multi-backend Support**: Ollama, OpenAI API, and others
- **Built-in RAG**: Document processing and knowledge retrieval
- **Model Builder**: Create custom models via web UI
- **User Management**: Multi-user support with authentication
- **Extensible**: Plugin system and customizations

## Installation Methods

### Docker (Recommended)
```bash
# Basic installation
docker run -d -p 3000:8080 \
  --add-host=host.docker.internal:host-gateway \
  -v open-webui:/app/backend/data \
  --name open-webui \
  --restart always \
  ghcr.io/open-webui/open-webui:main

# With Ollama integration
docker run -d -p 3000:8080 \
  -e OLLAMA_BASE_URL=http://host.docker.internal:11434 \
  -v open-webui:/app/backend/data \
  --name open-webui \
  --restart always \
  ghcr.io/open-webui/open-webui:main
```

### Docker Compose
```yaml
version: '3.8'

services:
  ollama:
    image: ollama/ollama:latest
    container_name: ollama
    volumes:
      - ollama:/root/.ollama
    ports:
      - "11434:11434"
    restart: always

  open-webui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: open-webui
    depends_on:
      - ollama
    ports:
      - "3000:8080"
    environment:
      - 'OLLAMA_BASE_URL=http://ollama:11434'
      - 'WEBUI_SECRET_KEY='
    volumes:
      - open-webui:/app/backend/data
    restart: always

volumes:
  ollama:
  open-webui:
```

### Kubernetes with Helm
```bash
# Add Helm repository
helm repo add open-webui https://helm.openwebui.com/
helm repo update

# Install with Ollama
helm install open-webui open-webui/open-webui \
  --set ollama.enabled=true \
  --set ingress.enabled=true \
  --set ingress.host=your-domain.com
```

### Python Installation
```bash
# Install via pip
pip install open-webui

# Run the application
open-webui serve

# Custom configuration
open-webui serve --host 0.0.0.0 --port 8080
```

## Configuration

### Environment Variables
```bash
# Basic configuration
OLLAMA_BASE_URL=http://localhost:11434
OPENAI_API_BASE_URL=https://api.openai.com/v1
OPENAI_API_KEY=your_openai_key

# Authentication
WEBUI_SECRET_KEY=your-secret-key
ENABLE_SIGNUP=true
DEFAULT_USER_ROLE=user

# Features
ENABLE_RAG_WEB_SEARCH=true
RAG_WEB_SEARCH_ENGINE=searxng
ENABLE_IMAGE_GENERATION=true
IMAGE_GENERATION_ENGINE=automatic1111

# Security
WEBUI_AUTH=true
JWT_EXPIRES_IN=168h
```

### Advanced Configuration
```yaml
# config.json example
{
  "ui": {
    "prompt_suggestions": [
      {
        "title": ["Help me study", "Help me study for my exam"],
        "content": "Help me study for my exam about [topic]"
      }
    ]
  },
  "ollama": {
    "base_url": "http://localhost:11434"
  },
  "audio": {
    "tts": {
      "engine": "openai",
      "voice": "alloy"
    },
    "stt": {
      "engine": "whisper"
    }
  }
}
```

## Features and Usage

### Model Management
```python
# Models are managed through the web interface
# 1. Navigate to Admin Panel > Models
# 2. Add model configurations
# 3. Import models from Ollama or other sources

# Example model configuration:
{
  "name": "llama3",
  "meta": {
    "description": "Meta's Llama 3 model",
    "capabilities": {
      "vision": false,
      "usage": "general"
    }
  },
  "base_model_id": "llama3",
  "params": {
    "system": "You are a helpful AI assistant.",
    "temperature": 0.7,
    "top_p": 0.9
  }
}
```

### RAG (Retrieval-Augmented Generation)
```bash
# Document upload and processing
1. Navigate to "Knowledge" section
2. Upload documents (PDF, TXT, MD, etc.)
3. Documents are automatically processed and indexed
4. Use in chat with "#doc_name" syntax

# Web search integration
curl -X POST http://localhost:3000/api/rag/web \
  -H "Content-Type: application/json" \
  -d '{"query": "latest AI research", "count": 5}'
```

### Custom Functions
```python
# Create custom functions via the web interface
# Example: Weather function
def get_weather(location: str) -> str:
    """Get current weather for a location"""
    import requests

    # Your weather API logic here
    api_key = "your_api_key"
    url = f"http://api.openweathermap.org/data/2.5/weather"
    params = {
        "q": location,
        "appid": api_key,
        "units": "metric"
    }

    response = requests.get(url, params=params)
    data = response.json()

    return f"Weather in {location}: {data['weather'][0]['description']}, {data['main']['temp']}°C"
```

### User Management
```python
# Admin functions (accessible via web interface)
# 1. Create user accounts
# 2. Set permissions and roles
# 3. Manage access to models
# 4. Configure authentication methods

# API for user management
curl -X POST http://localhost:3000/api/auths/signup \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "password123",
    "name": "John Doe"
  }'
```

## API Integration

### Chat Completions
```python
import requests

# Chat with Open WebUI API
def chat_with_openwebui(message, model="llama3"):
    url = "http://localhost:3000/api/chat/completions"
    headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer your_token_here"
    }

    data = {
        "model": model,
        "messages": [
            {"role": "user", "content": message}
        ],
        "stream": False
    }

    response = requests.post(url, json=data, headers=headers)
    return response.json()

# Example usage
result = chat_with_openwebui("What is machine learning?")
print(result["choices"][0]["message"]["content"])
```

### WebSocket for Real-time Chat
```javascript
// WebSocket connection for streaming responses
const ws = new WebSocket('ws://localhost:3000/ws');

ws.onopen = function(event) {
    console.log('Connected to WebSocket');

    // Send chat message
    ws.send(JSON.stringify({
        type: 'chat',
        model: 'llama3',
        message: 'Hello, how are you?'
    }));
};

ws.onmessage = function(event) {
    const data = JSON.parse(event.data);
    console.log('Received:', data.content);
};
```

### Python Client Library
```python
# Custom client for Open WebUI
class OpenWebUIClient:
    def __init__(self, base_url="http://localhost:3000", token=None):
        self.base_url = base_url
        self.token = token
        self.session = requests.Session()
        if token:
            self.session.headers.update({"Authorization": f"Bearer {token}"})

    def chat(self, message, model="llama3", stream=False):
        url = f"{self.base_url}/api/chat/completions"
        data = {
            "model": model,
            "messages": [{"role": "user", "content": message}],
            "stream": stream
        }

        if stream:
            return self.session.post(url, json=data, stream=True)
        else:
            response = self.session.post(url, json=data)
            return response.json()

    def upload_document(self, file_path, collection_name="default"):
        url = f"{self.base_url}/api/knowledge/upload"
        files = {"file": open(file_path, "rb")}
        data = {"collection": collection_name}

        response = self.session.post(url, files=files, data=data)
        return response.json()

# Usage
client = OpenWebUIClient()
response = client.chat("Explain quantum physics")
print(response)
```

## Advanced Features

### Custom Models and Agents
```yaml
# Model configuration via web interface
Model Builder:
  - Create custom model configurations
  - Set system prompts and parameters
  - Define capabilities and restrictions
  - Share models with community

Agent Creation:
  - Define specialized AI agents
  - Configure tools and functions
  - Set up workflows and triggers
  - Multi-agent conversations
```

### Integration Examples

#### With n8n Workflows
```javascript
// n8n workflow node for Open WebUI
{
  "name": "OpenWebUI Chat",
  "type": "n8n-nodes-base.httpRequest",
  "parameters": {
    "url": "http://open-webui:3000/api/chat/completions",
    "method": "POST",
    "body": {
      "model": "llama3",
      "messages": "={{$json.messages}}",
      "stream": false
    },
    "headers": {
      "Authorization": "Bearer {{$credentials.openWebuiApi.token}}"
    }
  }
}
```

#### With Flowise
```yaml
# Flowise configuration for Open WebUI
- name: OpenWebUI LLM
  type: ChatOpenAI
  config:
    baseURL: http://open-webui:3000/v1
    apiKey: your-token
    modelName: llama3
    temperature: 0.7
    streaming: true
```

## Monitoring and Logging

### Health Check
```bash
# Check service health
curl http://localhost:3000/health

# Monitor logs
docker logs -f open-webui

# Performance metrics
curl http://localhost:3000/api/metrics
```

### Database Management
```python
# Open WebUI uses SQLite by default
# Database location: /app/backend/data/webui.db

# Custom database configuration
WEBUI_DATABASE_URL=postgresql://user:pass@localhost/openwebui
WEBUI_DATABASE_URL=mysql://user:pass@localhost/openwebui
```

## Use Cases
- **Team Collaboration**: Shared AI workspace for teams
- **Document Analysis**: RAG-powered document Q&A
- **Multi-model Testing**: Compare different LLMs easily
- **Custom AI Agents**: Build specialized AI assistants
- **Enterprise Deployment**: Self-hosted AI with user management
- **Research Platform**: Experiment with different models and settings

## Advantages
- **Feature Rich**: Comprehensive set of AI tools
- **Self-hosted**: Complete control over data and models
- **Multi-backend**: Support for various LLM providers
- **Extensible**: Plugin system and customizations
- **User-friendly**: Intuitive web interface
- **Community**: Active development and support

## Requirements
- **Docker**: Recommended deployment method
- **Memory**: 4GB+ RAM for basic usage
- **Storage**: 10GB+ for models and data
- **Browser**: Modern web browser
- **Backend**: Ollama or OpenAI-compatible API

Back to [[models]]