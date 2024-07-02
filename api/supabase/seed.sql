--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Ubuntu 15.1-1.pgdg20.04+1)
-- Dumped by pg_dump version 16.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) VALUES ('00000000-0000-0000-0000-000000000000', 'e5e4e782-a453-4651-bf30-1d00721fe9bf', 'authenticated', 'authenticated', 'test@example.com', '$2a$10$XIUiXnxD2UG/l8AzlC8Lc.OsPEPbTTreWR16t7Gd9zFuNEwOqbEMy', '2024-07-02 12:10:04.674221+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{}', NULL, '2024-07-02 12:10:04.666569+00', '2024-07-02 12:10:04.67443+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) VALUES ('e5e4e782-a453-4651-bf30-1d00721fe9bf', 'e5e4e782-a453-4651-bf30-1d00721fe9bf', '{"sub": "e5e4e782-a453-4651-bf30-1d00721fe9bf", "email": "test@example.com", "email_verified": false, "phone_verified": false}', 'email', '2024-07-02 12:10:04.671115+00', '2024-07-02 12:10:04.671167+00', '2024-07-02 12:10:04.671167+00', '56dc7097-2fd3-447d-81cc-0c7ba136746e');


--
-- PostgreSQL database dump complete
--

INSERT INTO public.audios(
    id, title, url, thumbnail_url, duration, published_at, created_by, created_at, updated_by, updated_at)
VALUES
    (1, 'サンプル音源01', 'http://example.com/audios/sample1.mp4', NULL, '00:20:00', '2024-06-30 15:00:00+00', 'c515f243-1fc9-4af7-a616-b2d3940c57af', '2024-06-30 15:00:00+00', 'c515f243-1fc9-4af7-a616-b2d3940c57af', '2024-06-30 15:00:00+00'),
    (2, 'サンプル音源02', 'http://example.com/audios/sample2.mp4', NULL, '00:20:00', '2024-06-30 15:00:00+00', 'c515f243-1fc9-4af7-a616-b2d3940c57af', '2024-06-30 15:00:00+00', 'c515f243-1fc9-4af7-a616-b2d3940c57af', '2024-06-30 15:00:00+00'),
    (3, 'サンプル音源03', 'http://example.com/audios/sample3.mp4', NULL, '00:20:00', '2024-06-30 15:00:00+00', 'c515f243-1fc9-4af7-a616-b2d3940c57af', '2024-06-30 15:00:00+00', 'c515f243-1fc9-4af7-a616-b2d3940c57af', '2024-06-30 15:00:00+00');
