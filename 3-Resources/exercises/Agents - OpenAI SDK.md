
**File:** `agents-openai.ipynb`

## Overview
Advanced agentic AI implementation using OpenAI's native Agents SDK, building a sophisticated multi-agent research system with web search capabilities and automated email reporting.

## Key Content

### OpenAI Agents Architecture

#### Core Agent Components
- **Agent class** - OpenAI's native agent implementation
- **WebSearchTool** - Hosted web search with cost awareness (~2.5 cents/call)
- **Function tools** - Custom tool creation with decorators
- **Structured outputs** - Pydantic model integration for reliable data structures

#### Research Agent Pipeline
```python
search_agent = Agent(
    name="Search agent",
    instructions=INSTRUCTIONS,
    tools=[WebSearchTool(search_context_size="low")],
    model="gpt-4o-mini",
    model_settings=ModelSettings(tool_choice="required"),
)
```

### Multi-Agent System Design

#### Agent Specialization
1. **Planner Agent** - Query decomposition and search strategy
2. **Search Agent** - Web search execution and summarization  
3. **Writer Agent** - Report synthesis and formatting
4. **Email Agent** - Report distribution via SendGrid

#### Structured Output Schemas
```python
class WebSearchItem(BaseModel):
    reason: str = Field(description="Your reasoning for why this search is important")
    query: str = Field(description="The search term to use for the web search")

class WebSearchPlan(BaseModel):
    searches: list[WebSearchItem] = Field(description="A list of web searches to perform")
```

### Advanced Workflow Orchestration

#### Asynchronous Processing
- **Parallel search execution** - Multiple searches via `asyncio.gather()`
- **Performance optimization** - Concurrent agent operations
- **Error handling** - Robust failure management across agents

#### Research Pipeline
1. **Query analysis** - Break complex questions into searchable terms
2. **Search planning** - Generate targeted search strategies with reasoning
3. **Information gathering** - Execute searches with specialized summarization
4. **Report synthesis** - Compile findings into comprehensive reports (1000+ words)
5. **Distribution** - Automated email delivery with HTML formatting

### Production Features

#### Email Integration (SendGrid)
- **HTML formatting** - Rich text report delivery
- **Template generation** - Automated email composition
- **Delivery confirmation** - Success status tracking
- **Sender verification** - Production email setup

#### Trace Management
- **OpenAI tracing** - Built-in observability at platform.openai.com/traces
- **Custom trace IDs** - Workflow tracking and debugging
- **Performance monitoring** - Agent execution analysis

### Cost Management Strategies
- **Model selection** - GPT-4o-mini for cost efficiency
- **Search context sizing** - "low" context to minimize costs
- **Parallel processing** - Reduced total execution time
- **Structured outputs** - Reliable parsing without retry costs

## Technical Implementation

### Function Tool Creation
```python
@function_tool
def send_email(subject: str, html_body: str) -> Dict[str, str]:
    """ Send out an email with the given subject and HTML body """
    # SendGrid implementation
```

### Async Agent Coordination
```python
async def plan_searches(query: str):
    result = await Runner.run(planner_agent, f"Query: {query}")
    return result.final_output

async def perform_searches(search_plan: WebSearchPlan):
    tasks = [asyncio.create_task(search(item)) for item in search_plan.searches]
    results = await asyncio.gather(*tasks)
    return results
```

### Report Generation Pipeline
- **Length requirements** - 5-10 pages, 1000+ words minimum
- **Markdown formatting** - Structured document output
- **Follow-up suggestions** - Research continuation recommendations
- **Executive summary** - 2-3 sentence key findings

## Key Learning Outcomes
- OpenAI Agents SDK mastery
- Multi-agent system orchestration
- Asynchronous workflow management
- Production email integration
- Cost-effective research automation
- Structured output reliability
- Trace-based debugging and monitoring

## Advanced Concepts
- **Agentic workflows** - Beyond simple chat completions
- **Agent specialization** - Task-specific AI workers
- **Structured reasoning** - Pydantic model constraints
- **Production deployment** - Real-world business integration
- **Observability** - Comprehensive tracing and monitoring

## Technologies
- OpenAI Agents SDK, WebSearchTool, Runner
- Pydantic structured outputs, asyncio concurrency
- SendGrid email API, HTML template generation
- OpenAI tracing platform, custom observability
- Python decorators, type hints, async/await patterns