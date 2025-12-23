---
tags:
  - local-deployment
  - web-interface
  - customization
  - gradio
---

# Text-generation-webui

Comprehensive web interface for running text generation models locally. Built on Gradio, offering extensive customization options and support for various model formats and fine-tuning capabilities.

## Key Features
- **Multiple Model Formats**: GGUF, AWQ, GPTQ, EXL2, and more
- **Extensive Customization**: Advanced parameter control
- **Fine-tuning Support**: LoRA and QLoRA training
- **Extensions**: Plugin system for additional functionality
- **API Server**: OpenAI-compatible API
- **Character/Instruction Modes**: Different interaction modes

## Installation

### Quick Start (Windows/Linux)
```bash
# Clone the repository
git clone https://github.com/oobabooga/text-generation-webui.git
cd text-generation-webui

# Run the start script
./start_linux.sh    # Linux
./start_windows.bat  # Windows
./start_macos.sh     # macOS
```

### Manual Installation
```bash
# Create conda environment
conda create -n textgen python=3.11
conda activate textgen

# Install requirements
pip install -r requirements.txt

# Install PyTorch (example for CUDA 12.1)
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# Run the web UI
python server.py
```

### Docker Installation
```bash
# CPU version
docker run -d -p 7860:7860 \
  -v text-gen-models:/app/models \
  -v text-gen-characters:/app/characters \
  -v text-gen-presets:/app/presets \
  --name textgen \
  atinoda/text-generation-webui

# GPU version
docker run -d --gpus all \
  -p 7860:7860 \
  -v text-gen-models:/app/models \
  --name textgen \
  atinoda/text-generation-webui:latest-cuda
```

### Docker Compose
```yaml
version: '3.8'
services:
  text-generation-webui:
    image: atinoda/text-generation-webui:latest-cuda
    ports:
      - "7860:7860"
    volumes:
      - ./models:/app/models
      - ./characters:/app/characters
      - ./presets:/app/presets
      - ./loras:/app/loras
      - ./training:/app/training
    environment:
      - CLI_ARGS=--model-dir /app/models --listen --api
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]
```

## Model Management

### Downloading Models
```bash
# Using the web interface
1. Navigate to "Model" tab
2. Enter model name (e.g., "microsoft/DialoGPT-medium")
3. Click "Download"

# Using command line
python download-model.py organization/model

# Examples:
python download-model.py huggingface-hub/CodeBERTa-small-v1
python download-model.py TheBloke/Llama-2-7B-Chat-GGML
```

### Model Loading
```python
# Command line arguments for loading models
python server.py \
  --model TheBloke_Llama-2-7B-Chat-GGML \
  --loader llamacpp \
  --n-gpu-layers 35

# Different loaders:
# --loader transformers    # For regular Hugging Face models
# --loader llamacpp        # For GGUF models
# --loader exllamav2       # For EXL2 models
# --loader autogptq        # For GPTQ models
```

### Model Configuration
```yaml
# models/config.yaml
TheBloke_Llama-2-7B-Chat-GGML:
  loader: llamacpp
  n_ctx: 4096
  n_gpu_layers: 35
  n_threads: 8
  temperature: 0.7
  top_p: 0.9
  repetition_penalty: 1.15
```

## Usage Examples

### Basic Chat Interface
```python
# Access via web browser at http://localhost:7860
# 1. Load a model in the "Model" tab
# 2. Navigate to "Chat" tab
# 3. Select character/instruction mode
# 4. Start chatting

# Chat modes:
# - Chat: Regular conversation
# - Instruct: Instruction following
# - Chat-instruct: Hybrid mode
```

### API Usage
```bash
# Start with API enabled
python server.py --api --listen

# OpenAI-compatible endpoint
curl http://localhost:5000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gpt-3.5-turbo",
    "messages": [
      {"role": "user", "content": "Hello!"}
    ]
  }'
```

### Python API Client
```python
import requests
import json

# Text generation endpoint
def generate_text(prompt, max_tokens=100):
    url = "http://localhost:5000/api/v1/generate"

    data = {
        "prompt": prompt,
        "max_new_tokens": max_tokens,
        "temperature": 0.7,
        "top_p": 0.9,
        "do_sample": True,
        "stopping_strings": ["\n\n"]
    }

    response = requests.post(url, json=data)
    return response.json()["results"][0]["text"]

# Chat completion
def chat_completion(messages, model=""):
    url = "http://localhost:5000/v1/chat/completions"

    data = {
        "model": model,
        "messages": messages,
        "temperature": 0.7,
        "max_tokens": 500
    }

    response = requests.post(url, json=data)
    return response.json()["choices"][0]["message"]["content"]

# Examples
result = generate_text("The future of AI is")
print(result)

messages = [
    {"role": "system", "content": "You are a helpful assistant."},
    {"role": "user", "content": "Explain machine learning"}
]
response = chat_completion(messages)
print(response)
```

## Advanced Features

### Character Creation
```yaml
# characters/example_character.yaml
name: "Helpful Assistant"
context: "You are a knowledgeable and helpful AI assistant. You provide accurate, detailed information and help users with various tasks."
greeting: "Hello! I'm here to help you with any questions or tasks you have. What can I assist you with today?"
example_dialogue: |
  You: What is machine learning?
  Assistant: Machine learning is a subset of artificial intelligence (AI) that focuses on creating systems that can learn and improve from data without being explicitly programmed for every task.

# Character parameters
turn_template: "<|user|>\n<|user-message|>\n<|bot|>\n<|bot-message|>\n"
context_length: 4096
max_new_tokens: 500
temperature: 0.7
top_p: 0.9
```

### Custom Presets
```json
{
  "presets/creative_writing.json": {
    "temperature": 0.9,
    "top_p": 0.95,
    "repetition_penalty": 1.05,
    "top_k": 40,
    "do_sample": true,
    "max_new_tokens": 1000,
    "pad_token_id": 0,
    "bos_token_id": 1,
    "eos_token_id": 2
  }
}
```

### LoRA Training
```bash
# Training setup
python training/train_lora.py \
  --model-name "TheBloke/Llama-2-7B-Chat-GGML" \
  --dataset "training/datasets/my_dataset.json" \
  --lora-rank 16 \
  --lora-alpha 32 \
  --learning-rate 3e-4 \
  --epochs 3

# Dataset format (JSON)
[
  {
    "instruction": "What is the capital of France?",
    "input": "",
    "output": "The capital of France is Paris."
  },
  {
    "instruction": "Explain photosynthesis",
    "input": "",
    "output": "Photosynthesis is the process by which plants convert sunlight into energy..."
  }
]
```

### Extensions System
```python
# extensions/custom_extension/script.py
import gradio as gr

def custom_function():
    return "Custom extension working!"

def ui():
    with gr.Row():
        with gr.Column():
            button = gr.Button("Test Extension")
            output = gr.Textbox()

    button.click(custom_function, outputs=output)

# Install extension by placing in extensions/ folder
# Enable in web interface under "Extensions" tab
```

## Configuration Examples

### Launch Arguments
```bash
# Common configurations
python server.py \
  --model TheBloke_Llama-2-7B-Chat-GGML \
  --loader llamacpp \
  --n-gpu-layers 35 \
  --n_ctx 4096 \
  --listen \
  --api \
  --extensions openai \
  --verbose

# Memory optimization
python server.py \
  --model large-model \
  --load-in-8bit \
  --cpu-memory 16 \
  --gpu-memory 8 6 \
  --auto-devices
```

### Settings File
```yaml
# settings.yaml
default_settings:
  temperature: 0.7
  top_p: 0.9
  top_k: 40
  repetition_penalty: 1.15
  max_new_tokens: 512
  do_sample: true

ui_settings:
  default_extensions: ['openai', 'character_bias']
  chat_generation_attempts: 1
  default_character: "Assistant"

model_settings:
  auto_load_model: true
  default_model: "TheBloke_Llama-2-7B-Chat-GGML"
  model_dir: "./models"
```

## Integration Examples

### LangChain Integration
```python
from langchain.llms import TextGen

# Initialize TextGen LLM
llm = TextGen(
    model_url="http://localhost:5000",
    temperature=0.7,
    max_new_tokens=500
)

# Use with LangChain
from langchain.chains import LLMChain
from langchain.prompts import PromptTemplate

prompt = PromptTemplate(
    input_variables=["question"],
    template="Answer the following question: {question}"
)

chain = LLMChain(llm=llm, prompt=prompt)
result = chain.run("What is quantum computing?")
print(result)
```

### Custom Web Interface
```python
import gradio as gr
import requests

def custom_chat(message, history):
    # Call text-generation-webui API
    response = requests.post(
        "http://localhost:5000/api/v1/generate",
        json={
            "prompt": message,
            "max_new_tokens": 300,
            "temperature": 0.7
        }
    )

    bot_response = response.json()["results"][0]["text"]
    history.append([message, bot_response])
    return history, ""

# Create custom interface
with gr.Blocks() as demo:
    chatbot = gr.Chatbot()
    msg = gr.Textbox()
    clear = gr.Button("Clear")

    msg.submit(custom_chat, [msg, chatbot], [chatbot, msg])
    clear.click(lambda: None, None, chatbot, queue=False)

demo.launch()
```

## Performance Optimization

### GPU Configuration
```bash
# Multiple GPU setup
python server.py \
  --model large-model \
  --gpu-memory 10 8 6 4 \
  --auto-devices

# CPU offloading
python server.py \
  --model large-model \
  --cpu-memory 16 \
  --compress-pos-emb 2
```

### Memory Management
```yaml
Optimization Strategies:
  - Use quantized models (GGUF, GPTQ)
  - Enable CPU offloading for large models
  - Adjust context length based on needs
  - Use appropriate batch size
  - Enable memory mapping for efficiency
```

## Use Cases
- **Research**: Experiment with different models and parameters
- **Fine-tuning**: Train custom models with LoRA
- **Character Roleplay**: Create and interact with custom characters
- **API Development**: Self-hosted LLM API for applications
- **Content Generation**: Writing, storytelling, and creative tasks
- **Model Comparison**: Test multiple models side-by-side

## Advantages
- **Highly Customizable**: Extensive parameter control
- **Multiple Formats**: Support for various model types
- **Training Capabilities**: Built-in LoRA training
- **Active Community**: Regular updates and extensions
- **Flexible API**: Multiple API endpoints
- **Free and Open Source**: No usage restrictions

## Requirements
- **Python**: 3.8+ (3.11 recommended)
- **Memory**: 8GB+ RAM (varies by model)
- **GPU**: CUDA-compatible for acceleration
- **Storage**: 10GB+ for models
- **Browser**: For web interface access

Back to [[models]]