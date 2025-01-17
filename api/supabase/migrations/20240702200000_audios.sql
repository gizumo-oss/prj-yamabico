create table
  public.audios (
    id bigint generated by default as identity,
    title character varying not null,
    url character varying not null,
    thumbnail_url character varying null,
    duration time without time zone not null,
    published_at timestamp with time zone null,
    created_by uuid null default auth.uid (),
    created_at timestamp with time zone null,
    updated_by uuid null default auth.uid (),
    updated_at timestamp with time zone null,
    constraint audios_pkey primary key (id),
    constraint audios_url_key unique (url)
  ) tablespace pg_default;