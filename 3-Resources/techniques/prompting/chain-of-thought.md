# Chain-of-Thought Prompting

Chain-of-Thought (CoT) prompting is an advanced technique that encourages AI models to show their reasoning process through intermediate steps before producing a final answer. It's particularly effective for complex reasoning tasks, math problems, logic puzzles, and multi-step decision-making.

---

## 🎯 What is Chain-of-Thought Prompting?

**Chain-of-Thought prompting** enables complex reasoning by having the model explicitly work through intermediate reasoning steps rather than jumping directly to an answer. This approach:

- **Improves accuracy** on complex tasks requiring multi-step reasoning
- **Makes reasoning transparent** so you can verify the logic
- **Reduces errors** by catching mistakes in intermediate steps
- **Handles complexity better** than direct answer approaches

---

## 🎨 Basic CoT Patterns

### Pattern 1: Zero-Shot CoT

The simplest form - just add "Let's think step by step":

```
Question: If John has 5 apples and gives 2 to Mary, then buys 3 more,
how many apples does he have?

Let's think step by step:

[Model generates reasoning steps automatically]
```

**How it works:** The phrase "Let's think step by step" (or variations) triggers the model to break down its reasoning naturally.

### Pattern 2: Few-Shot CoT

Provide examples that include reasoning steps:

```
Question: A bakery made 24 cookies and sold 3/4 of them. How many are left?
Reasoning:
- Total cookies: 24
- Fraction sold: 3/4
- Cookies sold: 24 × 3/4 = 18
- Cookies remaining: 24 - 18 = 6
Answer: 6 cookies

Question: Sarah runs 5km daily. How far does she run in 2 weeks?
Reasoning:
- Daily distance: 5km
- Days in 2 weeks: 14
- Total distance: 5km × 14 = 70km
Answer: 70km

Question: A store has 100 items. 40% are sold on Monday, 30% on Tuesday.
How many remain?
Reasoning:
```

---

## 🏗️ CoT Structure Templates

### Template 1: Math Problem Solving

```
Problem: [Math problem statement]

Solution approach:
Step 1: Identify known values
[List what we know]

Step 2: Determine what we need to find
[State the goal]

Step 3: Choose appropriate method
[Explain approach]

Step 4: Calculate step by step
[Show calculations]

Step 5: Verify the answer
[Check if it makes sense]

Final Answer: [Result]
```

### Template 2: Logical Reasoning

```
Statement: [Logical problem or scenario]

Analysis:
1. Understand the given information
   [Break down what's stated]

2. Identify relevant rules or constraints
   [List applicable conditions]

3. Consider implications
   [What follows from the given information?]

4. Test possibilities
   [Evaluate different scenarios]

5. Draw conclusion
   [Logical conclusion based on analysis]

Conclusion: [Final answer]
```

### Template 3: Decision Making

```
Decision: [Decision to be made]

Evaluation Process:

1. Define objectives
   [What are we trying to achieve?]

2. List options
   [What choices are available?]

3. Evaluate pros and cons
   Option A: [Pros] | [Cons]
   Option B: [Pros] | [Cons]

4. Consider constraints
   [Time, budget, resources, etc.]

5. Weigh trade-offs
   [Which factors matter most?]

6. Make recommendation
   [Chosen option with justification]

Recommendation: [Final decision]
```

---

## 💡 CoT Variations and Techniques

### 1. Zero-Shot CoT

**Trigger Phrases:**
- "Let's think step by step"
- "Let's work through this logically"
- "Let's break this down"
- "First, let's understand what we know"
- "Let's approach this systematically"

**Example:**
```
Question: Which is larger: 3/7 or 5/12?

Let's think step by step:
```

**Strengths:**
- No examples needed
- Works out of the box
- Saves context window space
- Good for straightforward reasoning

**Limitations:**
- Less control over reasoning format
- May not match your specific needs
- Quality varies by task complexity

### 2. Few-Shot CoT

**Provide examples with reasoning:**

```
Q: A train travels 60 km in 45 minutes. What's its speed in km/h?
Reasoning:
- Distance: 60 km
- Time: 45 minutes = 45/60 hours = 0.75 hours
- Speed = Distance / Time
- Speed = 60 / 0.75 = 80 km/h
A: 80 km/h

Q: If you buy 3 notebooks at $4 each and pay with a $20 bill, what's your change?
Reasoning:
- Cost per notebook: $4
- Number of notebooks: 3
- Total cost: 3 × $4 = $12
- Amount paid: $20
- Change: $20 - $12 = $8
A: $8

Q: A rectangle is 12cm long and 8cm wide. What's its area and perimeter?
Reasoning:
```

**Strengths:**
- Precise control over reasoning style
- Shows exact format you want
- Teaches specific problem-solving approaches
- More consistent outputs

**Limitations:**
- Requires creating examples
- Uses more context window
- Examples must match task type

### 3. Self-Consistency CoT

Generate multiple reasoning paths and choose the most consistent answer:

```
Problem: [Problem statement]

Solution Path 1:
[Reasoning approach 1]
Answer: X

Solution Path 2:
[Alternative reasoning approach]
Answer: X

Solution Path 3:
[Another approach]
Answer: Y

Consistency check:
Paths 1 and 2 both arrive at X using different methods.
Path 3 arrives at Y.
Most consistent answer: X

Final Answer: X
```

**How to implement:**
1. Generate 3-5 different reasoning paths (multiple API calls with temperature > 0)
2. Extract final answer from each path
3. Select the most frequent answer (majority voting)

**Strengths:**
- Significantly improves accuracy
- Catches reasoning errors
- Works well on complex problems

**Limitations:**
- Requires multiple API calls (higher cost)
- Slower response time
- More complex to implement

### 4. Least-to-Most Prompting

Break problems into smaller sub-problems:

```
Complex Problem: [Large, multi-step problem]

Step 1: Identify sub-problems
- Sub-problem 1: [Smaller component]
- Sub-problem 2: [Another component]
- Sub-problem 3: [Final component]

Step 2: Solve sub-problems sequentially
Sub-problem 1 solution:
[Solve first part]

Sub-problem 2 solution (using result from 1):
[Solve second part]

Sub-problem 3 solution (using previous results):
[Solve final part]

Step 3: Combine solutions
[Integrate all sub-problem solutions]

Final Answer: [Complete solution]
```

### 5. Program-Aided CoT

Combine reasoning with code execution:

```
Problem: Calculate compound interest on $1000 at 5% annual rate for 3 years.

Reasoning:
- Principal (P): $1000
- Rate (r): 5% = 0.05
- Time (t): 3 years
- Formula: A = P(1 + r)^t

Let's calculate using code:

```python
principal = 1000
rate = 0.05
time = 3
amount = principal * (1 + rate) ** time
interest = amount - principal
print(f"Amount: ${amount:.2f}")
print(f"Interest: ${interest:.2f}")
```

Result: $1157.63 (Interest: $157.63)
```

---

## 🎯 When to Use CoT

### ✅ Use CoT For:

1. **Math and arithmetic problems**
   - Word problems
   - Multi-step calculations
   - Unit conversions

2. **Logical reasoning**
   - Deduction tasks
   - If-then scenarios
   - Constraint satisfaction

3. **Multi-step processes**
   - Sequential tasks
   - Decision trees
   - Complex workflows

4. **Analysis tasks**
   - Comparing options
   - Evaluating trade-offs
   - Root cause analysis

5. **Debugging and troubleshooting**
   - Identifying error sources
   - Systematic problem diagnosis

### ❌ Skip CoT For:

1. **Simple, direct questions**
   - Factual lookups
   - Definitions
   - Single-step operations

2. **Creative generation**
   - Writing poetry
   - Brainstorming ideas
   - Creative storytelling

3. **Tasks where reasoning doesn't help**
   - Pure recall
   - Simple classifications
   - Straightforward transformations

---

## 📊 CoT Best Practices

### 1. **Use Clear Delimiters**

Separate reasoning from answers:

```
✅ Good:
Reasoning:
[Steps]
Answer: [Result]

❌ Bad:
[Mixed reasoning and answer with no clear structure]
```

### 2. **Explicit Step Markers**

Number or label each step:

```
✅ Good:
Step 1: [First step]
Step 2: [Second step]
Step 3: [Final step]

❌ Bad:
[Unmarked steps flowing together]
```

### 3. **Show All Intermediate Values**

Make calculations explicit:

```
✅ Good:
- Total: 24
- Sold: 24 × 0.75 = 18
- Remaining: 24 - 18 = 6

❌ Bad:
- We sold most of them, so 6 are left
```

### 4. **Verify Logic at Each Step**

Include sanity checks:

```
Step 3: Calculate profit
Revenue: $10,000
Costs: $7,000
Profit: $10,000 - $7,000 = $3,000
✓ Check: Profit is positive, which makes sense
```

### 5. **Use Appropriate Granularity**

Match detail level to problem complexity:

```
Simple problem: 3-4 steps
Complex problem: 5-10 steps
Very complex: Break into sub-problems first
```

---

## 🔧 Practical Examples

### Example 1: Code Debugging with CoT

```
Code with error:
```python
def calculate_average(numbers):
    total = sum(numbers)
    return total / len(numbers)

result = calculate_average([])
print(result)
```

Debug using CoT:

Step 1: Identify the error
- Error: Division by zero when list is empty
- Line: `return total / len(numbers)`

Step 2: Analyze why it happens
- `len([])` returns 0
- Dividing by 0 causes ZeroDivisionError

Step 3: Determine fix approach
- Add validation before calculation
- Return appropriate value for empty list

Step 4: Implement solution
```python
def calculate_average(numbers):
    if not numbers:  # Check if list is empty
        return 0  # or raise ValueError, depending on requirements
    total = sum(numbers)
    return total / len(numbers)
```

Step 5: Verify fix
- Empty list: Returns 0 (safe)
- Normal list: Works as before
- Edge case handled ✓
```

### Example 2: System Design Decision with CoT

```
Question: Should we use a monolithic architecture or microservices for a
new e-commerce platform?

Analysis:

Step 1: Understand requirements
- Team size: 5 developers
- Expected traffic: 1000 users initially
- Time to market: 3 months
- Budget: Limited startup budget

Step 2: Evaluate monolithic approach
Pros:
+ Simpler to develop and deploy
+ Easier debugging and testing
+ Lower operational overhead
+ Faster initial development
Cons:
- Harder to scale specific components
- Technology lock-in
- Risk of tight coupling

Step 3: Evaluate microservices approach
Pros:
+ Independent scaling
+ Technology flexibility
+ Better fault isolation
Cons:
- Higher complexity
- Requires more infrastructure
- Slower initial development
- Needs experienced team

Step 4: Consider constraints
- Small team → favors simplicity
- Tight timeline → favors faster development
- Limited budget → favors lower ops cost
- Initial scale → doesn't require distributed system

Step 5: Make recommendation
Given constraints, monolithic architecture is more appropriate:
1. Faster to market (meets 3-month deadline)
2. Matches team size and experience
3. Lower operational costs
4. Can migrate to microservices later if needed

Recommendation: Start with monolithic architecture, design with loose
coupling to enable future migration if growth demands it.
```

### Example 3: Data Analysis with CoT

```
Dataset: User signup trends
- January: 100 signups
- February: 120 signups
- March: 90 signups
- April: 150 signups

Question: What's the trend and should we be concerned about March?

Analysis:

Step 1: Calculate growth rates
- Jan to Feb: (120-100)/100 = 20% increase
- Feb to Mar: (90-120)/120 = -25% decrease
- Mar to Apr: (150-90)/90 = 67% increase

Step 2: Identify patterns
- Overall trajectory: Upward (100 → 150)
- March is an outlier: Significant drop
- April shows strong recovery: Exceeds previous peak

Step 3: Consider external factors
- March might have external causes:
  - Seasonal variation?
  - Product issues?
  - Marketing campaign ended?
  - Competition launched?

Step 4: Calculate overall trend
- Average monthly signups: (100+120+90+150)/4 = 115
- Q1 total: 310 signups
- Trend line: Generally positive despite March dip

Step 5: Form conclusion
- Overall trend: Positive growth
- March concern: Worth investigating, but...
- April recovery: Suggests March was anomaly
- Action: Monitor May data and investigate March causes

Conclusion: No immediate concern given strong recovery, but investigate
March drop to prevent recurrence.
```

---

## ⚡ CoT Performance Tips

### Optimization Strategies

1. **Balance detail vs. context**
   - More steps = better reasoning but more tokens
   - Find sweet spot for your use case

2. **Use structured formats**
   - Bullet points for clarity
   - Numbered steps for sequence
   - Tables for comparisons

3. **Combine with other techniques**
   - CoT + Few-Shot: Show reasoning examples
   - CoT + System Prompts: Set reasoning standards
   - CoT + Self-Consistency: Improve accuracy

4. **Cache reasoning patterns**
   - Save successful reasoning structures
   - Reuse for similar problems
   - Build library of CoT templates

---

## 📈 Measuring CoT Effectiveness

### Metrics to Track

1. **Accuracy**: How often is the final answer correct?
2. **Reasoning Quality**: Are intermediate steps logical?
3. **Error Detection**: Can you spot mistakes in reasoning?
4. **Efficiency**: Token usage vs. accuracy improvement

### A/B Testing

```
Control (Direct): Simple prompt → measure accuracy
Treatment (CoT): Same prompt with CoT → measure accuracy

If CoT accuracy > Control accuracy + [threshold]:
    Use CoT (worth the extra tokens)
Else:
    Stick with direct prompting
```

---

## 🔗 Related Techniques

- **[[few-shot-prompting]]** - Combine with CoT for better examples
- **[[zero-shot-prompting]]** - Simpler alternative for basic tasks
- **[[basics]]** - Foundation of prompt engineering
- **[[meta-prompting]]** - Advanced reasoning optimization

---

## 💡 Key Takeaways

1. **CoT excels at complex reasoning** tasks requiring multiple steps
2. **Zero-shot CoT is easiest** - just add "Let's think step by step"
3. **Few-shot CoT gives more control** over reasoning format
4. **Self-consistency improves accuracy** at the cost of multiple API calls
5. **Show intermediate steps explicitly** for transparency
6. **Not all tasks benefit from CoT** - use when reasoning helps

---

## 🚀 Quick Start Guide

**Want to try CoT?**

1. **Start simple**: Add "Let's think step by step" to your existing prompts
2. **Test on a few examples**: Does reasoning improve answers?
3. **If yes**: Consider few-shot CoT for more control
4. **If accuracy matters**: Try self-consistency
5. **Optimize**: Find the right balance of detail for your use case

---

## 💡 Remember

> "Chain-of-thought prompting makes the model 'show its work' like a student solving a math problem. This transparency catches errors and improves accuracy on complex tasks."

**Pro Tip**: When debugging why a model gave a wrong answer, adding CoT often reveals exactly where the reasoning went wrong, making it much easier to fix the prompt.

---

*Last Updated: 2025-12-01*
*Part of the Techniques → Prompting section*

**Sources:**
- [Chain-of-Thought Prompting Guide](https://www.promptingguide.ai/techniques/cot)
- [Chain-of-Thought Prompting: Techniques and Tips](https://www.helicone.ai/blog/chain-of-thought-prompting)
- [Prompt Engineering Best Practices 2025](https://garrettlanders.com/prompt-engineering-guide-2025/)
