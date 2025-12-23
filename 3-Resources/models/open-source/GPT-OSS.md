---
tags:
  - open-source
  - openai
  - reasoning
  - mixture-of-experts
---

# GPT-OSS

OpenAI's first open-weight reasoning model family released in 2025, marking their return to open-source AI after GPT-2. Available in two variants: GPT-OSS-120b and GPT-OSS-20b.

## Key Features
- **Open Weight**: Apache 2.0 license for commercial deployment
- **Reasoning Models**: Chain-of-thought with adjustable reasoning effort levels
- **Mixture of Experts**: Efficient MoE architecture reducing active parameters
- **Agentic Capabilities**: Native function calling, web browsing, code execution
- **Context Window**: Up to 128,000 tokens with RoPE encoding
- **Training Cutoff**: 2025 training data

## Model Variants

### GPT-OSS-120b
- **Parameters**: 117B total, 5.1B active per token
- **Architecture**: 36 layers, 128 experts per layer (4 active)
- **Hardware**: Single 80GB GPU (H100, MI300X)
- **Performance**: Comparable to o4-mini on benchmarks

### GPT-OSS-20b
- **Parameters**: 21B total, 3.6B active
- **Memory**: Runs within 16GB RAM
- **Target**: Consumer hardware deployment
- **Efficiency**: Optimized for edge deployment

## Capabilities
- Chain-of-thought reasoning with configurable effort levels
- Function calling and structured outputs
- Web browsing with chained tool calls
- Python code execution
- STEM and coding focused knowledge
- Instruction following and tool use

## Technical Architecture
- **Attention**: Alternating dense and locally banded sparse patterns
- **MQA**: Grouped multi-query attention (group size 8)
- **Quantization**: MXFP4 quantization for memory efficiency
- **Positional Encoding**: Rotary Positional Embedding (RoPE)
- **Response Format**: Harmony response format required

## Use Cases
- Research and development with full model access
- Commercial deployment without licensing restrictions
- Agentic applications with tool use
- Edge deployment on consumer hardware
- Fine-tuning for specialized tasks
- Educational and academic research

## Deployment Options
- Azure AI Model Catalog for real-time inference
- Self-hosting with transformers, vLLM, llama.cpp
- Ollama for local deployment
- Dell Enterprise Hub for on-premise
- Custom deployment with Apache 2.0 license

## Safety and Training
- CBRN harmful content filtered during pre-training
- Safety tested for biological, chemical, cyber domains
- Trained on mostly English, text-only dataset
- Focus on STEM, coding, and general knowledge
- Constitutional AI principles applied

## Performance
- Reasoning capability comparable to o4-mini
- Efficient inference through MoE architecture
- Native tool use and function calling
- Strong performance on coding and STEM tasks
- Customizable through parameter fine-tuning

Back to [[models]]