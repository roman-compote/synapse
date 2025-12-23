---
tags:
  - tool
---
Allows models to connect with external functions
- richer responses by extending knowledge
- ability to carry out actions within the application
- enhanced capabilities, like calculations

How it works
- in a request to the LLM, specify available Tools
- the reply is either text, or a request to run a Tool
- we run the Tool and call the LLM with the results

Common Use Cases for Tools - function calls can enable assistants to
- fetch data or add knowledge or context
- take action, like booking a meeting
- perform calculations
- modify the UI

Summary of tools
- HuggingFace
- [[LangChain]]
- [[MCP]]
- gradio
- weights & Biases
- modal