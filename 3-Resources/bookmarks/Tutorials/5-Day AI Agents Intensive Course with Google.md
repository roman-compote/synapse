---
title: "5-Day AI Agents Intensive Course with Google"
source: "https://www.kaggle.com/learn-guide/5-day-agents"
author: Google ML Researchers & Engineers
published: 2025-11-10
created: 2025-12-23
processed: 2025-12-23
description: "Hands-on program for learning AI agent foundations, architecture and practical development. Covers models, tools, orchestration, memory and evaluation."
type: course-guide
category: agents
relevance: high
status: processed
tags:
  - "#course"
  - "#agents"
  - "#google"
  - "#kaggle"
  - "#tutorial"
  - "#hands-on"
  - "#mcp"
  - "#gemini"
---
![Kaggle-Mentor3](https://storage.googleapis.com/kaggle-media/Images/AI%20AGENT%20COURSE%20ILLUSTRATION.png)

  
  

#### What is the 5-Day AI Agents Intensive?

The 5-Day AI Agents Intensive course with Google is a hands-on program originally held live from November 10 - 14, 2025. It is now available as a self-paced Kaggle Learn guide so anyone can explore the foundations, architecture and practical development of AI agents.  
  
This course was crafted by Google’s ML researchers and engineers to help developers explore the foundations and practical applications of AI agents. You’ll learn the core components – models, tools, orchestration, memory and evaluation. Finally, you’ll discover how agents move beyond LLM prototypes to become production-ready systems.  
  
Each day blends conceptual deep dives with hands-on examples, codelabs, and live discussions. By the end, you’ll be ready to build, evaluate, and deploy agents that solve real-world problems.

#### Welcome to our Agents Intensive Learn Guide!

![Other Resources](https://storage.googleapis.com/kaggle-media/Images/dark_Kaggle_Tutorials.svg)
- **Day 1 - Introduction to Agents:** Explore the foundational concepts of AI agents, their defining characteristics, and how agentic architectures differ from traditional LLM applications, laying the groundwork for building intelligent, autonomous systems.
- **Day 2 - Agent Tools & Interoperability with Model Context Protocol (MCP):** Dive into the world of tools, understanding how AI agents can "take action" by leveraging external functionalities and APIs, and explore the ease of discovering and using tools offered by the MCP.
- **Day 3 - Context Engineering: Sessions & Memory:** Explore how to build AI agents that can remember past interactions and maintain context. Learn how to implement short-term and long-term memory to create more robust agents capable of handling complex, multi-turn tasks.
- **Day 4 - Agent Quality:** Learn to build robust and reliable AI agents by mastering the critical disciplines of evaluating and improving agents. This session will cover observability, logging, and tracing to provide visibility, alongside key metrics and evaluation strategies to optimize agent performance.
- **Day 5 - Prototype to Production:** Go beyond local testing and learn to deploy and scale AI agents for real-world use. This session will cover the best practices for deploying your agents so that others can use them, including how to create a truly multi-agent system with the Agent2Agent (A2A) Protocol.
![Other Resources](https://storage.googleapis.com/kaggle-media/Images/dark_Kaggle_Tutorials.svg)

Setup Instructions

To ensure you are ready for the course, please complete these essential setup steps:

[Kaggle](https://www.kaggle.com/) account: Sign up for a Kaggle account and [learn how Notebooks work](https://www.youtube.com/watch?v=BPQDZLPtgDc). Make sure to [phone verify](https://www.kaggle.com/settings) your account, it’s necessary for the course’s codelabs.  
 [AI Studio](https://aistudio.google.com/) account: Sign up for an AI Studio account and ensure you can generate an [API key](https://aistudio.google.com/app/apikey).  
 [Kaggle Discord](http://discord.gg/kaggle): Sign up for a Discord account and join us on the Kaggle Discord server to connect and collaborate with fellow learners in this course.

![Other Resources](https://storage.googleapis.com/kaggle-media/Images/dark_YouTube_Tutorials.svg)

Welcome to Day 1.  
  
This whitepaper introduces Al agents. It presents a taxonomy of agent capabilities, emphasizes the need for an Agent Ops discipline for reliability and governance, and discusses the importance of agent interoperability and security through identity and constrained policies.  
  
In the codelabs, you'll be building your first AI agent and your first multi-agent system, using Agent Development Kit (ADK), powered by Gemini, and giving it the ability to use Google Search to answer questions with up-to-date information. In the second codelab, the focus will be on multi-agent systems, where you'll learn how to create teams of specialized agents and explore different architectural patterns.  
  
**Day 1 Assignments**  
  

1\. Complete the Unit 1 – “Introduction to Agents”:
Listen to the [summary podcast episode](https://www.youtube.com/watch?v=zTxvGzpfF-g) for this unit.  
 To complement the podcast, read the [“Introduction to Agents” whitepaper](https://www.kaggle.com/whitepaper-introduction-to-agents)  
 Complete these codelabs on Kaggle:[Build](https://www.kaggle.com/code/kaggle5daysofai/day-1a-from-prompt-to-action) your first agent using Gemini and ADK.  
 [Build](https://www.kaggle.com/code/kaggle5daysofai/day-1b-agent-architectures) your first multi-agent systems using ADK.  
 Make sure you [phone verify](https://www.kaggle.com/settings) your Kaggle account before starting, it's necessary for the codelabs.  
 We also have a [troubleshooting guide](https://www.kaggle.com/code/kaggle5daysofai/day-0-troubleshooting-and-faqs) for the codelabs. Be sure to check there for solutions to common problems.  
 Want to have an [interactive conversation](https://support.google.com/notebooklm/answer/15731776)? Try adding the whitepapers to [NotebookLM](https://notebooklm.google.com/).  
  
\[Optional\]: Watch the recorded [YouTube livestream](https://www.youtube.com/live/ZaUcqznlhv8). [Kanchana Patlolla](https://www.linkedin.com/in/kanchanapatlolla/) and [Anant Nawalgaria](https://www.linkedin.com/in/anant-nawalgaria/) hosted the first livestream on Kaggle’s YouTube channel. They were joined by codelab authors Kristopher Overholt and Hangfei Lin, along with special guests from Google: Alan Blount, Mike Clark, Michael Gerstenhaber, and Antonio Gulli to discuss the assignments and shared insights.

![Other Resources](https://storage.googleapis.com/kaggle-media/Images/dark_YouTube_Tutorials.svg)

Welcome to Day 2.  
  
This whitepaper focuses on external tools functions that allow an agent to perform actions or retrieve real-time data beyond its training set and introduces best practices for designing effective tools. You'll learn about MCP, highlighting its architectural components, communication layer, risks and enterprise readiness gaps.  
  
In the codelabs, you will create custom tools for your agents by turning your own Python functions into actions your agent can perform. You'll also use MCP and implement long-running operations where an agent can pause tool calls while waiting for human approval, before resuming.  
  
**Day 2 Assignments:**  
  
Complete Unit 2 - “Agent Tools & Interoperability with Model Context Protocol (MCP)”:
Listen to the [summary podcast episode](https://www.youtube.com/watch?v=Cr4NA6rxHAM) for this unit.  
 To complement the podcast, read the [“Agent Tools & Interoperability with Model Context Protocol (MCP)” whitepaper](https://www.kaggle.com/whitepaper-agent-tools-and-interoperability-with-mcp).  
 Complete these codelabs on Kaggle:[Explore](https://www.kaggle.com/code/kaggle5daysofai/day-2a-agent-tools) new ways to add tools to extend what your agents can do.  
 [Explore](https://www.kaggle.com/code/kaggle5daysofai/day-2b-agent-tools-best-practices) best practices for tools, including using MCP and long-running operations.
\[Optional\]: Watch the recorded [YouTube livestream](https://www.youtube.com/live/8Gk1BE3uYek). Kanchana Patlolla and Anant Nawalgaria were joined by codelab author Laxmi Harikumar, along with Google guests Edward Grefenstette, Mike Styer, and Oriol Vinyals, as well as external speaker Alex Wissner-Gross from [Reified](https://reifiedllc.com/), to discuss the assignments and share insights.

![Other Resources](https://storage.googleapis.com/kaggle-media/Images/dark_YouTube_Tutorials.svg)

Welcome to Day 3.  
  
This whitepaper explores context engineering as the practice of dynamically assembling and managing information within an agent's context window to create stateful and personalized Al experiences. It defines Sessions as the container for a single, immediate conversation's history, and Memory as the long-term persistence mechanism.  
  
In the codelabs, you will learn how to make agents stateful by managing conversation history through context engineering in ADK, and working memory within a session, allowing your agent to remember context and have coherent, multi-turn conversations. In the second notebook, you'll give your agent long-term memory that persists across different sessions.  
  
**Day 3 Assignment**  
  
Complete Unit 3 - “Context Engineering: Sessions & Memory”:
Listen to the [summary podcast episode](https://www.youtube.com/watch?v=FMcExVE15a4) for this unit.  
 To complement the podcast, read the [“Context Engineering: Sessions & Memory whitepaper”](https://www.kaggle.com/whitepaper-context-engineering-sessions-and-memory).  
 Complete these codelabs on Kaggle:[Build](https://www.kaggle.com/code/kaggle5daysofai/day-3a-agent-sessions) stateful agents and perform context engineering.  
 [Explore](https://www.kaggle.com/code/kaggle5daysofai/day-3b-agent-memory) how to use memory with your agent.
\[Optional\]: Watch the recorded [YouTube livestream](https://www.youtube.com/live/8o-GXj8A3nE). Kanchana Patlolla and Anant Nawalgaria were joined by codelab author Kristopher Overholt, along with guests from Google: Steven Johnson, Kimberly Milam and Julia Wiesinger, and external speaker Jay Alammar from [Cohere](https://cohere.com/).

![Other Resources](https://storage.googleapis.com/kaggle-media/Images/dark_YouTube_Tutorials.svg)

Welcome to Day 4.  
  
This whitepaper addresses the challenge of assuring quality in Al agents by introducing a holistic evaluation framework. The necessary technical foundation for this is Observability, built on three pillars: Logs (the diary), Traces (the narrative), and Metrics (the health report), enabling a continuous feedback loop using scalable methods like LLM-as-a-Judge and Human-in-the-Loop (HITL) evaluation.  
  
In the codelabs, you'll learn how to use logs, traces, and metrics to get full visibility into your agent's decision-making process, allowing you to debug failures and understand why your agent behaves the way it does. In the second codelab, you'll learn how to evaluate your agents to score your agent's response quality and tool usage.  
  
**Day 4 Assignment**  
  
Complete Unit 4 - “Agent Quality”:
Listen to the [summary podcast episode](https://www.youtube.com/watch?v=LFQRy-Ci-lk) for this unit.  
 To complement the podcast, read the [Agent Quality whitepaper](https://www.kaggle.com/whitepaper-agent-quality).  
 Complete these codelabs on Kaggle:[Implement](https://www.kaggle.com/code/kaggle5daysofai/day-4a-agent-observability) observability to help you debug your agents.  
 [Evaluate](https://www.kaggle.com/code/kaggle5daysofai/day-4b-agent-evaluation) your agents.
\[Optional\]: Watch the recorded [YouTube livestream](https://www.youtube.com/live/JW1Yybfxyr4). Kanchana Patlolla and Anant Nawalgaria were joined by codelab author Sita Lakshmi Sangameswaran, along with guests from Google: Wafae Bakkali, Turan Bulmus and Sian Gooding, and external guest Jiwei Liu from [NVIDIA](https://www.nvidia.com/).

![Other Resources](https://storage.googleapis.com/kaggle-media/Images/dark_YouTube_Tutorials.svg)

Welcome to Day 5.  
  
This whitepaper provides a technical guide to the operational lifecycle of AI agents, focusing on deployment, scaling and productionization. It explores the challenges of transitioning agentic systems from prototypes to enterprise-grade solutions, with special attention to Agent2Agent (A2A) Protocol.  
  
In the codelabs, you'll learn how to build systems of multiple, independent agents that can communicate and collaborate using A2A Protocol. You'll also learn how to take your agent from your local machine to a production-ready, scalable service, by deploying your agent to Vertex AI Agent Engine on Google Cloud.  
  
**Final Assignment**  
  
Complete Unit 5 - “Prototype to Production”:
Listen to the [summary podcast episode](https://www.youtube.com/watch?v=8Wyt9l7ge-g) for this unit.  
 To complement the podcast, read the [“Prototype to Production” whitepaper](https://www.kaggle.com/whitepaper-prototype-to-production)..  
 Complete these codelabs on Kaggle:[Explore](https://www.kaggle.com/code/kaggle5daysofai/day-5a-agent2agent-communication) how to use A2A Protocol to have agents interact with each other.  
 \[Optional\] [Deploy](https://www.kaggle.com/code/kaggle5daysofai/day-5b-agent-deployment) your agent to Agent Engine on Google Cloud.
\[Optional\]: Watch the recorded [YouTube livestream](https://www.youtube.com/live/4XjPh5or0ws). Kanchana Patlolla and Anant Nawalgaria were joined by codelab author Laxmi Harikumar, along with guests from Google: Will Grannis, Sokratis Kartakis, Elia Secchi and Saurabh Tiwary.

---

## 📝 Processing Notes

### Key Takeaways

**Course Structure:**
- 5-day intensive on AI agents (Nov 10-14, 2025), now self-paced
- Comprehensive coverage: models, tools, orchestration, memory, evaluation
- Mix of theory (whitepapers), practice (codelabs), and discussion (livestreams)
- Uses Google's Agent Development Kit (ADK) powered by Gemini

**Daily Breakdown:**
- **Day 1:** Agent fundamentals, agentic vs traditional LLM architectures, multi-agent systems
- **Day 2:** External tools, function calling, Model Context Protocol (MCP), long-running operations
- **Day 3:** Context engineering, sessions, short-term and long-term memory
- **Day 4:** Quality assurance - observability (logs, traces, metrics), evaluation (LLM-as-judge, HITL)
- **Day 5:** Production deployment, scaling, Agent2Agent (A2A) Protocol, Vertex AI Agent Engine

**Technical Components:**
- Agent Development Kit (ADK)
- Google Gemini models
- Model Context Protocol (MCP) for tool interoperability
- Agent2Agent (A2A) Protocol for multi-agent communication
- Vertex AI Agent Engine for deployment

**Prerequisites:**
- Kaggle account (phone verified)
- Google AI Studio account + API key
- Kaggle Discord for community

### Relevance

**Why this matters:**
- Comprehensive, official course from Google on agent development
- Hands-on, practical approach with working code examples
- Covers full agent lifecycle: development → evaluation → production
- Introduces key protocols (MCP, A2A) for agent interoperability
- Self-paced format allows flexible learning

**Potential actions:**
- Consider taking this course as structured learning path
- Review whitepapers for conceptual understanding
- Complete codelabs for hands-on practice
- Use as reference for agent development patterns
- Add to [[2-Areas/AI-Learning/AI-Learning|AI Learning]] goals

### Related Concepts

- [[3-Resources/techniques/agents/agents - agentisation]] - Agent fundamentals and agentic systems
- [[3-Resources/techniques/agents/building-coding-agents]] - Building agent systems from scratch
- [[3-Resources/tools/protocols/MCP]] - Model Context Protocol details
- [[3-Resources/workshops/building-coding-agents-workshop]] - Related workshop content
- [[3-Resources/techniques/context-engineering/context-engineering-coding-agents]] - Context engineering for agents
- [[3-Resources/models/frontier/Claude 4 Sonnet]] - Alternative models for agents
- [[5-Meta/MOCs/Learning-Path-MOC]] - Structured learning progressions
- [[2-Areas/AI-Learning/AI-Learning]] - Ongoing AI learning area

---

**Captured:** 2025-12-23
**Processed:** 2025-12-23
**Status:** Processed - Ready for reference
**Next Action:** Consider adding to learning queue