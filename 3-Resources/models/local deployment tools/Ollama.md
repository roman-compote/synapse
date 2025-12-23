[Ollama](https://ollama.com) is a free, open-source framework that allows you to easily run Large Language Models (LLMs) on your local computer, providing privacy, security, and faster performance by eliminating reliance on cloud services. It offers a simple way to download and manage various LLMs, such as Llama 3 and Mistral, through a command-line interface (CLI). Ollama also includes an API that lets developers integrate these local models into their own applications. 

# Key Features

- Local & Offline Operation: Run powerful LLMs directly on your hardware without needing an internet connection. 
- Privacy and Data Control: Keep your data private by avoiding the use of cloud storage. 
- Simplified Model Management: Easily download, manage, and use popular open-source LLMs from a central repository, similar to how Docker works with containers. 
- Command-Line Interface (CLI): Interact with and control LLMs using simple commands in your terminal. 
- API Access: Provides an API layer that allows other applications and services to connect with and utilize the running LLMs. 
- Multi-Platform Support: Available for macOS, Linux, and Windows. 

# commands
***

to start ollama server
```
ollama serve
```

to pull model
```
ollama pull gpt-oss
```

to use model
```
ollama use gpt-oss
```
