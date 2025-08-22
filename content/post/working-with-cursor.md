+++
title = 'Practical Patterns for Coding with Cursor'
date = 2025-08-21T02:07:38+05:30
draft = false
+++

I've been using Cursor consistently for the past 6 months across different languages and stacks. Along the way, I've noticed a few patterns to make it much more effective for coding, planning, and documentation.

I make no promise of a 10x productivity boost at the end (there's plenty of that on X.com, much to my annoyance). These are tried-and-tested mental models that have worked for me. While the tooling will keep evolving, these patterns have brought some stability to my workflow.

### Clarity in Thinking and Writing = Good Prompts

Effective articulation, whether in speech or writing, is a core skill of a good engineer. Understand the problem you're trying to solve. What is known, and what is unknown? How do you verify the solution? Articulating these well can be the difference between consistently good results and mediocre ones.

### Context is Key

Provide the key files or folders to look into. Narrow the search area. Don't `select * from table` without using an index if you will. Prompting without the right context can increase inference time and waste tokens.

### Vibe, but Plan first

If there has been one game-changing trick for me, it is this. Don't dive into the solution immediately. Ask for a plan first. Then spend most of your time iterating on it. Validate the model's understanding of the ask and iron out the wrinkles. This will make the code review process much quicker.

Planning here is not just for the approach but also for task execution. Don't YOLO your way through it. Establish reasonable checkpoints in the plan where you can verify things before proceeding.

Also, don't vibe. It's much harder to spot subtle bugs when looking at large diffs across files.

### Right tool for the job

Try out different models for the same or different use-cases. Compare and contrast. Understand the trade-offs. The AI universe is rapidly expanding. I prefer Sonnet-4 for agentic coding, but Gemini 2.5 Pro works well too, albeit less consistent in quality.

### Augment with MCPs

Make Cursor agents even more powerful using MCPs. These are a few that I'd recommend:

1. [Sequential Thinking](https://github.com/modelcontextprotocol/servers/tree/main/src/sequentialthinking): enables an agent to reflect on its thinking, makes it more accurate and prevents circular reasoning loops.
2. [Context 7](https://github.com/upstash/context7): provides access to up-to-date documentation that is designed for LLM workflows. This helps with the limitation of using outdated docs based on model training cutoffs.
3. [Playwright](https://github.com/microsoft/playwright-mcp): provides browser automation capabilities using [Playwright.dev](https://playwright.dev/). I've found it particularly useful when working with [Storybook](https://storybook.js.org/).
4. [Linear](https://linear.app/docs/mcp): lets you interact with [Linear](https://linear.app/homepage). This is particularly useful for fleshing out a story with its acceptance criteria using simple prompts. It also enables providing a card as context to work on a task.

### Rules, Guardrails, and Feedback Loops

Leverage Cursor Rules to document anything that would make the model smarter, including project documentation, style conventions, common commands to run. Create a meta-rule when you need to standardize the format for rules.

Enable Cursor's memory feature to let it take note of patterns or preferences from the chats.

### Objective Code Reviews

Ask for a code review in a new chat with all the relevant context provided for the implementation. Use the `@branch` tag to provide a diff with the main branch as context. Sometimes objective reviews without the context of how it was implemented can help spot some bugs.

### Pro Tip: Use Claude Code if you can

I've had good results using Claude Code from within Cursor. Claude Code is the best agentic workflow for coding, IMO. I'd recommend trying out this workflow. There's an extension from Anthropic that can display the diff in the IDE and maintain the same UX.

 &nbsp;

AI-assisted coding tools are evolving quickly, and today’s best practices may look different in six months. The important part is to stay intentional — use the tool to augment your thinking, not to replace it. What tips/hacks have helped improve your workflow? I'd love to know more.
