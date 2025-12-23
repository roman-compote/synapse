
**File:** `llm_engineering-basics.ipynb`

## Overview
Introductory notebook covering the fundamentals of LLM engineering, including connecting to multiple LLM providers and building practical applications.

## Key Content

### LLM Connections
- **OpenAI GPT models** - Primary integration with GPT-4o-mini
- **Claude (Anthropic)** - Claude Sonnet 4 integration
- **Google Gemini** - Both native API and OpenAI-compatible endpoints
- **Local models** - Ollama integration for running open source models (Llama 3.2, DeepSeek-R1)

### Projects

#### 1. Web Summarizer
A web browser replacement that provides intelligent summaries:
- **Website class** - BeautifulSoup-based web scraping
- **Prompt engineering** - System/user prompt structure
- **Content processing** - Clean text extraction and formatting
- **Summary generation** - Markdown-formatted website summaries

#### 2. Company Brochure Generator
Automated business brochure creation system:
- **Link analysis** - GPT-powered relevant link identification
- **Multi-page scraping** - Comprehensive company information gathering
- **Structured output** - JSON-formatted link categorization
- **Content synthesis** - Company culture, customer, and career information
- **Streaming responses** - Real-time content generation

### Technical Patterns
- **Message structure** - Standard OpenAI chat completion format
- **Streaming interfaces** - Real-time response updates

### Advanced Features
- **Multi-model conversations** - GPT vs Claude adversarial chatbot interactions
- **Conversation memory** - Multi-turn dialogue management
- **Custom tone control** - Humorous vs professional output variations

## Learning Outcomes
- LLM API integration across multiple providers
- Prompt engineering best practices
- Web scraping and content processing
- Structured output generation
- Real-world application development patterns

## Technologies
- Python, OpenAI API, Anthropic API, Google Generative AI
- BeautifulSoup, requests, dotenv, IPython
- Jupyter notebooks, JSON processing