create table
  public.bookmarks (
    id bigint generated by default as identity,
    audio_id bigint not null,
    user_uuid uuid not null default auth.uid (),
    created_at timestamp with time zone null,
    constraint bookmarks_pkey primary key (id),
    constraint public_bookmarks_audio_id_fkey foreign key (audio_id) references audios (id) on update cascade on delete cascade
  ) tablespace pg_default;