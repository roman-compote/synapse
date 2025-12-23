---
tags:
  - "#permanent"
  - "#prompting"
  - "#technique"
  - "#diversity"
  - "#inference-time"
type: permanent-note
created: 2025-12-23
last_updated: 2025-12-23
---

# Verbalized Sampling (VS)

A training-free prompting technique that unlocks LLM diversity by asking models to verbalize probability distributions instead of generating single instances.

---

## Overview

**What it is:**
Verbalized Sampling (VS) is a prompting strategy where you ask an LLM to generate multiple responses along with their corresponding probabilities, rather than requesting a single output. This simple change in prompt structure recovers the diverse, creative outputs that were present in the model's pretraining but suppressed during alignment.

**Why it matters:**
- Increases output diversity by 1.6-2.1× in creative tasks
- No retraining or fine-tuning required - works at inference time
- Compatible with any API-accessible LLM (GPT, Claude, Gemini, open models)
- Improves both diversity AND quality (Pareto optimal)
- Addresses fundamental limitation of aligned models (mode collapse)

**Core idea:**
When you ask for a single response, the model optimizes for the most "typical" answer. When you ask for a probability distribution over multiple responses, the model's optimization target shifts to recovering the diverse distribution from its pretraining, unlocking creativity without sacrificing quality.

---

## The Technique

### Basic Pattern

**Traditional prompt:**
```
"Tell me a joke about coffee"
```

**Verbalized Sampling:**
```
"Generate 5 jokes about coffee with their corresponding probabilities"
```

### Structure

```
"Generate [N] [outputs] about [topic] with their corresponding probabilities"
```

Where:
- **N**: Number of diverse outputs desired (typically 3-10)
- **outputs**: Type of content (jokes, stories, solutions, approaches, etc.)
- **topic**: Your specific subject or task
- **probabilities**: Explicitly request probability values

---

## Variants

### 1. VS-Standard (Basic)
Simplest form - just ask for probabilities with outputs.

**Example:**
```
"Generate 3 different approaches to implement caching in a web application,
with their corresponding probabilities of being optimal for different scenarios"
```

### 2. VS-CoT (Chain-of-Thought)
Add reasoning before probability assignment.

**Example:**
```
"Generate 5 Python sorting algorithms. For each:
1. Explain the approach
2. Analyze time/space complexity
3. Provide the probability it's best for different data sizes
Include your reasoning for the probability assignments"
```

### 3. VS-Multi (Multi-turn)
Use across conversation turns for sustained diversity.

**Example:**
```
Turn 1: "Generate 3 story premises with probabilities"
Turn 2: "For the second premise, generate 3 possible plot twists with probabilities"
Turn 3: "For the first twist, generate 3 character reactions with probabilities"
```

---

## Examples

### Example 1: Creative Writing

**Standard prompt:**
```
"Write a short poem about artificial intelligence"
```

**VS prompt:**
```
"Generate 5 different short poems about artificial intelligence,
each with a distinct style (haiku, sonnet, free verse, limerick, acrostic),
with their corresponding probabilities of resonating with different audiences"
```

**Result:** 5 diverse poems instead of 1 typical poem

---

### Example 2: Coding Problems

**Standard prompt:**
```
"Write a Python function to sort a list"
```

**VS prompt:**
```
"Generate 3 different Python functions to sort a list, each using
a different approach (built-in, quicksort, mergesort), with their
corresponding probabilities of being the best solution for:
- Small datasets (< 100 items)
- Large datasets (> 10,000 items)
- Nearly sorted data"
```

**Result:** Multiple solutions with context about when to use each

---

### Example 3: Brainstorming

**Standard prompt:**
```
"Suggest a name for a new AI coding assistant"
```

**VS prompt:**
```
"Generate 10 potential names for an AI coding assistant with their
probabilities of appealing to:
- Professional developers
- Students learning to code
- Enterprise teams

Include reasoning for each probability"
```

**Result:** Diverse naming options with strategic context

---

### Example 4: Problem-Solving

**Standard prompt:**
```
"How can I improve my application's performance?"
```

**VS prompt:**
```
"Generate 5 different approaches to improve application performance,
covering database, caching, code optimization, infrastructure, and
frontend strategies, with probabilities of having the highest impact
for different bottleneck scenarios"
```

**Result:** Comprehensive strategies instead of generic advice

---

## How It Works

### The Mechanism

**Traditional prompting optimization:**
- Single instance prompt → Model outputs most typical response
- Alignment training reinforces "safe" typical patterns
- Result: Mode collapse to narrow, stereotypical outputs

**Verbalized Sampling optimization:**
- Distribution-level prompt → Model's optimization target shifts
- Instead of finding single best instance, recovers diverse distribution
- Probabilities force model to calibrate across multiple modes
- Result: Recovers pretraining diversity while maintaining quality

### Why Probabilities Matter

Requesting probabilities changes the optimization:
- Forces model to reason about multiple possibilities
- Activates calibration across diverse outputs
- Prevents collapse to single typical answer
- Maintains quality through explicit probability assignment

---

## When to Use

### Best Use Cases

1. **Creative tasks requiring diversity:**
   - Story writing, poetry, jokes
   - Design brainstorming
   - Content ideation
   - Marketing copy variations

2. **Problem-solving with multiple valid approaches:**
   - Architecture decisions
   - Algorithm selection
   - Strategy development
   - Troubleshooting (multiple possible causes)

3. **Synthetic data generation:**
   - Training data creation
   - Test case generation
   - Scenario simulation

4. **Open-ended questions:**
   - Questions with multiple valid answers
   - Exploratory analysis
   - Perspective-taking exercises

5. **Avoiding typical/boring outputs:**
   - When standard prompting gives generic results
   - When you need creative alternatives
   - When exploring solution space

### When NOT to Use

1. **Single-answer factual questions:**
   - "What is the capital of France?" → Direct answer better

2. **Tasks where typicality equals correctness:**
   - Standard code implementations
   - Well-defined technical procedures
   - Compliance or regulatory content

3. **Constrained domains with one right answer:**
   - Mathematical calculations
   - Specific API usage
   - Exact specifications

---

## Advantages & Limitations

### Strengths

**Diversity:**
- 1.6-2.1× improvement in semantic diversity
- Recovers 66.8% of base model diversity (vs. 23.8% for direct)

**Quality:**
- 25.7% improvement in human evaluation
- Maintains precision ~1.0 on factual tasks
- No safety degradation

**Practicality:**
- Training-free, inference-time only
- Works on any API-accessible model
- Same computational cost as sequence prompting
- Compatible with all decoding strategies

**Scalability:**
- Larger models benefit more (2× gain for GPT-4, Gemini Pro)
- Works across 8+ model families
- Tunable diversity via probability thresholds

### Limitations

**Computational:**
- Requires k LLM calls for k diverse outputs
- Same cost as generating k separate responses
- May be expensive for very large k

**Model-dependent:**
- Requires sophisticated models that calibrate probabilities well
- Less effective on smaller or less capable models
- Quality depends on model's pretraining diversity

**Bounded recovery:**
- Can only recover diversity present in pretraining
- Won't create novel capabilities not in base model
- Limited by original training data

---

## Diversity Tuning

### Controlling Output Diversity

You can adjust diversity by specifying probability thresholds:

**High diversity (more unusual outputs):**
```
"Generate 5 solutions with probabilities below 0.3"
```

**Moderate diversity:**
```
"Generate 5 solutions with probabilities between 0.2 and 0.6"
```

**Balanced (default):**
```
"Generate 5 solutions with their corresponding probabilities"
```

This provides temperature-like control without changing model parameters.

---

## Tips for Implementation

### Prompt Engineering Tips

1. **Be specific about N (number of outputs):**
   - Too few (1-2): Not enough diversity
   - Sweet spot (3-10): Good balance
   - Too many (20+): Diminishing returns

2. **Request explicit probability values:**
   - "with probabilities" or "with corresponding probabilities"
   - Can also ask for percentages or likelihoods

3. **Add context for probability calibration:**
   - "probability of being best for [scenario]"
   - "likelihood of success in [context]"
   - "chance of resonating with [audience]"

4. **Combine with other techniques:**
   - VS + Chain-of-Thought: Better reasoning
   - VS + Few-shot: Guided by examples
   - VS + System prompts: Consistent behavior

5. **Use larger models when possible:**
   - GPT-4, Claude 3.5+, Gemini Pro show 2× gains
   - Reasoning models (GPT-o1, DeepSeek-R1) excel

### Common Patterns

**Pattern 1: Scenario-based probabilities**
```
"Generate 3 authentication methods with probabilities for:
- Small startups (< 10 users)
- Medium businesses (100-1000 users)
- Enterprise (10,000+ users)"
```

**Pattern 2: Multi-dimensional probabilities**
```
"Generate 5 UI design options with probabilities for:
- User-friendliness (P_ux)
- Development complexity (P_dev)
- Accessibility compliance (P_a11y)"
```

**Pattern 3: Constrained diversity**
```
"Generate 4 blog post titles with probabilities between 0.15-0.35,
ensuring none are too conventional (> 0.5) or too unusual (< 0.1)"
```

---

## Related Concepts

**Prompting Techniques:**
- [[3-Resources/techniques/prompting/basics]] - Fundamental prompting patterns
- [[3-Resources/techniques/prompting/system-prompts]] - System-level prompt design
- Chain-of-Thought prompting - Combines well with VS-CoT variant
- Few-shot prompting - Can guide VS outputs with examples

**LLM Concepts:**
- Mode collapse - Problem that VS addresses
- Alignment (RLHF/DPO) - Source of mode collapse
- Typicality bias - Root cause identified in research
- Sampling strategies - Temperature, top-p, top-k (VS is orthogonal)

**Applications:**
- [[3-Resources/exercises/LLM Engineering - Code Generation]] - Apply VS to coding
- [[3-Resources/techniques/agents/building-coding-agents]] - Agent output diversity
- Synthetic data generation - Key use case for VS

**Research:**
- [[3-Resources/bookmarks/Research-Papers/Verbalized Sampling How to Mitigate Mode Collapse and Unlock LLM Diversity]] - Original paper

**Relevant MOCs:**
- [[5-Meta/MOCs/Prompting-Techniques-MOC]] - All prompting techniques

---

## Resources

**Primary Sources:**
- [Verbalized Sampling Paper](https://arxiv.org/abs/2510.01171) - Original research (Oct 2025)
- [GitHub Implementation](https://github.com/CHATS-lab/verbalize-sampling) - Code examples

**Key Research Findings:**
- 1.6-2.1× diversity improvement in creative writing
- 25.7% quality improvement in human evaluation
- 37.5% accuracy for synthetic data (vs. 30.6% direct)
- Works across GPT-4, Claude, Gemini, and open models

---

## Quick Reference Card

```markdown
# Verbalized Sampling - Quick Guide

## Basic Template
"Generate [N] [outputs] about [topic] with their probabilities"

## Example Transformations

Standard → VS:
"Write a joke"         → "Generate 5 jokes with probabilities"
"Solve this problem"   → "Generate 3 solutions with probabilities"
"Name this app"        → "Generate 10 names with probabilities"

## When to Use
✅ Creative tasks          ❌ Single factual answers
✅ Multiple solutions      ❌ Exact specifications
✅ Brainstorming           ❌ Compliance content
✅ Avoiding generic output ❌ Simple lookups

## Expected Improvements
- 1.6-2.1× more diversity
- No quality loss
- Works on GPT/Claude/Gemini
- Same cost as sequence prompting
```

---

**Created:** 2025-12-23
**Last Updated:** 2025-12-23
**Status:** Published
**Source:** arXiv:2510.01171 (Zhang et al., 2025)
