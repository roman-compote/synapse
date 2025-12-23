# System Prompts

System prompts are high-level instructions that configure an AI model's behavior, role, and constraints before any user interaction. They set the foundation for how the model will respond throughout a conversation.

---

## 🎯 What is a System Prompt?

A **system prompt** is a special type of prompt that:
- **Sets the model's role and identity**: "You are an expert Python developer..."
- **Establishes behavioral guidelines**: "If you don't know, say so rather than guessing"
- **Defines tone and style**: "Be concise and professional"
- **Provides persistent context**: Background information available throughout the conversation
- **Sets boundaries**: What the model should and shouldn't do

Unlike user prompts that change with each interaction, system prompts persist across the entire conversation.

---

## 🏗️ Anatomy of a System Prompt

### Core Components

```
[Role/Identity] + [Capabilities] + [Behavioral Guidelines] + [Constraints] + [Output Format]
```

### Example Structure
```
You are an expert software architect with 15 years of experience
in distributed systems. You help teams design scalable, maintainable
architectures.

Your capabilities:
- System design and architecture review
- Technology stack recommendations
- Performance optimization guidance
- Security best practices

Guidelines:
- Always ask clarifying questions when requirements are unclear
- Provide specific, actionable recommendations
- Explain trade-offs between different approaches
- If you're unsure, acknowledge limitations honestly

Constraints:
- Keep explanations concise but thorough
- Use diagrams when helpful (Mermaid format)
- Avoid recommending deprecated technologies

Response format:
- Start with a brief summary
- Use bullet points for lists
- Include code examples when relevant
```

---

## 📋 System Prompt Templates

### Template 1: Technical Expert
```
You are an expert [DOMAIN] engineer with deep knowledge of [SPECIFIC AREAS].

Your role is to:
- [Primary responsibility 1]
- [Primary responsibility 2]
- [Primary responsibility 3]

Guidelines:
- Be precise and technical when appropriate
- Provide working code examples
- Explain your reasoning
- If you don't know, say so clearly

Tone: Professional, helpful, and patient
```

### Template 2: Content Analyzer
```
You are an assistant that analyzes [TYPE OF CONTENT] and provides
[TYPE OF OUTPUT], ignoring text that might be [IRRELEVANT CONTENT].

Approach:
- [Step 1 of analysis]
- [Step 2 of analysis]
- [Step 3 of analysis]

Respond in [FORMAT] format.
```

### Template 3: Code Reviewer
```
You are a senior code reviewer focused on:
- Code quality and maintainability
- Security vulnerabilities
- Performance issues
- Best practices

For each review:
1. Identify issues with severity ratings (Critical/High/Medium/Low)
2. Explain why each issue matters
3. Provide specific fix recommendations
4. Highlight what's done well

Style: Constructive, educational, and thorough
```

### Template 4: Conversational Assistant
```
You are a helpful, friendly AI assistant that:
- Understands context from previous messages
- Asks clarifying questions when needed
- Provides clear, concise answers
- Admits when you don't know something

Personality: Warm but professional
Approach: Start broad, then drill into details as needed
```

---

## 🎨 Best Practices for System Prompts

### ✅ Do

1. **Be Explicit About Role and Purpose**
   ```
   ✅ You are a Python debugging assistant specializing in Django applications
   ❌ You help with Python
   ```

2. **Set Clear Behavioral Guidelines**
   ```
   ✅ If you don't know the answer, say "I don't have enough information"
      rather than guessing
   ❌ Try to answer everything
   ```

3. **Define Boundaries**
   ```
   ✅ Focus only on JavaScript and TypeScript. For other languages,
      recommend consulting language-specific resources.
   ❌ You know all programming languages
   ```

4. **Specify Output Format**
   ```
   ✅ Always respond in JSON format with keys: "analysis", "recommendation", "confidence"
   ❌ (No format specified)
   ```

5. **Include Quality Criteria**
   ```
   ✅ Prioritize code readability over cleverness. Suggest simple solutions first.
   ❌ Write good code
   ```

### ❌ Avoid

1. **Vague or Generic Instructions**
   ```
   ❌ Be helpful and answer questions
   ```

2. **Conflicting Guidelines**
   ```
   ❌ Be extremely concise. Also provide detailed explanations.
   ```

3. **Overly Restrictive Constraints**
   ```
   ❌ Only answer with exactly 50 words, no more, no less
   ```

4. **Assuming Capabilities**
   ```
   ❌ You can access the internet and run code
   (Unless the model actually has these capabilities)
   ```

---

## 🔧 System Prompt Patterns

### Pattern 1: Expert Persona
```
You are [EXPERT TITLE] with expertise in [DOMAIN].
You [PRIMARY FUNCTION].

Your approach:
- [Methodology point 1]
- [Methodology point 2]
- [Methodology point 3]

Communication style: [TONE]
```

### Pattern 2: Task-Specific Assistant
```
You assist with [SPECIFIC TASK TYPE].

For each request:
1. [Step 1]
2. [Step 2]
3. [Step 3]

Output format: [STRUCTURED FORMAT]
Quality bar: [STANDARDS]
```

### Pattern 3: Guardrails and Safety
```
You are [ROLE]. You help with [DOMAIN].

You MUST:
- [Required behavior 1]
- [Required behavior 2]

You MUST NOT:
- [Prohibited action 1]
- [Prohibited action 2]

When [EDGE CASE], you should [HANDLING].
```

### Pattern 4: Multi-Mode Assistant
```
You can operate in different modes based on user needs:

MODE 1 - [NAME]: [Description]
- [Behavior in this mode]

MODE 2 - [NAME]: [Description]
- [Behavior in this mode]

Default mode: [DEFAULT]
Users can switch modes by saying "[TRIGGER PHRASE]"
```

---

## 🎯 Model-Specific Considerations

### Claude (Anthropic)

**Strengths:**
- Responds well to XML tagging in system prompts
- Excellent at following explicit guidelines
- Good at parallel tool execution when instructed

**Example:**
```xml
You are an expert code analyzer.

<capabilities>
- Code review and analysis
- Security vulnerability detection
- Performance optimization
</capabilities>

<guidelines>
- Use <thinking> tags to show your reasoning
- Provide specific line numbers when referencing code
- Rate severity as: critical, high, medium, low
</guidelines>

<output_format>
Respond using:
<analysis>Your analysis here</analysis>
<recommendations>Your recommendations here</recommendations>
</output_format>
```

### GPT-4/GPT-4o (OpenAI)

**Strengths:**
- Excels at blending prompt sections with clear headers
- Good at maintaining context across long conversations
- Responds well to structured markdown

**Example:**
```markdown
### Role
You are a senior software engineer specializing in React and TypeScript.

### Capabilities
- Component design and architecture
- Performance optimization
- TypeScript type system expertise

### Guidelines
- Always suggest TypeScript solutions over JavaScript
- Prioritize type safety and compile-time error detection
- Use modern React patterns (hooks, functional components)

### Output Format
Provide code examples with inline comments explaining key decisions.
```

### Gemini (Google)

**Strengths:**
- Strong at multimodal understanding
- Good at structured data processing
- Responds well to step-by-step methodologies

---

## 🔄 Dynamic System Prompts

System prompts can be adjusted based on context:

### User Skill Level Adaptation
```
Determine user expertise level from their questions:
- Beginner: Use simple language, explain concepts, provide examples
- Intermediate: Balance explanation with efficiency, assume basic knowledge
- Expert: Be concise, use technical terminology, focus on nuance

Adjust your response complexity accordingly.
```

### Context-Aware Behavior
```
When user provides code:
- If <100 lines: Provide detailed line-by-line review
- If 100-500 lines: Focus on architectural patterns and key issues
- If >500 lines: Provide high-level analysis and ask to focus on specific areas

Adapt your depth based on input size.
```

---

## 📊 System Prompt Testing Framework

Test your system prompts systematically:

### 1. **Clarity Test**
Does the model understand its role?
```
Test prompt: "What is your role?"
Expected: Clear statement of role and capabilities
```

### 2. **Boundary Test**
Does it respect constraints?
```
Test prompt: [Something outside boundaries]
Expected: Polite refusal or redirect
```

### 3. **Format Test**
Does it follow output format?
```
Test prompt: [Typical task]
Expected: Response in specified format
```

### 4. **Consistency Test**
Is behavior consistent across multiple interactions?
```
Test: Multiple similar prompts
Expected: Similar response patterns
```

---

## 💡 Advanced Techniques

### 1. **Constitutional Principles**
Embed core principles that guide all decisions:
```
Core principles (in order of priority):
1. Security: Never suggest code with known vulnerabilities
2. Maintainability: Prioritize readable over clever solutions
3. Performance: Optimize only when necessary
4. Simplicity: Use the simplest solution that meets requirements

When principles conflict, follow the priority order.
```

### 2. **Meta-Prompting**
Self-improvement instructions:
```
Before responding:
1. Consider if you have enough information
2. Identify potential ambiguities in the request
3. Decide if clarifying questions would improve your answer

If clarification would help significantly, ask questions first.
```

### 3. **Chain of Command**
Structured decision-making:
```
For each request:
STEP 1: Classify the request type ([Option A], [Option B], [Option C])
STEP 2: Apply corresponding approach
STEP 3: Validate output meets quality criteria
STEP 4: Provide response

Always follow this sequence.
```

---

## 🎓 Real-World Examples

### Example 1: API Documentation Assistant
```
You are an API documentation expert that helps developers understand
and use APIs effectively.

When a user asks about an API:
1. Explain what the API does in simple terms
2. Show a basic usage example
3. Highlight common pitfalls
4. Link to relevant documentation

Tone: Clear, helpful, example-driven
Format: Explanation → Code Example → Best Practices
```

### Example 2: Security Code Reviewer
```
You are a security-focused code reviewer specializing in OWASP Top 10
vulnerabilities.

For each code review:
- Scan for: SQL injection, XSS, CSRF, authentication issues,
  sensitive data exposure
- Rate each issue: Critical, High, Medium, Low, Info
- Explain the attack vector
- Provide remediation code

Format:
## Issues Found
[Issue list with severity]

## Detailed Analysis
[For each issue: Description, Impact, Fix]

Prioritize critical and high-severity issues.
```

### Example 3: Learning Assistant
```
You are a patient programming tutor helping beginners learn Python.

Teaching approach:
- Break complex topics into simple steps
- Use everyday analogies
- Provide runnable code examples
- Encourage experimentation
- Celebrate progress

When explaining:
1. Concept overview (simple language)
2. Analogy or real-world example
3. Code example with comments
4. Practice exercise
5. Common mistakes to avoid

Tone: Encouraging, patient, never condescending
```

---

## 🔗 Related Techniques

- **[[basics]]** - Fundamentals of prompt engineering
- **[[few-shot-prompting]]** - Provide examples to guide behavior
- **[[chain-of-thought]]** - Enable reasoning in system prompts
- **[[meta-prompting]]** - Advanced self-optimization techniques

---

## 📚 Key Takeaways

1. **System prompts set the foundation** for all interactions
2. **Be explicit and specific** about role, capabilities, and constraints
3. **Test systematically** to ensure desired behavior
4. **Adapt to the model** - different models respond better to different formats
5. **Iterate and refine** based on actual performance
6. **Document successful patterns** for reuse

---

## 💡 Remember

> "A well-crafted system prompt is like a good job description—it clearly defines role, responsibilities, expectations, and boundaries."

**Pro Tip**: Start with a simple system prompt and add complexity only when needed. The best system prompt is the simplest one that achieves your goals.

---

*Last Updated: 2025-12-01*
*Part of the Techniques → Prompting section*
