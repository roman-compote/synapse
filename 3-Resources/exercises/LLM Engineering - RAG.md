
**File:** `llm_engineering-rag.ipynb`

## Overview
Enterprise-grade RAG implementation for Insurellm insurance company, building an expert knowledge worker AI assistant with high accuracy and cost optimization focus.

## Key Content

### RAG Architecture Implementation

#### Document Processing Pipeline
- **Multi-directory loading** - LangChain DirectoryLoader for knowledge base
- **Text splitting** - CharacterTextSplitter with 1000 char chunks, 200 overlap
- **Metadata enhancement** - Document type categorization (products, employees, contracts, company)
- **Encoding handling** - UTF-8 with fallback for cross-platform compatibility

#### Vector Store Construction
- **Embedding generation** - OpenAI embeddings vs HuggingFace alternatives
- **Chroma database** - SQLite-based vector storage with persistence
- **Dimensionality** - 1536-dimensional embedding vectors
- **Scalability** - Efficient retrieval from large document collections

### Knowledge Base Structure
```
knowledge-base/
├── products/     # Insurance product information
├── employees/    # Staff and organizational data
├── contracts/    # Contract templates and terms
└── company/      # Company policies and culture
```

### Visualization & Analysis

#### Vector Space Visualization
- **Dimensionality reduction** - t-SNE for 2D/3D visualization
- **Semantic clustering** - Document type grouping in vector space
- **Interactive exploration** - Plotly-based 3D scatter plots
- **Metadata integration** - Color-coded document categories

#### Performance Tuning
- **Retrieval optimization** - Configurable k parameter (25 chunks for complex queries)
- **Cost management** - GPT-4o-mini for budget-conscious deployment
- **Memory management** - ConversationBufferMemory for context retention

### LangChain Integration

#### Conversational RAG Chain
```python
conversation_chain = ConversationalRetrievalChain.from_llm(
    llm=llm, 
    retriever=retriever, 
    memory=memory
)
```

#### Query Processing Flow
1. **Question analysis** - User query understanding
2. **Document retrieval** - Semantic similarity search
3. **Context synthesis** - Relevant chunks compilation
4. **Response generation** - LLM with retrieved context
5. **Memory update** - Conversation history maintenance

### Advanced Features

#### Multi-Turn Conversations
- **Context persistence** - Conversation memory across interactions
- **Follow-up handling** - Reference to previous exchanges
- **Contextual understanding** - Building on conversation history

#### Debugging & Monitoring
- **Callback handlers** - StdOutCallbackHandler for query tracing
- **Retrieval inspection** - Examining which documents inform responses
- **Performance analysis** - Query latency and accuracy measurement

### Gradio Chat Interface
- **Conversational UI** - ChatInterface with message history
- **Real-time responses** - Streaming or immediate reply modes
- **Memory integration** - Persistent conversation across sessions

## Technical Patterns

### Cost Optimization Strategies
- **Model selection** - GPT-4o-mini over GPT-4 for cost efficiency
- **Embedding alternatives** - HuggingFace sentence-transformers option
- **Retrieval tuning** - Optimized chunk count for accuracy/cost balance

### Accuracy Improvement Techniques
- **Chunk overlap** - 200-character overlap for context preservation
- **Metadata utilization** - Document type awareness for better retrieval
- **Query expansion** - LangChain's conversational retrieval enhancements

### Production Considerations
- **Database persistence** - Chroma vectorstore with disk storage
- **Scalability** - Efficient vector operations for large knowledge bases
- **Error handling** - Robust encoding and file processing

## Key Learning Outcomes
- Enterprise RAG system architecture
- Vector database management and optimization
- LangChain framework mastery
- Cost-effective AI deployment strategies
- Knowledge base organization and processing
- Conversational AI memory management

## Technologies
- LangChain, OpenAI embeddings, Chroma vector database
- scikit-learn t-SNE, Plotly visualization
- Gradio chat interfaces, conversation memory
- HuggingFace transformers, sentence transformers
- Python file processing, metadata management