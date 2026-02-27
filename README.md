# ui-element-ops

This repository keeps a reusable skill for UI parsing and desktop operations:

- `skills/ui-element-ops`

## What It Can Do

- Parse UI screenshots into structured elements (`type`, `bbox`, `text`, `clickable`)
- Find / wait for elements
- Click, type, key, hotkey
- Take screenshots
- Calibrate coordinates for DPI / multi-display / window offsets

## GUI / Headless Notes

- In headless systems, screenshot parsing still works if you already have image files.
- In headless systems, `list` / `find` / `wait` / `calibrate` can still run on existing `*.elements.json`.
- In headless systems, interactive actions do not work: `click`, `click-xy`, `type`, `key`, `hotkey`, `screenshot`, `screen-info`.
- Interactive actions require an active GUI desktop session and OS permissions (Accessibility / Screen Recording where applicable).

## Quick Start

1. Bootstrap environment:

```bash
skills/ui-element-ops/scripts/bootstrap_omniparser_env.sh "$PWD"
```

2. Parse an image:

```bash
skills/ui-element-ops/scripts/run_parse_ui.sh /abs/path/to/screen.png
```

3. Operate UI:

```bash
python3 skills/ui-element-ops/scripts/operate_ui.py --help
```

4. Capture + parse with randomized names:

```bash
skills/ui-element-ops/scripts/capture_and_parse.sh
```

## Main Files

- `skills/ui-element-ops/SKILL.md`
- `skills/ui-element-ops/agents/openai.yaml`
- `skills/ui-element-ops/scripts/parse_ui.py`
- `skills/ui-element-ops/scripts/operate_ui.py`
