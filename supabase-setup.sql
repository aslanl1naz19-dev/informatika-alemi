-- Supabase SQL Editor-də tam şəkildə işlədin.
-- ƏVVƏL: PASTE_TEACHER_UID_HERE yazılan yerləri müəllim UUID-si ilə əvəz edin.
-- Müəllim hesabını Supabase Dashboard > Authentication > Users bölməsində yaradın.

create table if not exists public.site_content (id text primary key, payload jsonb not null default '{}'::jsonb, updated_at timestamptz not null default now());
create table if not exists public.materials (id uuid primary key default gen_random_uuid(), title text not null, category text not null default 'Ümumi', file_name text not null, storage_path text not null unique, created_at timestamptz not null default now());

alter table public.site_content enable row level security;
alter table public.materials enable row level security;
drop policy if exists "Public can read site content" on public.site_content;
create policy "Public can read site content" on public.site_content for select to anon, authenticated using (true);
drop policy if exists "Teacher can insert site content" on public.site_content;
create policy "Teacher can insert site content" on public.site_content for insert to authenticated with check (auth.uid() = 'PASTE_TEACHER_UID_HERE'::uuid);
drop policy if exists "Teacher can update site content" on public.site_content;
create policy "Teacher can update site content" on public.site_content for update to authenticated using (auth.uid() = 'PASTE_TEACHER_UID_HERE'::uuid) with check (auth.uid() = 'PASTE_TEACHER_UID_HERE'::uuid);
drop policy if exists "Public can read materials" on public.materials;
create policy "Public can read materials" on public.materials for select to anon, authenticated using (true);
drop policy if exists "Teacher can add materials" on public.materials;
create policy "Teacher can add materials" on public.materials for insert to authenticated with check (auth.uid() = 'PASTE_TEACHER_UID_HERE'::uuid);
drop policy if exists "Teacher can delete materials" on public.materials;
create policy "Teacher can delete materials" on public.materials for delete to authenticated using (auth.uid() = 'PASTE_TEACHER_UID_HERE'::uuid);

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types) values ('materials','materials',true,41943040,array['application/pdf','application/msword','application/vnd.openxmlformats-officedocument.wordprocessingml.document','application/vnd.ms-powerpoint','application/vnd.openxmlformats-officedocument.presentationml.presentation','application/vnd.ms-excel','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet','image/png','image/jpeg']) on conflict (id) do update set public=excluded.public, file_size_limit=excluded.file_size_limit, allowed_mime_types=excluded.allowed_mime_types;
drop policy if exists "Public can view teaching materials" on storage.objects;
create policy "Public can view teaching materials" on storage.objects for select to anon, authenticated using (bucket_id='materials');
drop policy if exists "Teacher can upload teaching materials" on storage.objects;
create policy "Teacher can upload teaching materials" on storage.objects for insert to authenticated with check (bucket_id='materials' and auth.uid()='PASTE_TEACHER_UID_HERE'::uuid);
drop policy if exists "Teacher can delete teaching materials" on storage.objects;
create policy "Teacher can delete teaching materials" on storage.objects for delete to authenticated using (bucket_id='materials' and auth.uid()='PASTE_TEACHER_UID_HERE'::uuid);
