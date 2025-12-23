---
title: "Verbalized Sampling: How to Mitigate Mode Collapse and Unlock LLM Diversity"
source: "https://arxiv.org/abs/2510.01171"
pdf: "https://arxiv.org/pdf/2510.01171"
html: "https://arxiv.org/html/2510.01171v3"
code: "https://github.com/CHATS-lab/verbalize-sampling"
authors:
  - "Jiayi Zhang"
  - "Simon Yu"
  - "Derek Chong"
  - "Anthony Sicilia"
  - "Michael R. Tomz"
  - "Christopher D. Manning"
  - "Weiyan Shi"
published: 2025-10-01
revised: 2025-10-10
created: 2025-12-23
processed: 2025-12-23
type: research-paper
category: llm-techniques
relevance: high
status: processed
tags:
  - "#research-paper"
  - "#llm"
  - "#sampling"
  - "#mode-collapse"
  - "#prompting"
  - "#diversity"
  - "#alignment"
  - "#rlhf"
  - "#inference-time"
---
\[Submitted on 1 Oct 2025 ([v1](https://arxiv.org/abs/2510.01171v1)), last revised 10 Oct 2025 (this version, v3)\]

## Title:Verbalized Sampling: How to Mitigate Mode Collapse and Unlock LLM Diversity

Authors:, , , , , ,

[View PDF](https://arxiv.org/pdf/2510.01171) [HTML (experimental)](https://arxiv.org/html/2510.01171v3)

> Abstract:Post-training alignment often reduces LLM diversity, leading to a phenomenon known as mode collapse. Unlike prior work that attributes this effect to algorithmic limitations, we identify a fundamental, pervasive data-level driver: typicality bias in preference data, whereby annotators systematically favor familiar text as a result of well-established findings in cognitive psychology. We formalize this bias theoretically, verify it on preference datasets empirically, and show that it plays a central role in mode collapse. Motivated by this analysis, we introduce Verbalized Sampling, a simple, training-free prompting strategy to circumvent mode collapse. VS prompts the model to verbalize a probability distribution over a set of responses (e.g., "Generate 5 jokes about coffee and their corresponding probabilities"). Comprehensive experiments show that VS significantly improves performance across creative writing (poems, stories, jokes), dialogue simulation, open-ended QA, and synthetic data generation, without sacrificing factual accuracy and safety. For instance, in creative writing, VS increases diversity by 1.6-2.1x over direct prompting. We further observe an emergent trend that more capable models benefit more from VS. In sum, our work provides a new data-centric perspective on mode collapse and a practical inference-time remedy that helps unlock pre-trained generative diversity.

| Comments: | 82 pages, 28 figures, 32 tables. Code is available at [this https URL](https://github.com/CHATS-lab/verbalize-sampling) |
| --- | --- |
| Subjects: | Computation and Language (cs.CL); Artificial Intelligence (cs.AI) |
| Cite as: | [arXiv:2510.01171](https://arxiv.org/abs/2510.01171) \[cs.CL\] |
|  | (or [arXiv:2510.01171v3](https://arxiv.org/abs/2510.01171v3) \[cs.CL\] for this version) |
|  | [https://doi.org/10.48550/arXiv.2510.01171](https://doi.org/10.48550/arXiv.2510.01171)  arXiv-issued DOI via DataCite |

## Submission history

From: Jiayi Zhang \[[view email](https://arxiv.org/show-email/1a70d5d5/2510.01171)\]  
**[\[v1\]](https://arxiv.org/abs/2510.01171v1)** Wed, 1 Oct 2025 17:55:37 UTC (7,784 KB)  
**[\[v2\]](https://arxiv.org/abs/2510.01171v2)** Mon, 6 Oct 2025 16:29:44 UTC (28,095 KB)  
**\[v3\]** Fri, 10 Oct 2025 17:38:52 UTC (9,987 KB)  

## Bibliographic and Citation Tools

Bibliographic Explorer *([What is the Explorer?](https://info.arxiv.org/labs/showcase.html#arxiv-bibliographic-explorer))*

Connected Papers *([What is Connected Papers?](https://www.connectedpapers.com/about))*

Litmaps *([What is Litmaps?](https://www.litmaps.co/))*

scite Smart Citations *([What are Smart Citations?](https://www.scite.ai/))*

## Code, Data and Media Associated with this Article

alphaXiv *([What is alphaXiv?](https://alphaxiv.org/))*

CatalyzeX Code Finder for Papers *([What is CatalyzeX?](https://www.catalyzex.com/))*

DagsHub *([What is DagsHub?](https://dagshub.com/))*

Gotit.pub *([What is GotitPub?](http://gotit.pub/faq))*

Hugging Face *([What is Huggingface?](https://huggingface.co/huggingface))*

Papers with Code *([What is Papers with Code?](https://paperswithcode.com/))*

ScienceCast *([What is ScienceCast?](https://sciencecast.org/welcome))*

## Demos

Replicate *([What is Replicate?](https://replicate.com/docs/arxiv/about))*

Hugging Face Spaces *([What is Spaces?](https://huggingface.co/docs/hub/spaces))*

TXYZ.AI *([What is TXYZ.AI?](https://txyz.ai/))*

## arXivLabs: experimental projects with community collaborators

arXivLabs is a framework that allows collaborators to develop and share new arXiv features directly on our website.

Both individuals and organizations that work with arXivLabs have embraced and accepted our values of openness, community, excellence, and user data privacy. arXiv is committed to these values and only works with partners that adhere to them.

Have an idea for a project that will add value for arXiv's community? [**Learn more about arXivLabs**](https://info.arxiv.org/labs/index.html).

[Which authors of this paper are endorsers?](https://arxiv.org/auth/show-endorsers/2510.01171) | [Disable MathJax](https://arxiv.org/abs/) ([What is MathJax?](https://info.arxiv.org/help/mathjax.html))

---

## 📝 Paper Summary & Key Insights

### The Problem: Mode Collapse in Aligned LLMs

**Core Issue:** Post-training alignment (RLHF, DPO) unintentionally reduces output diversity. Instead of varied creative responses, aligned models converge on narrow, stereotypical outputs.

**Impact:** Severely limits applications requiring diversity:
- Creative writing (poems, stories, jokes)
- Social/dialogue simulation
- Synthetic data generation
- Open-ended question answering

### Root Cause: Typicality Bias (Key Insight)

**Unlike prior work** attributing mode collapse to algorithmic limitations, this paper identifies a **fundamental data-level driver**: **typicality bias** in preference data.

**What is typicality bias?** Human annotators systematically favor familiar, conventional text due to cognitive psychology:
- **Mere-exposure effect**: Frequent content feels more likable
- **Processing fluency**: Easy-to-process content seems higher quality
- **Schema congruity**: Familiar patterns get less critical evaluation

**Empirical validation:** Analyzed HelpSteer dataset, found α = 0.57±0.07 (p<10⁻¹⁴)
- Confirms "human raters are biased towards responses more typical for the base model"

**Mathematical formalization:**
```
r(x,y) = r_true(x,y) + α·log π_ref(y|x) + ε(x)
```
Where α > 0 represents typicality bias weight

**Result:** Under RLHF optimization, distribution sharpens by factor γ = 1 + α/β > 1, concentrating probability mass toward typical completions.

---

### The Solution: Verbalized Sampling (VS)

**Core Technique:** Training-free prompting strategy that asks models to verbalize probability distributions.

**Instead of:**
```
"Tell me a joke about coffee"
```

**Use VS:**
```
"Generate 5 jokes about coffee with their corresponding probabilities"
```

**Why it works:**
- **Instance-level prompts** → collapse to single most typical response
- **List-level prompts** → collapse to uniform distribution
- **Distribution-level prompts (VS)** → recover diverse pretraining distribution

By requesting probability distributions, the model's optimization mode shifts from generating stereotypical instances to recovering the original diverse distribution from pretraining.

**Variants:**
- **VS-Standard**: Basic distribution request
- **VS-CoT**: Adds chain-of-thought reasoning
- **VS-Multi**: Multi-turn generation across conversation

---

### Experimental Results

#### Creative Writing: 1.6-2.1× Diversity Improvement

| Task | Semantic Diversity Gain | Base Model Recovery |
|------|------------------------|---------------------|
| Poems | 1.8× vs. direct | 66.8% (vs. 23.8%) |
| Stories | 2.1× vs. direct | Similar improvement |
| Jokes | 1.6× vs. direct | Similar improvement |

**Human evaluation:** 25.7% quality improvement
**Key finding:** VS approaches Pareto optimality for diversity-quality trade-off

#### Dialogue Simulation (PersuasionForGood)

- Simulates donation behaviors closer to human distribution
- Linguistic diversity (Distinct-1/2/3) approaches fine-tuned baseline
- Works on 939 donation dialogue scenarios

#### Open-Ended QA (CoverageQA)

- 40 questions with 20+ valid answers each
- Lower KL divergence from pretraining distribution
- Broader answer coverage (Coverage-N metric)
- **Precision ~1.0**: No correctness sacrifice

#### Synthetic Data Generation (Competition Math)

Generated 1,000 math questions, evaluated on MATH500, OlympiadBench, Minerva Math:

| Method | Average Accuracy |
|--------|-----------------|
| Baseline | 32.8% |
| Direct prompting | 30.6% (worse!) |
| VS-Standard | 36.1% |
| **VS-Multi** | **37.5%** |

**Critical insight:** Direct prompting can degrade performance; VS consistently improves it.

---

### Emergent Scaling Trend

**Larger models benefit MORE from VS:**

| Model Size | Diversity Gain |
|------------|----------------|
| Small (GPT-4.1-Mini, Gemini Flash) | 1.5× |
| Large (GPT-4.1, Gemini Pro) | 2.0× |

**Implication:** VS "effectively unlocks pre-trained generative diversity" - more capable models have more diversity to recover.

**Reasoning models:** DeepSeek-R1 and GPT-o1 show even stronger benefits, suggesting advanced models are better at calibrating probabilities.

---

### Technical Implementation Details

**Computational Efficiency:**
- Under fixed budget of N responses:
  - Direct: N calls, 1 response each
  - VS: ⌈N/k⌉ calls, k responses per call
- **Same cost as sequence prompting**, minimal overhead

**Diversity Tuning:**
```
"Generate 5 responses with probabilities below [threshold]"
```
- Smooth diversity control without changing decoding parameters
- Temperature-like control at inference time
- Unavailable with traditional sampling methods

**Cross-Method Compatibility:**
- Works with temperature, top-p, min-p sampling
- Orthogonal to existing decoding strategies
- Compatible with closed APIs (GPT, Claude, Gemini) and open models

**Safety & Correctness:**
- Commonsense reasoning: Accuracy maintained
- Safety evaluation: No degradation
- Factual tasks: Precision ~1.0 preserved

---

### Practical Takeaways for Prompt Engineering

1. **Mode collapse is data-driven, not algorithmic**
   - Root cause: Human preference data has systematic bias
   - Solution doesn't require model retraining

2. **Inference-time mitigation is effective**
   - Simple prompt modification unlocks diversity
   - No architectural changes needed
   - Works on any model with API access

3. **Quality-diversity trade-off is improvable**
   - VS pushes Pareto frontier outward
   - Can get both more diversity AND better quality

4. **Use cases for VS:**
   - Creative writing tasks (poems, stories, jokes)
   - Brainstorming and ideation
   - Synthetic data generation for training
   - Dialogue simulation for testing
   - Any scenario requiring diverse outputs

5. **When NOT to use VS:**
   - Single-answer factual questions
   - Tasks where typicality equals correctness
   - Constrained domains with one right answer

6. **Implementation tips:**
   - Start with VS-Standard for simplicity
   - Use VS-CoT for complex reasoning tasks
   - Use VS-Multi for conversational contexts
   - Adjust probability thresholds to tune diversity
   - Test with larger models for better results

---

### Key Contributions

1. **Theoretical:** Formalized typicality bias as root cause of mode collapse
2. **Empirical:** Validated bias exists in preference datasets (α = 0.57±0.07)
3. **Methodological:** Introduced training-free prompting solution (VS)
4. **Experimental:** Comprehensive evaluation across 8 tasks, multiple model families
5. **Practical:** Deployment-ready technique for any API-accessible LLM

---

### Limitations & Future Work

**Acknowledged limitations:**
- **Computational cost:** Requires k LLM calls for k candidates (though same as sequence prompting)
- **Model capability dependent:** Needs sophisticated models that can calibrate probabilities accurately
- **Bounded by pretraining:** Can only recover diversity present in original pretraining data

**Future research directions:**
- Investigating typicality bias mitigation in preference data collection
- Exploring VS for multimodal generation
- Combining VS with improved decoding algorithms
- Understanding interaction with different alignment methods (DPO, IPO, etc.)

---

## 💡 Personal Notes & Applications

**Why this matters:**
- Addresses fundamental limitation of aligned LLMs
- Provides immediate, practical solution without retraining
- Relevant to any application using GPT-4, Claude, Gemini, etc.
- Changes how we think about prompt engineering for diversity

**Potential applications in my work:**
- Workshop exercises on creative prompt engineering
- Synthetic data generation for training examples
- Improving diversity in coding agent outputs
- Teaching advanced prompting techniques

**Related to ongoing research:**
- Connects to broader alignment research
- Relevant to understanding human feedback limitations
- Important for production LLM system design

**Action items:**
- [ ] Try VS technique on Claude/GPT for creative tasks
- [ ] Test on coding problems requiring diverse solutions
- [ ] Incorporate into workshop materials on prompting
- [ ] Explore code implementation: https://github.com/CHATS-lab/verbalize-sampling
- [ ] Add to permanent note on prompting best practices

---

## Related Concepts

**Prompting Techniques:**
- [[3-Resources/techniques/prompting/README]] - Prompt engineering overview
- [[3-Resources/techniques/prompting/basics]] - Fundamental prompting patterns
- [[3-Resources/techniques/prompting/system-prompts]] - System prompt design

**LLM Engineering:**
- [[3-Resources/llm-engineering/models]] - Understanding LLM behavior
- [[3-Resources/llm-engineering/techniques]] - LLM engineering patterns
- [[3-Resources/techniques/context-engineering/context-engineering-coding-agents]] - Context management

**Alignment & Training:**
- RLHF (Reinforcement Learning from Human Feedback) - Related to alignment
- DPO (Direct Preference Optimization) - Alternative alignment method
- Mode collapse - Core problem addressed

**Models Tested:**
- [[3-Resources/models/frontier/Claude 4 Sonnet]] - Can use VS technique
- [[3-Resources/models/production/GPT-4o]] - One of tested models
- [[3-Resources/models/production/Gemini Pro]] - Showed strong results

**Applications:**
- [[3-Resources/exercises/LLM Engineering - Code Generation]] - Could benefit from diverse outputs
- [[3-Resources/techniques/agents/building-coding-agents]] - Agent diversity considerations
- [[3-Resources/workshops/building-coding-agents-workshop]] - Teaching material connection

**Learning Resources:**
- [[5-Meta/MOCs/Prompting-Techniques-MOC]] - Add this technique to MOC
- [[2-Areas/AI-Learning/AI-Learning]] - Add to learning queue

---

**Paper Stats:** 82 pages, 28 figures, 32 tables
**Code Available:** https://github.com/CHATS-lab/verbalize-sampling
**Captured:** 2025-12-23
**Processed:** 2025-12-23
**Status:** Fully processed with PDF content
**Citation:** arXiv:2510.01171 [cs.CL]