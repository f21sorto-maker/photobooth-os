# QA defect log — photobooth-os — 2026-11-01

**Run:** Application reliability validation (push automation on `main`)  
**Branch:** `cursor/application-reliability-validation-d0c4`  
**Repo state:** Initial commit on `main` (`7d7fa96`); QA/bootstrap artifacts on validation branch only until merged.

## Services tested

| Layer | Status | Notes |
|--------|--------|--------|
| Frontend | Not present | No app package, routes, or dev script |
| Backend | Not present | No API server, handlers, or OpenAPI |
| Client portal | Not present | No portal app or auth flow |
| Supporting services | Not present | No Docker, workers, or integration config |
| QA automation | **Present** | `.cursor/commands/qa-reliability-10-pass.md`, `scripts/qa-reliability-bootstrap-check.sh` |

## Pass 1 coverage inventory (routes / endpoints)

| Surface | Expected (product) | Found in repo |
|---------|-------------------|---------------|
| Frontend routes | Booth operator UI | **0** — no router or pages |
| Portal routes | Client login + self-service | **0** |
| Backend HTTP endpoints | REST/GraphQL + `/health` | **0** |
| CLI commands | Dev/ops scripts | **1** — `scripts/qa-reliability-bootstrap-check.sh` |
| Cursor commands | Agent QA loop | **1** — `.cursor/commands/qa-reliability-10-pass.md` |

**Backend search (Pass 1):** no matches for `express`, `fastify`, `hono`, `app.get`, or `openapi` in application code.

## Pass summaries

| Pass | Focus | Working | Broken | Gaps | Incomplete |
|------|--------|---------|--------|------|------------|
| 1 | Inventory | Git repo; README; AGENTS.md; QA command + bootstrap script | — | Entire product stack missing | — |
| 2 | Frontend controls | — | — | No UI to click | — |
| 3 | Forms/modals | — | — | No forms | — |
| 4 | Portal | — | — | No portal | — |
| 5 | Pricing/quotes | — | — | No commercial modules | — |
| 6 | Notifications/audit | — | — | No logging/audit UI or API | — |
| 7 | Integrations | — | — | No external integrations | — |
| 8 | Responsive layout | — | — | No layouts | — |
| 9 | Error/resilience | — | — | No runtime to fault-inject | — |
| 10 | Reconciliation | QA loop + bootstrap probe; README links | — | Same product gaps as Pass 1 | — |

## Defect entries

### PASS1-001

| Field | Value |
|--------|--------|
| Pass | 1 |
| Severity | **critical** |
| Area | full stack |
| File path | `N/A — repository root` |
| Component | Application codebase |
| Status | **gap** |
| Root cause | Repository contains only `README.md` (Initial commit `7d7fa96`); no monorepo/app directories, no package manifests, no server entrypoints. |
| Reproduction | 1. Clone `github.com/f21sorto-maker/photobooth-os`. 2. List files on `main`. 3. Observe sole file `README.md`. |
| Fix applied or needed | Push or link frontend, backend, and portal source; document bootstrap in README (install, env, start commands, test credentials). |
| Verification | **fail** — no code to run E2E tests against |

### PASS1-002

| Field | Value |
|--------|--------|
| Pass | 1 |
| Severity | **high** |
| Area | backend |
| File path | `N/A — missing` |
| Component | API routes / health endpoints |
| Status | **gap** |
| Root cause | No HTTP server or route definitions in repository. |
| Reproduction | Search repo for `routes`, `app.get`, `fastify`, `express`, `hono`, etc.; none found. |
| Fix applied or needed | Add backend service with documented `/health` (or equivalent) and route inventory for Pass 1 automation. |
| Verification | **fail** |

### PASS1-003

| Field | Value |
|--------|--------|
| Pass | 1 |
| Severity | **high** |
| Area | frontend |
| File path | `N/A — missing` |
| Component | SPA / pages |
| Status | **gap** |
| Root cause | No frontend framework, `package.json`, or static entry HTML. |
| Reproduction | Attempt `npm run dev` or equivalent at repo root; no manifest exists. |
| Fix applied or needed | Add frontend app with route table (file-based or router config) checkable in Pass 1. |
| Verification | **fail** |

### PASS1-004

| Field | Value |
|--------|--------|
| Pass | 1 |
| Severity | **high** |
| Area | portal |
| File path | `N/A — missing` |
| Component | Client portal |
| Status | **gap** |
| Root cause | No separate portal app or portal routes in repo. |
| Reproduction | Inventory Pass 1 finds zero portal paths. |
| Fix applied or needed | Add portal module or app with login and page list documented for QA Pass 4. |
| Verification | **fail** |

### PASS2-001 through PASS9-001

| Field | Value |
|--------|--------|
| Pass | 2–9 |
| Severity | **critical** (blocked) |
| Area | frontend / portal |
| Status | **gap** (blocked) |
| Root cause | Passes 2–9 depend on PASS1-001 resolution; no runnable application. |
| Fix applied or needed | Unblock by landing application code; re-run `.cursor/commands/qa-reliability-10-pass.md`. |
| Verification | **not run** (blocked) |

### PASS10-001

| Field | Value |
|--------|--------|
| Pass | 10 |
| Severity | **medium** |
| Area | process |
| File path | `.cursor/commands/qa-reliability-10-pass.md` |
| Component | QA automation prompt |
| Status | **fixed this session** |
| Root cause | No repeatable 10-pass loop prompt existed in repo. |
| Fix applied | Added command prompt enforcing 10 passes, full-stack coverage, defect log schema, fix-and-retest rules, per-pass full-stack checklist, test plan, pre-output checklist. |
| Verification | **pass** — file present and matches content rules |

### PASS10-002

| Field | Value |
|--------|--------|
| Pass | 10 |
| Severity | **medium** |
| Area | process |
| File path | `scripts/qa-reliability-bootstrap-check.sh` |
| Component | Bootstrap probe |
| Status | **fixed this session** |
| Root cause | No automated way to verify frontend/backend/portal bootstrap before Pass 1. |
| Fix applied | Added non-interactive shell probe; exits non-zero when layers not discoverable. |
| Reproduction | Run `./scripts/qa-reliability-bootstrap-check.sh` on empty repo. |
| Verification | **pass** — script reports MISSING artifacts and exit code 1 |

### PASS10-003

| Field | Value |
|--------|--------|
| Pass | 10 |
| Severity | **low** |
| Area | docs |
| File path | `README.md`, `AGENTS.md` |
| Component | Agent bootstrap docs |
| Status | **fixed this session** |
| Root cause | README was title-only; agents could not find QA loop entrypoint. |
| Fix applied | Linked QA command, bootstrap script, and AGENTS.md service matrix. |
| Verification | **pass** — bootstrap script detects README keywords |

## Regressions

None detectable — no application baseline from an earlier pass with working features.

## Reconciliation (Pass 10 vs Pass 1)

- **Unchanged:** Entire product stack still absent on `main`; critical/high gaps PASS1-001–004 remain open.
- **Improved:** Repeatable 10-pass Cursor command, bootstrap probe, README/AGENTS entrypoints for future E2E runs.
- **Regressions:** None (no working product baseline).

## Next actions for product owner

1. Import or commit photobooth-os frontend, backend, and portal into this repository (or submodule pointers with clone instructions).
2. Extend README with service matrix, ports, env vars, and seeded test accounts.
3. Re-invoke **QA Reliability 10-Pass** command; expect Passes 2–9 to execute against live services.
4. Optionally add Playwright/Cypress smoke suite wired to CI that mirrors Pass 2–3 checks.
