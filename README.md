# MCP Access Console demo

A clickable, work-in-progress demo of the MCP Access Console: a ServiceNow scoped app that decides which MCP tools each person may use, from which entry point (Claude, GitHub Copilot), and logs every decision.

**Nothing here calls a model, an MCP server or a ServiceNow instance.** The access decisions come from a JavaScript copy of the real decision logic. The people, records, prompts and tool results are made up.

**Live demo:** https://tairaven.github.io/mcp-access-demo/

Or open `index.html` in a browser.

## What you can do

- **Run a prompt.** Includes a satellite agent scenario: Priya asks a ServiceNow agent to triage an incident, and every step of its plan goes through the policy check. Pick one of four people (service desk agent, change manager, developer, contractor with no account) and an entry point. Send a prompt and watch each step: `GET /policy`, the tools the model sees, `POST /decision`, confirmation, the tool call, and `POST /outcome`. Each step shows its JSON.
- **Data flow.** A diagram of every part, with build status. Click a box or an arrow for details, or use the walkthrough.
- **Policy.** Turn entry points off, block or retire tools, add allow or deny rules. Then run a prompt again and see the decision change. Includes a preview of the phase 2 Access checker.
- **Decision log.** Every decision and outcome, with filters for denials and errors.
- **Plan review.** Build status, the plan's tests run against the demo engine, findings and open decisions.

## How it is built

One self-contained HTML file. No build step, no dependencies beyond Google Fonts.

- `page.html` is the source.
- `scripts/build.sh` wraps it in a full HTML document as `index.html` for GitHub Pages.

The decision logic in the page mirrors `src/server/policy/policy-service.ts` in the ServiceNow app project. If that file changes, update the `engine` section of `page.html` to match.

## Decision order

1. Tool unknown, blocked, retired or draft → deny
2. Entry point unknown or inactive → deny
3. User unknown, inactive or ambiguous → deny
4. Any matching deny rule → deny (deny always wins)
5. Any matching allow rule → allow, or confirm_required if the tool needs it
6. Nothing matched → deny
