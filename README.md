# Year Canvas

A single-file year-planning canvas (`index.html`). No build step. Data is cached
in the browser (`localStorage`) for instant load and synced to Supabase so it
follows you across devices.

## How sync works

- On every change the app saves to `localStorage` immediately, then upserts a
  single row (`id = 'singleton'`) into the Supabase `year_canvas` table.
- On load it renders from the local cache, then pulls the cloud row and
  re-renders if it exists. First run with an empty cloud seeds it from local.
- This is a single shared dataset with **no login**. Anyone with the site URL can
  edit it. Fine for personal use; see "Locking it down" below to change that.

## Setup

### 1. GitHub
```bash
git push -u origin main
```
(The repo is already initialized with `origin` set to
`https://github.com/danielzerkowitz/year-canvas.git`.)

### 2. Supabase
1. Create a project at https://supabase.com.
2. SQL Editor → New query → paste `supabase-schema.sql` → Run.
3. Project Settings → API → copy the **Project URL** and the **anon public** key.
4. In `index.html`, replace `__SUPABASE_URL__` and `__SUPABASE_ANON_KEY__` with
   those two values, then commit and push.

### 3. Vercel
1. Go to https://vercel.com → Add New → Project → import `year-canvas`.
2. Framework preset: **Other** (no build command, output is the repo root).
3. Deploy. Every push to `main` redeploys automatically.

## Locking it down (optional)

To make this private (each person logs in, sees their own canvas), switch to
Supabase Auth and per-user rows, and replace the open RLS policies in
`supabase-schema.sql` with `auth.uid()`-based policies.
