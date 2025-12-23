# Prompt Engineering Basics

Prompt engineering is the practice of designing effective inputs (prompts) to guide AI models toward desired outputs. This foundational knowledge is essential for anyone working with Large Language Models.

---

## 🎯 What is a Prompt?

A **prompt** is the input text you provide to an AI model to elicit a specific response. It can be:
- A question: "What is machine learning?"
- An instruction: "Write a Python function to sort a list"
- A request: "Summarize the following article..."
- A conversation: "Let's discuss the pros and cons of..."

---

## 🏗️ Anatomy of a Good Prompt

A well-crafted prompt typically includes:

### 1. **Task/Instruction** (Required)
What you want the model to do.
```
Write a product description for...
Analyze the following code and...
Translate this text to Spanish...
```

### 2. **Context** (Often Helpful)
Background information to guide the response.
```
You are helping a beginner programmer...
This is for a technical audience...
The product is targeted at small businesses...
```

### 3. **Input Data** (When Applicable)
The specific content to process.
```
Here is the code: [code block]
The article text: [text]
The data: [data]
```

### 4. **Output Format** (Recommended)
How you want the response structured.
```
Respond in JSON format
List 5 bullet points
Explain in 2-3 sentences
Use markdown formatting
```

---

## 📋 Basic Prompt Structure

### Simple Pattern
```
[Task] + [Input]

Example:
Summarize this article: [article text]
```

### Comprehensive Pattern
```
[Context/Role] + [Task] + [Input] + [Format/Constraints]

Example:
You are a Python expert. Review this code for security issues
and provide specific recommendations. Here's the code:
[code block]
Format your response as:
1. Issue description
2. Severity (Low/Medium/High)
3. Recommendation
```

---

## 💡 Core Principles

### 1. **Be Clear and Specific**
❌ Bad: "Tell me about dogs"
✅ Good: "List 5 key differences between Golden Retrievers and German Shepherds in terms of temperament, size, and exercise needs"

### 2. **Provide Sufficient Context**
❌ Bad: "Fix this code: x = [1,2,3]"
✅ Good: "I'm trying to sort this Python list in descending order. How should I modify this code: x = [1,2,3]"

### 3. **Specify Output Format**
❌ Bad: "What are the benefits of exercise?"
✅ Good: "List 5 benefits of regular exercise. Format as: Benefit: [name] - Description: [2-3 sentences]"

### 4. **Use Constraints When Needed**
```
Explain quantum computing in simple terms.
Constraints:
- Use analogies a 10-year-old would understand
- Avoid technical jargon
- Keep under 200 words
```

### 5. **Iterate and Refine**
Start simple → test → analyze results → refine → repeat

---

## 🎨 Basic Prompt Patterns

### Pattern 1: Question Answering
```
Question: What is the capital of France?
Answer: Paris
```

### Pattern 2: Instruction Following
```
Convert this text to uppercase: hello world
```

### Pattern 3: Text Transformation
```
Translate to Spanish: "Good morning, how are you?"
```

### Pattern 4: Content Generation
```
Write a haiku about artificial intelligence.
```

### Pattern 5: Analysis/Reasoning
```
Analyze the pros and cons of remote work for software engineers.
Present in a table format.
```

---

## 🔑 Key Techniques for Beginners

### 1. **Role Assignment**
Tell the model what role to adopt:
```
You are an experienced software architect.
Review this system design and identify potential bottlenecks.
```

### 2. **Step-by-Step Instructions**
Break complex tasks into steps:
```
Help me debug this code:
1. First, identify syntax errors
2. Then, check for logical errors
3. Finally, suggest performance improvements
```

### 3. **Positive Phrasing**
Frame what you want, not what you don't want:
```
❌ Don't use technical jargon
✅ Use simple, everyday language
```

### 4. **Temperature Control** (API Usage)
- **Low temperature (0.0-0.3)**: Focused, deterministic, consistent
- **Medium temperature (0.4-0.7)**: Balanced creativity and consistency
- **High temperature (0.8-1.0)**: Creative, diverse, less predictable

---

## 📊 Prompt Quality Checklist

Before submitting a prompt, check:

- [ ] Is the task clearly stated?
- [ ] Is there enough context?
- [ ] Is the desired output format specified?
- [ ] Are constraints (length, style, tone) included if needed?
- [ ] Is the prompt specific rather than vague?
- [ ] Have I provided necessary input data?
- [ ] Can I predict roughly what a good response looks like?

---

## 🚫 Common Mistakes to Avoid

### 1. **Vague Instructions**
❌ "Make it better"
✅ "Improve code readability by adding comments and using descriptive variable names"

### 2. **Assuming Context**
❌ "What should I do next?" (model doesn't know what you're working on)
✅ "I'm building a REST API in Node.js. I've set up Express and defined routes. What should I do next to add authentication?"

### 3. **Overly Complex Single Prompts**
❌ One massive prompt trying to do 10 things
✅ Break into multiple focused prompts or use [[chain-of-thought]]

### 4. **No Output Format**
❌ "Tell me about Python data structures"
✅ "Explain Python's main data structures (list, dict, set, tuple) in a comparison table with columns: Name, Use Case, Example"

### 5. **Ignoring Failed Attempts**
Don't just try again with the same prompt. Analyze why it failed and refine.

---

## 🎯 Practice Exercises

### Exercise 1: Clarity
Improve this vague prompt:
```
Tell me about programming
```

### Exercise 2: Context
Add context to this prompt:
```
How do I fix this error?
```

### Exercise 3: Format Specification
Make this prompt produce structured output:
```
What are the benefits of TypeScript?
```

### Exercise 4: Constraints
Add appropriate constraints:
```
Explain neural networks
```

---

## 🔗 Next Steps

Once you've mastered the basics:

1. **[[system-prompts]]** - Learn to configure model behavior at the system level
2. **[[few-shot-prompting]]** - Provide examples to guide model responses
3. **[[chain-of-thought]]** - Enable complex reasoning through step-by-step thinking
4. **[[zero-shot-prompting]]** - Leverage model's existing knowledge without examples

---

## 📚 Additional Resources

### Internal Documentation
- **[[techniques/prompting/README|Prompting Overview]]** - Main prompting techniques hub
- **[[exercises/]]** - Hands-on practice with prompts

### Related Concepts
- **[[RAG]]** - Enhance prompts with external knowledge
- **[[tools/coding-assistants/README]]** - Apply prompting with coding tools

---

## 💡 Pro Tips

1. **Start Simple**: Begin with basic prompts and add complexity as needed
2. **Test Variations**: Try different phrasings to see what works best
3. **Document Success**: Keep a library of prompts that work well
4. **Learn from Failures**: Analyze why prompts don't work and adjust
5. **Model-Specific**: Different models may respond better to different styles

---

## 🎓 Remember

> "A good prompt gives the model a clear task, enough context to complete it accurately, and a defined output structure. If you can predict what the response will look like before running it, your prompt is well-designed."

**Key Insight**: Clear structure and context matter more than clever wording—most prompt failures come from ambiguity, not model limitations.

---

*Last Updated: 2025-12-01*
*Part of the Techniques → Prompting section*
