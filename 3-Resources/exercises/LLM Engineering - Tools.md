
**File:** `llm_engineering-tools.ipynb`

## Overview
Advanced project building a multi-modal airline AI assistant with function calling capabilities, demonstrating tools integration, image generation, and audio synthesis.

## Key Content

### Airline AI Assistant Core
- **Customer support chatbot** - FlightAI airline assistant
- **Concise responses** - Business-appropriate communication style
- **Accuracy focus** - "If you don't know, say so" principle

### Function Calling (Tools)

#### Ticket Price Tool
- **Function definition** - Structured tool description for OpenAI
- **Parameter schema** - JSON schema for function parameters
- **Tool execution** - Handle tool calls and responses
- **Business logic** - Ticket price lookup for major cities

```python
price_function = {
    "name": "get_ticket_price",
    "description": "Get the price of a return ticket to the destination city",
    "parameters": {
        "type": "object",
        "properties": {
            "destination_city": {"type": "string", "description": "The city that the customer wants to travel to"}
        }
    }
}
```

### Multi-Modal Capabilities

#### Image Generation (DALL-E-3)
- **Travel imagery** - Destination-specific vacation images
- **Prompt engineering** - "vibrant pop-art style" tourist spots
- **Base64 handling** - Image data processing and display
- **Cost awareness** - ~4 cents per image generation

#### Audio Synthesis (TTS)
- **Text-to-speech** - OpenAI's speech model integration
- **Voice selection** - "onyx" and "alloy" voice options
- **Audio playback** - pydub and PyAudio integration
- **FFmpeg dependencies** - Cross-platform audio processing

### Agent Framework Architecture
- **Tool orchestration** - Automatic tool calling based on user queries
- **Multi-step responses** - Price lookup → image generation → audio response
- **Error handling** - Graceful fallback for tool failures
- **User experience** - Integrated visual and audio feedback

### Advanced Gradio Implementation
- **Custom blocks** - Beyond simple ChatInterface
- **Multi-output handling** - Text, image, and audio simultaneously
- **Interactive components** - Dynamic UI updates
- **Real-time processing** - Live tool execution feedback

## Technical Patterns

### Tool Call Flow
1. **User query** - "How much is a ticket to London?"
2. **Tool detection** - OpenAI identifies need for get_ticket_price
3. **Function execution** - Python function called with extracted parameters
4. **Response synthesis** - Tool result integrated into conversational response
5. **Multi-modal output** - Text + destination image + audio response

### Agentic AI Concepts
- **Task specialization** - Different agents for different capabilities
- **Tool autonomy** - LLM decides when and how to use tools
- **Agent collaboration** - Multiple specialized functions working together
- **Environmental interaction** - Agents affecting real-world systems

## Key Learning Outcomes
- Function calling implementation and debugging
- Multi-modal AI application development
- Business-focused chatbot design
- Agent-based architecture patterns
- Cross-platform audio/image processing

## Technologies
- OpenAI GPT-4o-mini, DALL-E-3, TTS-1
- Gradio advanced blocks, PIL (Python Imaging Library)
- pydub, PyAudio, FFmpeg, Base64 encoding
- JSON schema validation, function calling protocols