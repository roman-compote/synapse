---
tags:
  - "#overview"
---
# [[models]]
- **Open-source models**: Freely available LLMs (e.g., LLaMA, Mistral) that you can host, customize, and fine-tune yourself; great for control, transparency, and compliance.
- **Closed-source models**: Proprietary offerings (e.g., GPT-4, Claude) that are accessed via APIs; they usually provide cutting-edge performance but limited customization.
- **Multimodal models**: Handle multiple input/output types (text, images, audio, video), enabling richer interactions beyond pure text.
- **Model selection**: Choosing the right LLM depends on task requirements (accuracy, cost, latency, compliance, data privacy, modality support).

# [[tools]]
- **External connectors**: Tools let LLMs call APIs, databases, or custom functions to fetch up-to-date or specialized knowledge.
- **Action execution**: Beyond text generation, models can trigger workflows (e.g., booking a meeting, sending an email, running code).
- **Extended reasoning**: Tools allow models to perform complex calculations or structured queries they can’t natively handle.
- **Augmented outputs**: Combining tools with the model enables richer, more accurate, and domain-specific responses.

# [[techniques]]
- **APIs**: Interfaces to connect LLMs with software systems, external services, or data sources.
- **Multi-shot prompting**: Providing several examples in the prompt to guide the model toward consistent responses.
- **Retrieval-Augmented Generation (RAG)**: Supplying relevant external documents to the model at query time, improving factual accuracy.
- **Agents (Agentisation)**: Architectures where LLMs plan, decide, and call tools iteratively to achieve multi-step goals.
- **Fine-tuning**: Training the base model on domain-specific data to specialize it for tasks (customer support, legal, medical).

# Exercises

## Core LLM Engineering
1. **[[LLM Engineering - Basics]]** - Introduction to LLM integration with multiple providers, web scraping, and automated content generation. Build web summarizers and company brochure generators.

2. **[[LLM Engineering - Gradio]]** - Create conversational AI interfaces using Gradio with advanced prompt engineering techniques. Develop context-aware chatbots for business applications.

3. **[[LLM Engineering - Tools]]** - Multi-modal airline assistant integrating function calling, DALL-E image generation, and text-to-speech. Demonstrates agent-based architecture with tool orchestration.

4. **[[LLM Engineering - Code Generation]]** - High-performance code optimization using frontier LLMs to convert Python to C++ with significant speedups. Compare GPT vs Claude optimization strategies.

## Advanced Topics  
5. **[[LLM Engineering - RAG]]** - Enterprise-grade RAG system for insurance company knowledge base with vector embeddings and conversational memory. Focus on accuracy and cost optimization.

## Agent Frameworks
6. **[[Agents - OpenAI SDK]]** - Multi-agent research system using OpenAI's native SDK with web search, structured outputs, and automated email reporting. Demonstrates production agentic workflows.

7. **[[Agents - LangGraph]]** - State-based agent architecture with persistent memory management, tool integration, and complex workflow orchestration. Covers checkpointing and database persistence.