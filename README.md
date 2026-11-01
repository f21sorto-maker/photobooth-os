# photobooth-os

Photobooth operating system — frontend, backend, and client portal (application source pending in this repository).

## QA reliability loop

Run repeated full-stack validation (minimum **10 passes**) before release:

```bash
./scripts/qa-reliability-bootstrap-check.sh
```

Then in Cursor, run the command defined in [`.cursor/commands/qa-reliability-10-pass.md`](.cursor/commands/qa-reliability-10-pass.md). Record issues in [`docs/`](docs/) using the defect schema in that command.

See [`AGENTS.md`](AGENTS.md) for agent bootstrap expectations once services exist.
