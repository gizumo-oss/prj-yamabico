create table
  public.histories (
    id bigint generated by default as identity,
    audio_id bigint not null,
    user_uuid uuid not null default auth.uid (),
    played_at timestamp with time zone null,
    constraint histories_pkey primary key (id),
    constraint public_histories_audio_id_fkey foreign key (audio_id) references audios (id) on update cascade on delete cascade
  ) tablespace pg_default;