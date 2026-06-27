-- Year Canvas — Supabase schema
-- Run this in your Supabase project: SQL Editor → New query → paste → Run.

create table if not exists public.year_canvas (
  id         text primary key,
  data       jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.year_canvas enable row level security;

-- Single-user, no-login setup: the public (anon) role may read/write this one
-- table. Anyone who knows the deployed site URL can edit the canvas.
-- This is intentional for a personal tool. To lock it down later, replace these
-- policies with Supabase Auth + per-user rows.
drop policy if exists "anon read"   on public.year_canvas;
drop policy if exists "anon insert" on public.year_canvas;
drop policy if exists "anon update" on public.year_canvas;

create policy "anon read"   on public.year_canvas for select using (true);
create policy "anon insert" on public.year_canvas for insert with check (true);
create policy "anon update" on public.year_canvas for update using (true) with check (true);
