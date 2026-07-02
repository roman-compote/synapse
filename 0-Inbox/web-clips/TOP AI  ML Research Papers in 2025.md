---
title: "TOP AI / ML Research Papers in 2025"
source: "https://thecode-research-papers.lovable.app/?utm_source=codenewsletter.ai&utm_medium=newsletter&utm_campaign=your-200-engineering-resources-ultimate-claude-code-guide"
author:
  - "[[The Code]]"
published:
created: 2025-12-29
description: "Curating the most impactful AI and ML research publications in one place"
tags:
  - "clippings"
---
## Latest Research

### Why Language Models Hallucinate

OpenAI Research Team • Georgia Tech

Machine Learning

2025

A comprehensive statistical framework for understanding why large language models (LLMs) produce hallucinations - plausible but incorrect statements presented with confidence. The paper addresses fundamental questions about why hallucinations originate during pretraining and persist after post-training, establishing that generating valid outputs is inherently harder than classifying output validity.

#### Key Findings:

- Hallucinations are statistically inevitable given current training methods
- Binary evaluation methods actively encourage hallucination behavior
- Simple modifications to evaluations could significantly reduce hallucination incentives

[Read Full Paper](https://arxiv.org/abs/2509.04664)

### Small Language Models are the Future of Agentic AI

NVIDIA Research

AI Systems

2025

This position paper argues that small language models (SLMs), not large language models (LLMs), represent the future of agentic AI systems. SLMs are defined as models that can run on consumer devices with practical inference latency (typically <10B parameters), offering sufficient power for most agentic tasks while being more operationally suitable and economical.

#### Key Findings:

- Microsoft Phi-2 (2.7B) matches 30B models while running 15× faster
- Inference costs are 10-30× cheaper than LLMs in latency, energy, and computation
- Most agent invocations involve narrow, repetitive tasks suitable for SLMs

[Read Full Paper](https://arxiv.org/abs/2506.02153)

### REFRAG: Rethinking RAG based Decoding

Research Team

Information Retrieval

2025

REFRAG introduces a novel decoding framework specifically optimized for Retrieval-Augmented Generation (RAG) applications. The key insight is that RAG contexts exhibit unique characteristics - particularly sparse, block-diagonal attention patterns between different retrieved passages - that standard LLM inference doesn't exploit.

#### Key Findings:

- 30.85× faster time-to-first-token (TTFT) with k=32 compression
- Enables 16× longer context windows for LLMs
- 9.3% perplexity improvement over previous state-of-the-art

[Read Full Paper](https://arxiv.org/abs/2509.01092)

### ParaThinker: Native Parallel Thinking as a New Paradigm to Scale LLM Test-time Compute

Research Team

Machine Learning

2025

ParaThinker introduces a paradigm shift from scaling compute sequentially (depth) to scaling it in parallel (width). Instead of generating one long chain of thought, the model generates multiple diverse reasoning paths simultaneously and synthesizes them into a superior final answer, addressing the 'Tunnel Vision' problem in current LLMs.

#### Key Findings:

- 12.3% average improvement over sequential baseline for 1.5B model
- Only 7.1% latency overhead for parallel generation
- Achieves 48.1% accuracy on AIME 2024 with 8 paths vs 27.4% for sequential

[Read Full Paper](https://arxiv.org/abs/2509.04475)

### Virtual Agent Economies

Google DeepMind

AI Economics

2025

This paper presents a framework for understanding and designing economic systems where autonomous AI agents transact and coordinate at unprecedented scales and speeds. The authors introduce the 'sandbox economy' framework and explore scenarios for scientific research acceleration, robotics coordination, and personal assistant networks.

#### Key Findings:

- Market-based coordination enables transparent reward distribution across multi-agent collaborations
- High-frequency agent interactions potentially cause rapid market collapses (flash crashes)
- Hybrid oversight combining AI monitoring with human review is essential

[Read Full Paper](https://arxiv.org/abs/2509.10147)

### SFR-DeepResearch: Towards Effective Reinforcement Learning for Autonomously Reasoning Single Agents

Salesforce AI Research

Reinforcement Learning

2025

This paper presents a framework for training autonomous single-agent AI systems for Deep Research (DR) tasks using reinforcement learning on reasoning-optimized language models. Rather than starting from scratch, they apply continual reinforcement learning to already-optimized 'thinking' models to enhance agentic capabilities while preserving reasoning abilities.

#### Key Findings:

- 28.7% on Humanity's Last Exam (65% relative improvement over base model)
- Single-turn reformulation provides 10% absolute improvement on FRAMES
- Length normalization crucial for stable training and preventing repetitive tool calls

[Read Full Paper](https://arxiv.org/abs/2509.06283)

### rStar2-Agent

Microsoft Research

Mathematical Reasoning

2025

Microsoft Research introduces rStar2-Agent, a 14B parameter math reasoning model that achieves frontier-level performance comparable to much larger models through agentic reinforcement learning with Python coding tools. The key innovation is 'thinking smarter, not just longer' by actively using tools to verify intermediate steps.

[Read Full Paper](https://www.arxiv.org/abs/2508.20722)

### Adaptive LLM Routing under Budget Constraints

Research Team

ML Systems

2025

This paper addresses how to dynamically select the most appropriate LLM for each query while staying within cost constraints. The authors reformulate LLM routing as a contextual bandit problem rather than supervised learning, introducing PILOT (Preference-prior Informed LinUCB fOr Adaptive RouTing).

#### Key Findings:

- 93% of GPT-4's performance at 25% of its cost on multi-task scenarios
- Successfully adapts to distribution shifts (e.g., MMLU to GSM8K transition)
- Routing time is 10-38× faster than GPT-4 inference

[Read Full Paper](https://arxiv.org/abs/2508.21141)

### Implicit Reasoning in Large Language Models: A Comprehensive Survey

Research Team

Machine Learning

2025

This comprehensive survey examines implicit reasoning in Large Language Models (LLMs), where reasoning occurs internally without producing explicit step-by-step outputs, contrasting with traditional chain-of-thought approaches. The paper provides the first comprehensive taxonomy of implicit reasoning methods.

#### Key Findings:

- Three main paradigms: Latent Optimization, Signal-Guided Control, and Layer-Recurrent Execution
- Linear projections from intermediate layers can approximate final outputs
- Current methods still underperform explicit approaches on complex tasks

[Read Full Paper](https://arxiv.org/abs/2509.02350)

### Defeating Nondeterminism in LLM Inference

Thinking Machines

ML Engineering

2025

This technical work addresses a critical but often overlooked challenge in deploying Large Language Models in production: achieving deterministic (reproducible) outputs. The paper identifies root causes of non-determinism and provides practical solutions for different use cases.

#### Key Findings:

- Deterministic operations are often 10-30% slower but enable reliable testing
- Multiple sources: floating-point variations, parallel computation, random sampling
- Tiered approach based on use case criticality (high-stakes vs creative applications)

[Read Full Paper](https://thinkingmachines.ai/blog/defeating-nondeterminism-in-llm-inference/)

[Edit with](https://lovable.dev/projects/9b226438-7c31-4093-a85d-65ce38917cdd?utm_source=lovable-badge)