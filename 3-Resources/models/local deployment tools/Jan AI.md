---
tags:
  - local-deployment
  - desktop-app
  - cross-platform
  - user-friendly
---

# Jan AI

Polished cross-platform desktop application for running local AI models. Offers intuitive GUI experience across Windows, macOS, and Linux with easy model management and chat capabilities.

## Key Features
- **Cross-platform**: Windows, macOS, Linux support
- **Intuitive Interface**: Clean, modern desktop GUI
- **Local Privacy**: All processing happens on your device
- **Model Management**: Easy model downloading and switching
- **Chat Interface**: Built-in conversation interface
- **API Server**: Local OpenAI-compatible API

## Installation

### Download and Install
```bash
# Visit jan.ai and download for your platform
# Or use package managers:

# macOS (Homebrew)
brew install --cask jan

# Windows (Chocolatey)
choco install jan

# Linux (Snap)
sudo snap install jan

# AppImage (Linux)
wget https://github.com/janhq/jan/releases/latest/download/jan-linux-x86_64.appimage
chmod +x jan-linux-x86_64.appimage
./jan-linux-x86_64.appimage
```

### System Requirements
- **OS**: Windows 10+, macOS 10.15+, Ubuntu 18.04+
- **RAM**: 8GB minimum, 16GB recommended
- **Storage**: 10GB+ free space for models
- **GPU**: Optional (CUDA/Metal acceleration supported)

## Getting Started

### First Launch
```
1. Open Jan application
2. Complete initial setup wizard
3. Choose model directory location
4. Configure hardware preferences (CPU/GPU)
5. Download your first model
```

### Model Management
```bash
# Models are managed through the GUI:
1. Navigate to "Hub" section
2. Browse available models
3. Click "Download" on desired model
4. Monitor download progress
5. Switch between downloaded models

# Popular starter models:
- Llama 3 8B: Good general purpose
- Mistral 7B: Efficient and fast
- Phi-3 Mini: Compact but capable
- TinyLlama: Very small, good for testing
```

## Configuration

### Settings and Preferences
```yaml
# Settings accessible via GUI:
Model Settings:
  - Model directory location
  - Default model selection
  - Context length limits
  - Temperature and sampling parameters

Hardware Settings:
  - GPU acceleration enable/disable
  - Memory allocation limits
  - CPU thread count
  - GPU layer distribution

Interface Settings:
  - Theme (light/dark)
  - Font size and family
  - Chat history retention
  - Notification preferences
```

### Model Configuration
```json
// Jan stores model configs in JSON format
{
  "sources": [
    {
      "filename": "llama-3-8b-instruct.gguf",
      "url": "https://huggingface.co/..."
    }
  ],
  "id": "llama3-8b",
  "name": "Llama 3 8B",
  "description": "Meta's Llama 3 8B model optimized for instruction following",
  "format": "gguf",
  "settings": {
    "ctx_len": 4096,
    "ngl": 32,
    "embedding": true,
    "n_parallel": 1
  },
  "parameters": {
    "temperature": 0.7,
    "top_p": 0.9,
    "stream": true,
    "max_tokens": 1024,
    "frequency_penalty": 0,
    "presence_penalty": 0
  }
}
```

## Usage Examples

### Chat Interface
```
# Basic chat usage:
1. Select model from dropdown
2. Adjust parameters if needed (temperature, max tokens)
3. Type message in chat input
4. Press Enter or click Send
5. View streaming response

# Advanced chat features:
- Message editing and regeneration
- Conversation branching
- Export chat history
- Custom system prompts
```

### API Server
```bash
# Enable API server in settings
# Default endpoint: http://localhost:1337

# Test API connectivity
curl http://localhost:1337/v1/models

# Chat completions
curl http://localhost:1337/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "llama3-8b",
    "messages": [
      {"role": "user", "content": "Hello!"}
    ]
  }'
```

### Python Integration
```python
from openai import OpenAI

# Initialize client
client = OpenAI(
    base_url="http://localhost:1337/v1",
    api_key="jan"  # Jan doesn't require real API key
)

def chat_with_jan(message, model="llama3-8b"):
    response = client.chat.completions.create(
        model=model,
        messages=[
            {"role": "user", "content": message}
        ],
        temperature=0.7,
        max_tokens=500
    )

    return response.choices[0].message.content

# Usage
response = chat_with_jan("Explain quantum computing")
print(response)
```

### Streaming Responses
```python
import requests
import json

def stream_chat(message, model="llama3-8b"):
    url = "http://localhost:1337/v1/chat/completions"

    data = {
        "model": model,
        "messages": [{"role": "user", "content": message}],
        "stream": True,
        "temperature": 0.7
    }

    with requests.post(url, json=data, stream=True) as response:
        for line in response.iter_lines():
            if line:
                try:
                    # Parse SSE format
                    json_str = line.decode('utf-8').replace('data: ', '')
                    if json_str != '[DONE]':
                        chunk = json.loads(json_str)
                        content = chunk['choices'][0]['delta'].get('content', '')
                        if content:
                            print(content, end='', flush=True)
                except json.JSONDecodeError:
                    continue

# Usage
stream_chat("Write a short story about AI")
```

## Advanced Features

### Custom System Prompts
```python
# Configure system prompts via GUI or API
system_prompts = {
    "helpful_assistant": "You are a helpful, harmless, and honest AI assistant.",
    "creative_writer": "You are a creative writing assistant specializing in storytelling and narrative development.",
    "code_helper": "You are an expert programmer who helps with coding questions and debugging.",
    "tutor": "You are a patient tutor who explains complex topics in simple terms."
}

# Use in API calls
def chat_with_system_prompt(message, system_prompt, model="llama3-8b"):
    response = client.chat.completions.create(
        model=model,
        messages=[
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": message}
        ]
    )
    return response.choices[0].message.content
```

### Model Switching
```python
# List available models
def list_models():
    response = client.models.list()
    return [model.id for model in response.data]

# Switch models dynamically
available_models = list_models()
print("Available models:", available_models)

# Use different models for different tasks
def multi_model_chat(message):
    responses = {}

    for model in ["llama3-8b", "mistral-7b", "phi3-mini"]:
        try:
            response = chat_with_jan(message, model)
            responses[model] = response
        except Exception as e:
            responses[model] = f"Error: {e}"

    return responses
```

## Integration Examples

### LangChain Integration
```python
from langchain_openai import ChatOpenAI
from langchain.schema import HumanMessage

# Initialize with Jan's API
llm = ChatOpenAI(
    openai_api_base="http://localhost:1337/v1",
    openai_api_key="jan",
    model_name="llama3-8b",
    temperature=0.7
)

# Use with LangChain
messages = [HumanMessage(content="What is machine learning?")]
response = llm(messages)
print(response.content)
```

### Gradio Interface
```python
import gradio as gr
from openai import OpenAI

client = OpenAI(
    base_url="http://localhost:1337/v1",
    api_key="jan"
)

def chat_interface(message, history):
    # Build conversation context
    messages = []
    for human, assistant in history:
        messages.append({"role": "user", "content": human})
        messages.append({"role": "assistant", "content": assistant})
    messages.append({"role": "user", "content": message})

    # Get response from Jan
    response = client.chat.completions.create(
        model="llama3-8b",
        messages=messages,
        temperature=0.7
    )

    return response.choices[0].message.content

# Create Gradio interface
demo = gr.ChatInterface(
    chat_interface,
    title="Jan AI Chat",
    description="Chat with local AI models via Jan"
)

demo.launch()
```

### Batch Processing
```python
import asyncio
import aiohttp

async def batch_process(prompts, model="llama3-8b"):
    async with aiohttp.ClientSession() as session:
        tasks = []

        for prompt in prompts:
            task = process_single_prompt(session, prompt, model)
            tasks.append(task)

        responses = await asyncio.gather(*tasks)
        return responses

async def process_single_prompt(session, prompt, model):
    url = "http://localhost:1337/v1/chat/completions"
    data = {
        "model": model,
        "messages": [{"role": "user", "content": prompt}],
        "temperature": 0.7
    }

    async with session.post(url, json=data) as response:
        result = await response.json()
        return result['choices'][0]['message']['content']

# Usage
prompts = [
    "What is Python?",
    "Explain machine learning",
    "What is blockchain?",
    "Describe quantum computing"
]

responses = asyncio.run(batch_process(prompts))
for i, response in enumerate(responses):
    print(f"Prompt {i+1}: {response}")
```

## Troubleshooting

### Common Issues
```yaml
Model Loading Problems:
  - Check available disk space
  - Verify model file integrity
  - Restart Jan application
  - Clear model cache

Performance Issues:
  - Enable GPU acceleration
  - Reduce context length
  - Lower quality settings temporarily
  - Close other applications

API Connection Issues:
  - Verify API server is enabled
  - Check firewall settings
  - Confirm correct port (1337)
  - Restart Jan application
```

### Performance Tips
```yaml
Optimization Strategies:
  - Use GPU acceleration when available
  - Select appropriate model size for hardware
  - Adjust context length based on needs
  - Monitor memory usage
  - Use quantized models for better performance

Hardware Recommendations:
  - 16GB+ RAM for 7B models
  - 32GB+ RAM for 13B models
  - NVIDIA GPU with 8GB+ VRAM
  - SSD storage for faster model loading
```

## Use Cases
- **Personal Assistant**: Private, local AI companion
- **Content Creation**: Writing and brainstorming assistance
- **Learning and Education**: AI tutor for various subjects
- **Code Development**: Programming help and debugging
- **Research**: Analyze and process documents locally
- **Experimentation**: Try different models easily

## Advantages
- **User-Friendly**: No technical setup required
- **Privacy-Focused**: All data stays local
- **Cross-Platform**: Works on all major operating systems
- **Model Flexibility**: Easy switching between models
- **API Compatible**: Works with existing OpenAI code
- **Free**: No subscription or usage fees

## Limitations
- **Hardware Dependent**: Performance varies with specs
- **Model Selection**: Limited to compatible formats
- **Advanced Features**: Fewer customization options than CLI tools
- **Update Frequency**: Slower feature additions than web-based tools

Back to [[models]]