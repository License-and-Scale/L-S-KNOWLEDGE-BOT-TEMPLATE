# L-S-KNOWLEDGE-BOT-TEMPLATE

RAG-first internal assistant. Cites every answer. Refuses to guess.

**Part of the [L&S OpenClaw Template Library](https://github.com/License-and-Scale/openclaw-profile-templates)** —
a free collection of 16 reusable [OpenClaw](https://github.com/ruvnet/openclaw)
agent archetypes.

---

## Just want the prompt?

Open [`SYSTEM-PROMPT.md`](SYSTEM-PROMPT.md) and paste the whole file as the
system prompt for your Claude project, Claude Code agent, OpenClaw profile,
or any LLM tool that accepts a custom system prompt. Edit the `{placeholder}`
fields to match your business. That's the entire setup.

The longer "Quick start" below covers the OpenClaw CLI path with Telegram +
gateway wiring.

---

## Quick start

1. Click **"Use this template"** (top right) to create your own copy.
2. Clone your copy and set up env vars in a `.env` file:
   ```
   ANTHROPIC_API_KEY=...
   OPENCLAW_GATEWAY_TOKEN=$(openssl rand -hex 24)
   TELEGRAM_BOT_TOKEN=...
   OPENCLAW_GATEWAY_PORT=18800
   OWNER_TG_USER_ID=...
   ```
3. Create the OpenClaw profile for this agent:
   ```bash
   openclaw configure --profile my-agent
   ```
4. Render the config into your profile:
   ```bash
   ./scripts/render-config.sh openclaw.json.template > ~/.openclaw-my-agent/openclaw.json
   ```
5. Copy `IDENTITY.md` into the workspace:
   ```bash
   cp IDENTITY.md ~/.openclaw-my-agent/workspace/IDENTITY.md
   ```
6. Install the recommended skills:
   ```bash
   while read -r skill; do
     [[ "$skill" =~ ^#.*$ || -z "$skill" ]] && continue
     openclaw skills install "$skill" --profile my-agent
   done < skills.txt
   ```
7. Edit `IDENTITY.md` — pick a name, fill in role-specific details.
8. Start your gateway and DM the bot.

---

## What's in this repo

| File | What it is |
|------|------------|
| `IDENTITY.md` | Fill-in-the-blank role spec — edit after cloning |
| `SYSTEM-PROMPT.md` | Concatenated IDENTITY + framework, ready to paste into Claude |
| `skills.txt` | Recommended OpenClaw skills for this role |
| `openclaw.json.template` | Config skeleton using `${ENV_VAR}` placeholders |
| `scripts/render-config.sh` | Substitutes env vars into the template |

---

## Philosophy

- **Thin.** This template describes the role, not a specific company's playbook.
- **No credentials.** Nothing sensitive is ever committed. Secrets live in `.env`.
- **Env-var driven.** Every placeholder is a `${VAR}` — no hardcoded values.

## License

MIT — use freely, fork, modify, ship.
