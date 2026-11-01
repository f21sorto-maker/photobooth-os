# Agent guide — photobooth-os

## Full-stack QA loop

Before feature work or release checks, run the **10-pass reliability loop**:

1. `./scripts/qa-reliability-bootstrap-check.sh` (must pass or gaps logged in defect log)
2. Cursor command: `.cursor/commands/qa-reliability-10-pass.md`
3. Append findings to `docs/QA_DEFECT_LOG_*.md` using the schema in that command

Expected layers (once implemented):

| Layer | Typical path | Pass focus |
|--------|----------------|------------|
| Frontend | `frontend/` or `apps/web/` | Pass 2–3, 8–9 |
| Backend | `backend/` or `apps/api/` | Pass 1, 5–7, 9 |
| Client portal | `portal/` or `apps/portal/` | Pass 4–5 |

Do not stop after the first failure; complete all 10 passes and reconcile in Pass 10.
