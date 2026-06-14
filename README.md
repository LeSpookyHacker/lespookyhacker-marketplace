# @lespookyhacker — Claude Code plugin marketplace

A personal [Claude Code plugin marketplace](https://code.claude.com/docs/en/plugin-marketplaces) by LeSpookyHacker.
The marketplace handle is `lespookyhacker` — used when installing plugins (e.g. `girlypop-uwu@lespookyhacker`).

## Plugins

| Plugin | Description | Version |
|--------|-------------|---------|
| [`girlypop-uwu`](plugins/girlypop-uwu/README.md) | Kawaii girly-pop / UwU + anime-flavored persona — magical girl energy, anime kaomoji, 40+ JP catchphrases 🎀 | 1.1.0 |
| [`cyberpunk-noir`](plugins/cyberpunk-noir/README.md) | Cyberpunk neon-noir netrunner persona — Night City slang, glitch flair, boots every session with "Wake up Samurai. We got a city to burn." ⚡ | 1.0.0 |

## Install a plugin

```text
/plugin marketplace add LeSpookyHacker/lespookyhacker-marketplace
/plugin install <plugin-name>@lespookyhacker
```

The first command registers this repo as a marketplace source. Pull in updates later with:

```text
/plugin marketplace update lespookyhacker
```

> Relative-path plugin sources only resolve when the marketplace is added via git (GitHub/GitLab/git URL), not via a direct URL to `marketplace.json`.

## Develop / test locally

```bash
claude --plugin-dir ./plugins/<plugin-name>
claude plugin validate ./plugins/<plugin-name>
```

## Adding a new plugin

1. Create a folder under `plugins/<your-plugin-name>/`
2. Add `.claude-plugin/plugin.json`, `agents/`, `settings.json`, and a `README.md`
3. Register it in [`.claude-plugin/marketplace.json`](.claude-plugin/marketplace.json) under the `plugins` array
4. Add a row to the table above

---

## License

MIT — see [LICENSE](LICENSE).
