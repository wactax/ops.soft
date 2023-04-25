

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


CREATE SCHEMA bot;


SET default_tablespace = '';

SET default_table_access_method = heap;


CREATE TABLE bot.civitai_img (
    id public.u64 NOT NULL,
    post_id public.u64 NOT NULL,
    url text NOT NULL,
    sampler_id public.u64 NOT NULL,
    w public.u16 NOT NULL,
    h public.u16 NOT NULL,
    gen_w public.u16 NOT NULL,
    gen_h public.u16 NOT NULL,
    step public.u16 NOT NULL,
    prompt_id public.u64,
    nprompt_id public.u64,
    meta_id public.u64,
    model_name_hash_id public.u64,
    genway_id public.u64,
    laugh public.u64 NOT NULL,
    star public.u64 NOT NULL,
    hate public.u64 NOT NULL,
    cry public.u64 NOT NULL,
    hash public.md5hash,
    seed public.u64
);



CREATE TABLE bot.civitai_model (
    id public.u64 NOT NULL,
    name text NOT NULL,
    "time" public.u64 DEFAULT (date_part('epoch'::text, now()))::bigint NOT NULL
);



CREATE TABLE bot.civitai_model_last_post (
    id public.u64 NOT NULL,
    last_post_time public.u64 NOT NULL,
    bot_day public.u32 NOT NULL
);



CREATE TABLE bot.civitai_model_log (
    id public.u64 NOT NULL,
    model_id public.u64 NOT NULL,
    fav public.u64 NOT NULL,
    review public.u64 NOT NULL,
    down public.u64 NOT NULL,
    rating_count public.u64 NOT NULL,
    rating public.u16 NOT NULL,
    "time" public.u64 DEFAULT (date_part('epoch'::text, now()))::bigint NOT NULL
);



CREATE SEQUENCE bot.civitai_model_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE bot.civitai_model_log_id_seq OWNED BY bot.civitai_model_log.id;



CREATE TABLE bot.civitai_post (
    id public.u64 NOT NULL,
    model_id public.u64 NOT NULL,
    user_id public.u64 NOT NULL,
    "time" public.u64 NOT NULL,
    txt text NOT NULL,
    rating public.u8 NOT NULL
);



CREATE TABLE bot.civitai_user (
    id bigint NOT NULL,
    name text NOT NULL
);



CREATE TABLE bot.meta (
    id bigint NOT NULL,
    val text NOT NULL,
    hash bytea NOT NULL
);



CREATE SEQUENCE bot.meta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE bot.meta_id_seq OWNED BY bot.meta.id;



ALTER TABLE ONLY bot.civitai_model_log ALTER COLUMN id SET DEFAULT nextval('bot.civitai_model_log_id_seq'::regclass);



ALTER TABLE ONLY bot.meta ALTER COLUMN id SET DEFAULT nextval('bot.meta_id_seq'::regclass);



ALTER TABLE ONLY bot.civitai_img
    ADD CONSTRAINT civitai_img_pkey PRIMARY KEY (id);



ALTER TABLE ONLY bot.civitai_model_last_post
    ADD CONSTRAINT civitai_model_last_review_pkey PRIMARY KEY (id);



ALTER TABLE ONLY bot.civitai_model_log
    ADD CONSTRAINT civitai_model_pkey PRIMARY KEY (id);



ALTER TABLE ONLY bot.civitai_model
    ADD CONSTRAINT civitai_model_pkey1 PRIMARY KEY (id);



ALTER TABLE ONLY bot.civitai_post
    ADD CONSTRAINT civitai_review_pkey PRIMARY KEY (id);



ALTER TABLE ONLY bot.civitai_user
    ADD CONSTRAINT civitai_user_pkey PRIMARY KEY (id);



ALTER TABLE ONLY bot.meta
    ADD CONSTRAINT meta_hash_key UNIQUE (hash);



ALTER TABLE ONLY bot.meta
    ADD CONSTRAINT meta_pkey PRIMARY KEY (id);



