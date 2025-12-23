# Few-Shot Prompting

Few-shot prompting is a technique where you provide the model with a small number of examples (typically 2-5) that demonstrate the desired input-output pattern. The model learns from these examples and applies the pattern to new inputs.

---

## 🎯 What is Few-Shot Prompting?

**Few-shot prompting** provides demonstrations in the prompt to steer the model toward better performance. The examples serve as conditioning for subsequent tasks where you want the model to generate a response.

### The Shot Spectrum

- **Zero-Shot**: No examples, model relies on pre-trained knowledge
- **One-Shot**: Single example to demonstrate the pattern
- **Few-Shot**: Multiple examples (typically 2-5) to establish the pattern
- **Many-Shot**: Many examples (>5), approaching fine-tuning territory

---

## 🎯 When to Use Few-Shot Prompting

### ✅ Use Few-Shot When:

1. **Complex domain-specific tasks** with varied inputs that need accurate outputs
2. **Precisely structured outputs** in JSON, YAML, or custom formats
3. **Consistent tone or style** is required (e.g., brand voice, technical writing)
4. **Pattern matching** where the transformation isn't obvious from description alone
5. **Classification tasks** with specific categories
6. **Template-based generation** with specific structure

### ❌ Skip Few-Shot When:

1. Task is simple and well-understood (e.g., "translate to Spanish")
2. Zero-shot already produces good results
3. You have very limited context window space
4. Examples would be harder to create than instructions

---

## 🏗️ Basic Structure

```
[Optional: Task description]

Example 1:
Input: [input 1]
Output: [output 1]

Example 2:
Input: [input 2]
Output: [output 2]

Example 3:
Input: [input 3]
Output: [output 3]

Now solve:
Input: [new input]
Output:
```

---

## 📋 Few-Shot Patterns

### Pattern 1: Simple Input-Output

```
Convert casual language to formal business language:

Example 1:
Input: "Hey, can you send that report ASAP?"
Output: "Could you please send the report at your earliest convenience?"

Example 2:
Input: "The meeting was kinda boring tbh"
Output: "The meeting did not fully meet expectations."

Example 3:
Input: "Great job on the project!"
Output: "Excellent work on the project."

Now convert:
Input: "Let's touch base next week"
Output:
```

### Pattern 2: Classification

```
Classify customer feedback as: Positive, Negative, or Neutral

Example 1:
Feedback: "The product arrived quickly and works perfectly!"
Classification: Positive

Example 2:
Feedback: "Terrible experience, nothing worked as advertised."
Classification: Negative

Example 3:
Feedback: "It's okay, does what it says but nothing special."
Classification: Neutral

Classify this:
Feedback: "Fast shipping but the instructions were unclear."
Classification:
```

### Pattern 3: Structured Output (JSON)

```
Extract key information from support tickets and format as JSON:

Example 1:
Ticket: "My order #12345 hasn't arrived. I paid for express shipping last Monday."
Output:
{
  "order_id": "12345",
  "issue_type": "delivery_delay",
  "shipping_type": "express",
  "date_mentioned": "last Monday",
  "urgency": "medium"
}

Example 2:
Ticket: "URGENT: Cannot log into my account. Keep getting error 403."
Output:
{
  "order_id": null,
  "issue_type": "login_failure",
  "error_code": "403",
  "urgency": "high"
}

Example 3:
Ticket: "Just wanted to say thank you for the excellent customer service!"
Output:
{
  "order_id": null,
  "issue_type": "positive_feedback",
  "urgency": "low"
}

Extract from this ticket:
Ticket: "My subscription renewal failed three times. Order #67890."
Output:
```

### Pattern 4: Text Transformation

```
Summarize technical documentation in one sentence for non-technical audiences:

Example 1:
Technical: "The REST API endpoint accepts POST requests with JSON payloads
containing user credentials and returns a JWT token for authentication in
subsequent requests."
Summary: The system accepts your login information and gives you a special
code to prove who you are for future actions.

Example 2:
Technical: "Database replication uses asynchronous primary-replica topology
with eventual consistency guarantees."
Summary: Data is copied to backup systems automatically, though there may
be a small delay before all copies are identical.

Example 3:
Technical: "The cache layer implements LRU eviction policy with configurable
TTL values."
Summary: The system remembers frequently-used information and automatically
forgets old data to save space.

Summarize this:
Technical: "WebSocket connections enable full-duplex communication channels
over a single TCP connection."
Summary:
```

---

## 💡 Best Practices

### 1. **Quality Over Quantity**
- 2-3 high-quality examples often work better than 5+ mediocre ones
- Each example should clearly demonstrate the pattern

### 2. **Diverse Examples**
Include variety to cover edge cases:
```
✅ Good: Examples showing different input lengths, edge cases, variations
❌ Bad: All examples too similar, no edge cases covered
```

### 3. **Representative Examples**
Choose examples that represent real use cases:
```
✅ "Server timeout after 30 seconds" → Technical issue
✅ "Love the new feature!" → Positive feedback
❌ "Test input" → Generic test
```

### 4. **Consistent Format**
Maintain identical structure across all examples:
```
✅ All examples follow: Input: ... Output: ...
❌ First example uses "Q:" but second uses "Question:"
```

### 5. **Clear Delimiters**
Separate examples clearly:
```
✅ Use blank lines, headers, or explicit numbering
❌ Run examples together without clear boundaries
```

### 6. **Order Matters**
- Start with simple, clear examples
- Progress to more complex edge cases
- End with an example most similar to expected inputs

---

## 🎨 Advanced Techniques

### Technique 1: Few-Shot with Instructions

Combine explicit instructions with examples:

```
Task: Extract action items from meeting notes. Format as a checklist
with assigned person and due date.

Example 1:
Notes: "John agreed to send the proposal by Friday. Sarah will review it
over the weekend."
Action Items:
- [ ] Send proposal - @John - Due: Friday
- [ ] Review proposal - @Sarah - Due: Weekend

Example 2:
Notes: "We need to fix the login bug ASAP. Mike volunteered to handle it
today."
Action Items:
- [ ] Fix login bug - @Mike - Due: Today (High Priority)

Now extract from:
Notes: "Emily will schedule the client call for next Tuesday. Everyone
should prepare their updates by Monday."
Action Items:
```

### Technique 2: Few-Shot Chain-of-Thought

Show reasoning in examples:

```
Solve math word problems step by step:

Example 1:
Problem: "A store has 24 apples. They sell 3/4 of them. How many remain?"
Reasoning:
- Total apples: 24
- Fraction sold: 3/4
- Apples sold: 24 × 3/4 = 18
- Apples remaining: 24 - 18 = 6
Answer: 6 apples

Example 2:
Problem: "John runs 5km every day for a week. How far does he run in total?"
Reasoning:
- Daily distance: 5km
- Days in a week: 7
- Total distance: 5km × 7 = 35km
Answer: 35km

Solve this:
Problem: "A book has 240 pages. You read 1/3 on Monday and 1/4 on Tuesday.
How many pages are left?"
Reasoning:
```

### Technique 3: Few-Shot with Context

Provide role/context plus examples:

```
You are a customer support specialist for a SaaS company. Respond to
customer emails professionally and helpfully.

Example 1:
Customer: "I can't access my account!"
Response: "I understand how frustrating that must be. I'd be happy to help
you regain access. Could you please provide your account email address so
I can look into this for you? In the meantime, you can try resetting your
password at [link]."

Example 2:
Customer: "This feature is broken and I'm very disappointed."
Response: "I sincerely apologize for the trouble you're experiencing. Your
feedback is important to us. Could you share more details about what's not
working as expected? This will help our team resolve the issue quickly.
What specific feature are you trying to use?"

Respond to:
Customer: "When will the new update be released?"
Response:
```

### Technique 4: Few-Shot Style Transfer

Teach specific writing styles:

```
Rewrite sentences in the style of technical documentation:

Example 1:
Original: "Click the button to make it work."
Technical: "Activate the functionality by selecting the designated action
button."

Example 2:
Original: "It'll save your stuff automatically."
Technical: "The system implements automatic persistence of user data."

Example 3:
Original: "You can undo mistakes easily."
Technical: "The interface provides rollback capabilities for error
correction."

Rewrite this:
Original: "The app shows you when things go wrong."
Technical:
```

---

## 📊 Few-Shot vs. Alternatives

| Approach | Examples | Best For | Token Cost |
|----------|----------|----------|------------|
| **Zero-Shot** | 0 | Simple, well-known tasks | Lowest |
| **One-Shot** | 1 | Quick pattern demonstration | Low |
| **Few-Shot** | 2-5 | Complex patterns, consistency | Medium |
| **Many-Shot** | 5+ | Very specific patterns | High |
| **Fine-tuning** | Hundreds+ | Permanent behavior change | One-time cost |

---

## 🔧 Practical Examples

### Example 1: Code Comment Generation

```
Generate concise, helpful code comments:

Example 1:
Code: `users = users.filter(user => user.age >= 18)`
Comment: // Keep only adult users (18+)

Example 2:
Code: `const hash = await bcrypt.hash(password, 10)`
Comment: // Hash password with salt rounds of 10 for security

Example 3:
Code: `cache.set(key, value, { ttl: 3600 })`
Comment: // Cache value for 1 hour (3600 seconds)

Generate comment for:
Code: `const debounced = _.debounce(handleInput, 300)`
Comment:
```

### Example 2: Sentiment Analysis with Nuance

```
Analyze sentiment with intensity (1-5 scale where 1=very negative, 5=very positive):

Example 1:
Text: "This is the best product I've ever used! Absolutely amazing!"
Sentiment: Positive (5/5)

Example 2:
Text: "It's okay, nothing special but gets the job done."
Sentiment: Neutral (3/5)

Example 3:
Text: "Disappointed with the quality. Expected better for the price."
Sentiment: Negative (2/5)

Example 4:
Text: "Complete waste of money. Broke after two days."
Sentiment: Very Negative (1/5)

Analyze:
Text: "Works well most of the time, though occasionally has issues."
Sentiment:
```

### Example 3: Data Extraction

```
Extract structured data from natural language:

Example 1:
Text: "Schedule a meeting with John Smith at 2pm tomorrow in Conference Room A"
Extracted:
- Action: Schedule meeting
- Participant: John Smith
- Time: 2pm tomorrow
- Location: Conference Room A

Example 2:
Text: "Remind me to call the client next Monday morning"
Extracted:
- Action: Set reminder
- Task: Call client
- Time: Next Monday morning
- Location: N/A

Example 3:
Text: "Book flight to NYC for December 15th, returning on the 20th"
Extracted:
- Action: Book flight
- Destination: NYC
- Departure: December 15th
- Return: December 20th

Extract from:
Text: "Send the quarterly report to the board by end of week"
Extracted:
```

---

## ⚠️ Common Pitfalls

### 1. **Too Many Examples**
❌ 10+ examples consuming most of your context window
✅ 3-5 carefully chosen representative examples

### 2. **Inconsistent Format**
❌ Each example uses different structure
✅ All examples follow identical format

### 3. **Overly Similar Examples**
❌ All examples are minor variations of each other
✅ Examples show range of inputs and edge cases

### 4. **No Edge Cases**
❌ Only showing perfect/typical cases
✅ Include at least one edge case example

### 5. **Unclear Delimiters**
❌ Examples run together without clear separation
✅ Clear visual separation between examples

---

## 🎓 Measuring Few-Shot Effectiveness

Test your few-shot prompts:

### Metrics to Track
1. **Accuracy**: Does output match expected format/content?
2. **Consistency**: Similar inputs → similar outputs?
3. **Edge Case Handling**: Does it work on unusual inputs?
4. **Efficiency**: Could fewer examples achieve the same result?

### A/B Testing
Compare different example sets:
```
Set A: 3 simple examples
Set B: 3 examples including edge cases
Set C: 5 examples with more variety

Test on same inputs → measure quality
```

---

## 🔗 Related Techniques

- **[[zero-shot-prompting]]** - When you don't need examples
- **[[chain-of-thought]]** - Combine with few-shot for reasoning tasks
- **[[basics]]** - Foundation of prompt engineering
- **[[system-prompts]]** - Combine with system-level configuration

---

## 💡 Key Takeaways

1. **Few-shot bridges the gap** between zero-shot and fine-tuning
2. **Quality examples matter more** than quantity
3. **Consistency is critical** - maintain format across all examples
4. **Start with 2-3 examples** and add more only if needed
5. **Include edge cases** to improve robustness
6. **Test systematically** to verify effectiveness

---

## 🚀 Quick Decision Tree

```
Need consistent output format? → Yes → Try few-shot
Working on domain-specific task? → Yes → Try few-shot
Zero-shot already works well? → Yes → Stick with zero-shot
Have < 100 tokens available? → Yes → Use zero-shot
Complex multi-step reasoning? → Yes → Combine with chain-of-thought
```

---

## 💡 Remember

> "Few-shot prompting is about showing, not telling. Three good examples often teach the model more effectively than a paragraph of instructions."

**Pro Tip**: If you find yourself writing complex instructions, consider replacing them with clear examples instead. The model often learns patterns more reliably from demonstrations than from descriptions.

---

*Last Updated: 2025-12-01*
*Part of the Techniques → Prompting section*

**Sources:**
- [Few-Shot Prompting Guide](https://www.promptingguide.ai/techniques/fewshot)
- [Prompt Engineering 101: Zero-Shot, One-Shot, and Few-Shot](https://www.codecademy.com/article/prompt-engineering-101-understanding-zero-shot-one-shot-and-few-shot)
- [The Few Shot Prompting Guide](https://www.prompthub.us/blog/the-few-shot-prompting-guide)
