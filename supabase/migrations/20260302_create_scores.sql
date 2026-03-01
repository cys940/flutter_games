-- scores 테이블 생성
create table public.scores (
  id uuid default gen_random_uuid() not null primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  game_id text not null,
  score integer not null default 0,
  created_at timestamp with time zone default now() not null
);

-- 인덱스 (리더보드 쿼리 최적화)
create index scores_game_id_score_idx on public.scores (game_id, score desc);
create index scores_user_id_idx on public.scores (user_id);

-- Realtime
alter table public.scores replica identity full;

-- RLS 활성화
alter table public.scores enable row level security;

-- 전체 공개 조회
create policy "Scores are viewable by everyone." on public.scores
  for select using (true);

-- 본인만 점수 등록
create policy "Users can insert their own scores." on public.scores
  for insert with check (auth.uid() = user_id);

-- 삭제/수정 불가 (무결성 보장)
