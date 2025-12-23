---
tags:
  - "#technique"
  - "#context-engineering"
  - "#llm"
  - "#practical"
  - "#patterns"
date: 2025-12-01
status: published
last_updated: 2025-12-01
---

# Context Engineering Techniques: Practical Patterns

A collection of actionable techniques, patterns, and code examples for implementing effective context engineering in LLM-based applications.

---

## Table of Contents

1. [Context Structuring Techniques](#context-structuring-techniques)
2. [RAG Implementation Patterns](#rag-implementation-patterns)
3. [Memory Management](#memory-management)
4. [Context Compression](#context-compression)
5. [Multi-Agent Patterns](#multi-agent-patterns)
6. [Tool Integration](#tool-integration)
7. [Optimization Techniques](#optimization-techniques)

---

## Context Structuring Techniques

### Technique 1: XML-Based Section Marking

**Use Case:** Clearly delineate different types of information in the context

**Implementation:**

```python
def build_structured_context(system_instructions, user_data, query):
    context = f"""
<system_instructions>
{system_instructions}
</system_instructions>

<user_context>
<user_profile>
Name: {user_data['name']}
Preferences: {user_data['preferences']}
</user_profile>

<conversation_history>
{format_conversation_history(user_data['history'])}
</conversation_history>
</user_context>

<current_query>
{query}
</current_query>
"""
    return context
```

**Benefits:**
- Clear boundaries between sections
- Models can better understand context organization
- Easy to parse and modify programmatically

**Best Practices:**
- Use consistent tag names across your application
- Nest tags hierarchically for complex information
- Close all tags properly

---

### Technique 2: Markdown Hierarchical Organization

**Use Case:** Present structured information in human-readable format

**Implementation:**

```python
def create_markdown_context(research_data):
    context = f"""
# Research Context

## Key Findings
{format_findings(research_data['findings'])}

## Data Sources
{format_sources(research_data['sources'])}

## Methodology
{research_data['methodology']}

## Limitations
- {chr(10).join(f'- {item}' for item in research_data['limitations'])}
"""
    return context
```

**Benefits:**
- Highly readable for both humans and models
- Natural hierarchy representation
- Works well with code blocks and lists

---

### Technique 3: Priority-Based Information Placement

**Use Case:** Ensure critical information gets attention

**Implementation:**

```python
def build_priority_context(critical_info, supporting_info, query):
    # Critical information at the beginning
    context = f"""CRITICAL CONTEXT:
{critical_info}

---

{supporting_info}

---

USER QUERY: {query}

Remember: The CRITICAL CONTEXT above must be followed strictly.
"""
    return context
```

**Research Finding:** Information placed at the beginning or end of context receives more attention (primacy and recency effects).

---

## RAG Implementation Patterns

### Pattern 1: Semantic Search with Reranking

**Use Case:** Retrieve highly relevant documents from large knowledge bases

**Implementation:**

```python
from sentence_transformers import SentenceTransformer, CrossEncoder
import numpy as np

class RetrievalPipeline:
    def __init__(self):
        self.embedder = SentenceTransformer('all-MiniLM-L6-v2')
        self.reranker = CrossEncoder('cross-encoder/ms-marco-MiniLM-L-6-v2')

    def retrieve_and_rerank(self, query, documents, top_k=5, rerank_top_n=20):
        # Stage 1: Semantic search
        query_embedding = self.embedder.encode(query)
        doc_embeddings = self.embedder.encode(documents)

        # Calculate similarities
        similarities = np.dot(doc_embeddings, query_embedding)

        # Get top N candidates for reranking
        top_indices = np.argsort(similarities)[-rerank_top_n:][::-1]
        candidates = [documents[i] for i in top_indices]

        # Stage 2: Rerank
        pairs = [[query, doc] for doc in candidates]
        rerank_scores = self.reranker.predict(pairs)

        # Get final top K
        final_indices = np.argsort(rerank_scores)[-top_k:][::-1]
        final_docs = [candidates[i] for i in final_indices]

        return final_docs
```

**Benefits:**
- Two-stage approach balances speed and accuracy
- Semantic search for broad recall
- Reranking for precision

---

### Pattern 2: Hybrid Search (Keyword + Semantic)

**Use Case:** Combine exact matching with semantic understanding

**Implementation:**

```python
from rank_bm25 import BM25Okapi
import numpy as np

class HybridRetrieval:
    def __init__(self, documents):
        self.documents = documents
        self.embedder = SentenceTransformer('all-MiniLM-L6-v2')

        # BM25 for keyword search
        tokenized_docs = [doc.lower().split() for doc in documents]
        self.bm25 = BM25Okapi(tokenized_docs)

        # Embeddings for semantic search
        self.doc_embeddings = self.embedder.encode(documents)

    def search(self, query, top_k=5, keyword_weight=0.3, semantic_weight=0.7):
        # Keyword search scores
        tokenized_query = query.lower().split()
        bm25_scores = self.bm25.get_scores(tokenized_query)

        # Semantic search scores
        query_embedding = self.embedder.encode(query)
        semantic_scores = np.dot(self.doc_embeddings, query_embedding)

        # Normalize scores
        bm25_normalized = (bm25_scores - bm25_scores.min()) / (bm25_scores.max() - bm25_scores.min() + 1e-6)
        semantic_normalized = (semantic_scores - semantic_scores.min()) / (semantic_scores.max() - semantic_scores.min() + 1e-6)

        # Combine scores
        combined_scores = (keyword_weight * bm25_normalized +
                          semantic_weight * semantic_normalized)

        # Get top K
        top_indices = np.argsort(combined_scores)[-top_k:][::-1]
        results = [self.documents[i] for i in top_indices]

        return results
```

**When to Use:**
- Technical documentation (needs exact term matching)
- Legal or medical texts (precision critical)
- Code search (function/class names matter)

---

### Pattern 3: Metadata-Filtered Retrieval

**Use Case:** Narrow search space before semantic matching

**Implementation:**

```python
class FilteredRetrieval:
    def __init__(self, vector_store):
        self.vector_store = vector_store

    def retrieve_with_filters(self, query, filters, top_k=5):
        """
        filters = {
            "date_range": ("2024-01-01", "2024-12-31"),
            "document_type": ["technical_doc", "api_reference"],
            "tags": ["authentication", "security"]
        }
        """
        # Apply filters first to reduce search space
        filtered_docs = self.vector_store.filter(
            date_after=filters.get("date_range", (None, None))[0],
            date_before=filters.get("date_range", (None, None))[1],
            doc_type__in=filters.get("document_type", []),
            tags__contains_any=filters.get("tags", [])
        )

        # Semantic search on filtered subset
        results = filtered_docs.similarity_search(
            query=query,
            k=top_k
        )

        return results
```

**Benefits:**
- Reduces search space significantly
- Improves relevance through domain filtering
- Faster retrieval on large datasets

---

### Pattern 4: Contextual Chunk Retrieval

**Use Case:** Include surrounding context with retrieved chunks

**Implementation:**

```python
class ContextualChunkRetrieval:
    def __init__(self, documents, chunk_size=512, overlap=50):
        self.documents = documents
        self.chunk_size = chunk_size
        self.overlap = overlap
        self.chunks = self._create_chunks()

    def _create_chunks(self):
        chunks = []
        for doc_id, doc in enumerate(self.documents):
            words = doc.split()
            for i in range(0, len(words), self.chunk_size - self.overlap):
                chunk = ' '.join(words[i:i + self.chunk_size])
                chunks.append({
                    'doc_id': doc_id,
                    'chunk_id': i // (self.chunk_size - self.overlap),
                    'content': chunk
                })
        return chunks

    def retrieve_with_context(self, query, top_k=3, context_chunks=1):
        # Retrieve top chunks (simplified)
        top_chunks = self._semantic_search(query, top_k)

        # Add surrounding chunks for context
        enhanced_results = []
        for chunk in top_chunks:
            doc_id = chunk['doc_id']
            chunk_id = chunk['chunk_id']

            # Get surrounding chunks
            context_before = [c for c in self.chunks
                            if c['doc_id'] == doc_id
                            and c['chunk_id'] == chunk_id - 1]

            context_after = [c for c in self.chunks
                           if c['doc_id'] == doc_id
                           and c['chunk_id'] == chunk_id + 1]

            enhanced = {
                'main_chunk': chunk['content'],
                'context_before': context_before[0]['content'] if context_before else '',
                'context_after': context_after[0]['content'] if context_after else ''
            }
            enhanced_results.append(enhanced)

        return enhanced_results
```

**Benefits:**
- Prevents loss of context at chunk boundaries
- Provides fuller picture around relevant information
- Helps model understand broader context

---

## Memory Management

### Pattern 1: Sliding Window Memory

**Use Case:** Maintain recent conversation history without context bloat

**Implementation:**

```python
class SlidingWindowMemory:
    def __init__(self, max_messages=10):
        self.max_messages = max_messages
        self.messages = []

    def add_message(self, role, content):
        self.messages.append({"role": role, "content": content})

        # Keep only recent messages
        if len(self.messages) > self.max_messages:
            self.messages = self.messages[-self.max_messages:]

    def get_context(self):
        return self.messages

    def clear(self):
        self.messages = []
```

**Simple but effective for most conversational applications.**

---

### Pattern 2: Summarization-Based Memory

**Use Case:** Preserve older conversation context in compressed form

**Implementation:**

```python
class SummarizationMemory:
    def __init__(self, llm, summary_threshold=20):
        self.llm = llm
        self.summary_threshold = summary_threshold
        self.recent_messages = []
        self.summary = ""

    def add_message(self, role, content):
        self.recent_messages.append({"role": role, "content": content})

        # When threshold reached, summarize and compress
        if len(self.recent_messages) >= self.summary_threshold:
            self._compress_memory()

    def _compress_memory(self):
        # Summarize older messages
        messages_to_summarize = self.recent_messages[:-5]  # Keep last 5

        summary_prompt = f"""
Previous summary: {self.summary}

New messages to incorporate:
{self._format_messages(messages_to_summarize)}

Provide an updated summary that captures key information.
"""

        new_summary = self.llm.generate(summary_prompt)
        self.summary = new_summary

        # Keep only recent messages
        self.recent_messages = self.recent_messages[-5:]

    def get_context(self):
        context = ""
        if self.summary:
            context += f"<conversation_summary>\n{self.summary}\n</conversation_summary>\n\n"

        context += "<recent_messages>\n"
        context += self._format_messages(self.recent_messages)
        context += "</recent_messages>"

        return context
```

**Benefits:**
- Maintains long conversation history
- Grows slowly (logarithmically vs. linearly)
- Preserves important information

---

### Pattern 3: Selective Memory with Importance Scoring

**Use Case:** Keep only important messages, discard trivial ones

**Implementation:**

```python
class SelectiveMemory:
    def __init__(self, llm, max_messages=15):
        self.llm = llm
        self.max_messages = max_messages
        self.messages = []

    def add_message(self, role, content):
        # Score message importance
        importance = self._score_importance(content)

        message = {
            "role": role,
            "content": content,
            "importance": importance,
            "timestamp": time.time()
        }

        self.messages.append(message)

        # Prune if needed
        if len(self.messages) > self.max_messages:
            self._prune_memory()

    def _score_importance(self, content):
        """Score from 0-1 based on content characteristics"""
        score = 0.5  # baseline

        # Heuristics (can be replaced with ML model)
        if len(content) > 200:
            score += 0.1  # Longer messages often more important

        if any(word in content.lower() for word in ['important', 'critical', 'must', 'never']):
            score += 0.2

        if content.strip().endswith('?'):
            score += 0.1  # Questions are important

        # Could also use LLM to score
        # importance = self.llm.score_importance(content)

        return min(score, 1.0)

    def _prune_memory(self):
        # Always keep most recent 5 messages
        recent = self.messages[-5:]
        older = self.messages[:-5]

        # Sort older messages by importance
        older_sorted = sorted(older, key=lambda x: x['importance'], reverse=True)

        # Keep top important + recent
        kept_older = older_sorted[:self.max_messages - 5]

        # Combine and re-sort by timestamp
        self.messages = sorted(kept_older + recent, key=lambda x: x['timestamp'])
```

---

### Pattern 4: External Long-Term Memory

**Use Case:** Persist user information across sessions

**Implementation:**

```python
import json
from datetime import datetime

class LongTermMemory:
    def __init__(self, user_id, storage_backend):
        self.user_id = user_id
        self.storage = storage_backend

    def remember_fact(self, category, key, value):
        """Store a fact about the user"""
        fact = {
            "category": category,
            "key": key,
            "value": value,
            "timestamp": datetime.now().isoformat(),
            "access_count": 0
        }

        self.storage.store(
            user_id=self.user_id,
            fact_id=f"{category}:{key}",
            data=fact
        )

    def recall_facts(self, categories=None, limit=10):
        """Retrieve relevant facts"""
        query = {"user_id": self.user_id}

        if categories:
            query["category__in"] = categories

        facts = self.storage.query(query, limit=limit)

        # Update access count
        for fact in facts:
            fact['access_count'] += 1
            self.storage.update(fact)

        return facts

    def get_context_summary(self):
        """Generate context from long-term memory"""
        # Get most important facts
        preferences = self.recall_facts(categories=["preferences"], limit=5)
        background = self.recall_facts(categories=["background"], limit=3)

        context = "<user_profile>\n"

        if preferences:
            context += "Preferences:\n"
            for fact in preferences:
                context += f"- {fact['key']}: {fact['value']}\n"

        if background:
            context += "\nBackground:\n"
            for fact in background:
                context += f"- {fact['value']}\n"

        context += "</user_profile>"

        return context

# Usage
memory = LongTermMemory(user_id="user123", storage_backend=DatabaseStorage())
memory.remember_fact("preferences", "communication_style", "technical and concise")
memory.remember_fact("background", "expertise", "Python developer with 5 years experience")

context = memory.get_context_summary()
```

---

## Context Compression

### Technique 1: Progressive Summarization

**Use Case:** Compress long documents while preserving key information

**Implementation:**

```python
class ProgressiveSummarizer:
    def __init__(self, llm):
        self.llm = llm

    def compress(self, text, target_ratio=0.3):
        """
        Compress text to approximately target_ratio of original length
        """
        current_text = text
        current_length = len(text.split())
        target_length = current_length * target_ratio

        while len(current_text.split()) > target_length * 1.1:
            # Summarize in stages
            current_text = self._summarize_chunk(current_text)

        return current_text

    def _summarize_chunk(self, text, chunk_size=2000):
        words = text.split()
        summaries = []

        # Break into chunks and summarize each
        for i in range(0, len(words), chunk_size):
            chunk = ' '.join(words[i:i + chunk_size])

            summary = self.llm.generate(f"""
Summarize the following, preserving key facts and details:

{chunk}

Summary:
""")
            summaries.append(summary)

        # Combine summaries
        combined = ' '.join(summaries)
        return combined
```

---

### Technique 2: Extractive Compression

**Use Case:** Keep only the most important sentences

**Implementation:**

```python
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np

class ExtractiveSummarizer:
    def __init__(self):
        self.vectorizer = TfidfVectorizer()

    def compress(self, text, compression_ratio=0.3):
        """Keep top X% of sentences by relevance"""
        sentences = text.split('. ')

        if len(sentences) <= 3:
            return text

        # Calculate TF-IDF
        tfidf_matrix = self.vectorizer.fit_transform(sentences)

        # Score sentences by centrality (similarity to all others)
        similarity_matrix = cosine_similarity(tfidf_matrix)
        scores = similarity_matrix.sum(axis=1)

        # Select top sentences
        n_keep = max(3, int(len(sentences) * compression_ratio))
        top_indices = np.argsort(scores)[-n_keep:]
        top_indices_sorted = sorted(top_indices)  # Preserve order

        compressed_sentences = [sentences[i] for i in top_indices_sorted]
        return '. '.join(compressed_sentences) + '.'
```

---

### Technique 3: Intelligent Truncation

**Use Case:** Trim verbose JSON or structured data

**Implementation:**

```python
def compress_json_context(data, max_depth=2, max_items=5):
    """
    Compress nested JSON by limiting depth and array sizes
    """
    def compress_recursive(obj, current_depth=0):
        if current_depth >= max_depth:
            return "..." if isinstance(obj, (dict, list)) else obj

        if isinstance(obj, dict):
            compressed = {}
            for key, value in list(obj.items())[:max_items]:
                compressed[key] = compress_recursive(value, current_depth + 1)
            if len(obj) > max_items:
                compressed["_truncated_"] = f"({len(obj) - max_items} more items)"
            return compressed

        elif isinstance(obj, list):
            compressed = [compress_recursive(item, current_depth + 1)
                         for item in obj[:max_items]]
            if len(obj) > max_items:
                compressed.append(f"... ({len(obj) - max_items} more items)")
            return compressed

        else:
            return obj

    return compress_recursive(data)

# Example
verbose_data = {
    "users": [
        {"id": 1, "name": "Alice", "email": "alice@example.com", "preferences": {...}, ...},
        # ... 100 more users
    ],
    "metadata": {...}
}

compressed = compress_json_context(verbose_data, max_depth=2, max_items=3)
# Result: Much smaller, preserves structure
```

---

## Multi-Agent Patterns

### Pattern 1: Orchestrator-Worker Architecture

**Use Case:** Complex tasks requiring coordination

**Implementation:**

```python
class Orchestrator:
    def __init__(self, llm):
        self.llm = llm
        self.workers = {
            "research": ResearchAgent(llm),
            "analysis": AnalysisAgent(llm),
            "implementation": ImplementationAgent(llm)
        }

    def execute_task(self, task_description):
        # Step 1: Plan the task
        plan = self.llm.generate(f"""
Given task: {task_description}

Break this down into subtasks for these workers:
- research: Gathers information
- analysis: Analyzes and plans
- implementation: Executes the solution

Provide a plan in JSON format.
""")

        # Step 2: Execute subtasks with workers
        results = {}
        for subtask in plan['subtasks']:
            worker = self.workers[subtask['worker']]
            result = worker.execute(subtask['description'])
            results[subtask['id']] = result

        # Step 3: Synthesize results
        final_output = self.llm.generate(f"""
Task: {task_description}

Worker results:
{json.dumps(results, indent=2)}

Synthesize these results into a final answer.
""")

        return final_output
```

**Benefits:**
- Each worker has isolated, focused context
- Parallel execution possible
- Specialized system prompts per worker

---

### Pattern 2: Verification Chain

**Use Case:** Ensure quality through independent review

**Implementation:**

```python
class VerificationChain:
    def __init__(self, llm):
        self.implementer = ImplementationAgent(llm)
        self.reviewer = ReviewAgent(llm)  # Fresh context

    def implement_with_verification(self, task):
        # Implementation phase
        implementation = self.implementer.execute(task)

        # Verification phase (fresh, unbiased context)
        review = self.reviewer.review(
            task=task,
            implementation=implementation
        )

        if review['issues']:
            # Iterate if needed
            fixes = self.implementer.fix_issues(
                implementation=implementation,
                issues=review['issues']
            )

            # Re-verify
            final_review = self.reviewer.review(
                task=task,
                implementation=fixes
            )

            return fixes, final_review

        return implementation, review
```

---

## Tool Integration

### Pattern 1: Dynamic Tool Selection

**Use Case:** Avoid loading all tools into context

**Implementation:**

```python
class DynamicToolManager:
    def __init__(self, llm, tool_registry):
        self.llm = llm
        self.tool_registry = tool_registry

    def execute_with_tools(self, query):
        # Step 1: Determine relevant tools
        all_tools_summary = {name: tool.description
                           for name, tool in self.tool_registry.items()}

        tool_selection_prompt = f"""
Available tools:
{json.dumps(all_tools_summary, indent=2)}

User query: {query}

Which tools (list of names) are needed for this query?
Respond with JSON: {{"tools": ["tool1", "tool2"]}}
"""

        selected_tool_names = self.llm.generate(tool_selection_prompt)['tools']

        # Step 2: Load only selected tools
        selected_tools = {name: self.tool_registry[name]
                         for name in selected_tool_names}

        # Step 3: Execute query with selected tools
        result = self.llm.generate_with_tools(
            query=query,
            tools=selected_tools
        )

        return result
```

**Benefits:**
- Minimal context usage
- Scales to hundreds of tools
- Reduces token costs

---

### Pattern 2: Tool Result Compression

**Use Case:** Compress verbose tool outputs before adding to context

**Implementation:**

```python
class CompressingToolWrapper:
    def __init__(self, tool, llm):
        self.tool = tool
        self.llm = llm

    def execute(self, *args, **kwargs):
        # Run the tool
        raw_result = self.tool.execute(*args, **kwargs)

        # Check if result is verbose
        if len(str(raw_result)) > 1000:  # Threshold
            compressed = self._compress_result(raw_result)
            return compressed

        return raw_result

    def _compress_result(self, result):
        """Compress verbose results"""
        compression_prompt = f"""
The following is a tool output. Compress it to key information only:

{result}

Compressed version (preserve critical details):
"""

        compressed = self.llm.generate(compression_prompt)
        return compressed

# Usage
database_tool = DatabaseQueryTool()
compressed_db_tool = CompressingToolWrapper(database_tool, llm)

result = compressed_db_tool.execute("SELECT * FROM users")
# Returns compressed summary instead of 1000 rows
```

---

## Optimization Techniques

### Technique 1: Context Caching

**Use Case:** Reuse expensive context processing (e.g., Anthropic prompt caching)

**Implementation:**

```python
class ContextWithCaching:
    def __init__(self, llm):
        self.llm = llm
        self.cache_key_template = None

    def set_cacheable_context(self, system_prompt, knowledge_base):
        """Mark parts of context as cacheable"""
        self.cache_key_template = {
            "system": system_prompt,  # Changes rarely - cache
            "knowledge": knowledge_base  # Static - cache
        }

    def generate(self, user_query):
        # Build context with cache markers
        full_context = {
            "system": {
                "content": self.cache_key_template["system"],
                "cache": True  # Anthropic caches this
            },
            "knowledge": {
                "content": self.cache_key_template["knowledge"],
                "cache": True  # Anthropic caches this
            },
            "query": {
                "content": user_query,
                "cache": False  # Changes every time
            }
        }

        result = self.llm.generate_with_cache(full_context)
        return result
```

**Savings:** Up to 90% cost reduction on repeated context.

---

### Technique 2: Lazy Loading Context

**Use Case:** Load information only when needed

**Implementation:**

```python
class LazyContextLoader:
    def __init__(self, llm, knowledge_base):
        self.llm = llm
        self.kb = knowledge_base
        self.loaded_context = {}

    def process_query(self, query):
        # Start with minimal context
        initial_response = self.llm.generate(
            f"Query: {query}\n\nRespond with 'NEED_INFO: topic' if you need more information."
        )

        # Check if more context needed
        if initial_response.startswith("NEED_INFO:"):
            topic = initial_response.split(":", 1)[1].strip()

            # Load relevant context
            additional_context = self.kb.retrieve(topic)
            self.loaded_context[topic] = additional_context

            # Retry with context
            full_response = self.llm.generate(
                f"Context: {additional_context}\n\nQuery: {query}"
            )
            return full_response

        return initial_response
```

**Benefits:**
- Only loads what's needed
- Reduces wasted context on irrelevant information
- Interactive refinement

---

### Technique 3: Context Utilization Monitoring

**Use Case:** Track and optimize context usage

**Implementation:**

```python
class ContextMonitor:
    def __init__(self, max_tokens=100000):
        self.max_tokens = max_tokens
        self.usage_history = []

    def track_generation(self, context, response, tokens_used):
        utilization = tokens_used / self.max_tokens

        self.usage_history.append({
            "timestamp": time.time(),
            "utilization": utilization,
            "context_size": len(context.split()),
            "response_size": len(response.split())
        })

        # Warning if approaching limit
        if utilization > 0.8:
            print(f"⚠️ High context utilization: {utilization:.1%}")
            self._suggest_optimizations()

    def _suggest_optimizations(self):
        recent = self.usage_history[-10:]
        avg_util = sum(h['utilization'] for h in recent) / len(recent)

        if avg_util > 0.7:
            print("Suggestions:")
            print("- Consider implementing context compression")
            print("- Use sub-agents for isolated subtasks")
            print("- Implement progressive summarization")

    def get_metrics(self):
        if not self.usage_history:
            return {}

        return {
            "average_utilization": np.mean([h['utilization'] for h in self.usage_history]),
            "peak_utilization": max(h['utilization'] for h in self.usage_history),
            "total_calls": len(self.usage_history)
        }
```

---

## Complete Example: RAG System with Context Engineering

**Putting it all together:**

```python
class ContextEngineeredRAG:
    def __init__(self, llm, vector_store):
        self.llm = llm
        self.vector_store = vector_store
        self.memory = SummarizationMemory(llm)
        self.monitor = ContextMonitor(max_tokens=100000)

    def query(self, user_query, filters=None):
        # 1. Retrieve relevant information
        retrieved_docs = self.vector_store.similarity_search(
            query=user_query,
            k=3,
            filters=filters
        )

        # 2. Compress retrieved docs if needed
        compressed_docs = []
        for doc in retrieved_docs:
            if len(doc.split()) > 500:
                compressed = ExtractiveSummarizer().compress(doc, compression_ratio=0.4)
                compressed_docs.append(compressed)
            else:
                compressed_docs.append(doc)

        # 3. Build structured context
        context = self._build_context(
            memory=self.memory.get_context(),
            retrieved_docs=compressed_docs,
            query=user_query
        )

        # 4. Generate response
        response = self.llm.generate(context)

        # 5. Update memory
        self.memory.add_message("user", user_query)
        self.memory.add_message("assistant", response)

        # 6. Monitor context usage
        tokens_used = len(context.split()) * 1.3  # Rough estimate
        self.monitor.track_generation(context, response, tokens_used)

        return response

    def _build_context(self, memory, retrieved_docs, query):
        context = f"""
<system_instructions>
You are a helpful assistant. Use the provided context to answer questions accurately.
</system_instructions>

{memory}

<retrieved_information>
{chr(10).join(f"Document {i+1}:\n{doc}\n" for i, doc in enumerate(retrieved_docs))}
</retrieved_information>

<user_query>
{query}
</user_query>

Provide a comprehensive answer based on the retrieved information.
"""
        return context
```

---

## Resources

### Implementation Libraries

**RAG Frameworks:**
- [LangChain](https://python.langchain.com/) - Comprehensive orchestration
- [LlamaIndex](https://www.llamaindex.ai/) - Advanced RAG patterns
- [Haystack](https://haystack.deepset.ai/) - Production pipelines

**Vector Databases:**
- [Pinecone](https://www.pinecone.io/) - Managed vector search
- [Weaviate](https://weaviate.io/) - Open-source vector database
- [Chroma](https://www.trychroma.com/) - Lightweight embeddings
- [Qdrant](https://qdrant.tech/) - High-performance vector search

**Memory Systems:**
- [Mem0](https://github.com/mem0ai/mem0) - Personalized memory layer
- [Zep](https://www.getzep.com/) - Long-term memory for LLMs

### Code Examples & Tutorials

- [LangChain Cookbook](https://github.com/langchain-ai/langchain/tree/master/cookbook) - Practical patterns
- [LlamaIndex Examples](https://docs.llamaindex.ai/en/stable/examples/) - RAG implementations
- [Anthropic Cookbook](https://github.com/anthropics/anthropic-cookbook) - Context engineering with Claude

---

## Related Documents

- [[context-engineering|Context Engineering Overview]] - Fundamental concepts
- [[context-engineering-coding-agents|Context Engineering for Coding Agents]] - Specialized patterns
- [[RAG|Retrieval-Augmented Generation]] - RAG deep dive
- [[techniques/prompting/README|Prompt Engineering]] - Foundation techniques

---

**Last Updated:** 2025-12-01
**Status:** Living document - will be updated with new patterns

*These techniques represent current best practices. Experiment and adapt to your specific use case.*
