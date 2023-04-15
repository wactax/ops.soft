

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
    id bigint NOT NULL,
    post_id bigint NOT NULL,
    url text NOT NULL,
    sampler_id bigint NOT NULL,
    w integer NOT NULL,
    h integer NOT NULL,
    gen_w integer NOT NULL,
    gen_h integer NOT NULL,
    step smallint NOT NULL,
    prompt_id bigint,
    nprompt_id bigint,
    meta_id bigint,
    model_name_hash_id bigint,
    genway_id integer,
    seed bigint,
    laugh integer NOT NULL,
    star integer NOT NULL,
    hate integer NOT NULL,
    cry integer NOT NULL,
    hash bytea
);



CREATE TABLE bot.civitai_model (
    id bigint NOT NULL,
    name text NOT NULL,
    "time" bigint DEFAULT (date_part('epoch'::text, now()))::bigint NOT NULL
);



CREATE TABLE bot.civitai_model_last_post (
    id bigint NOT NULL,
    last_post_time bigint NOT NULL,
    bot_day integer NOT NULL
);



CREATE TABLE bot.civitai_model_log (
    id bigint NOT NULL,
    model_id bigint NOT NULL,
    fav bigint NOT NULL,
    review bigint NOT NULL,
    down bigint NOT NULL,
    rating_count bigint NOT NULL,
    rating bigint NOT NULL,
    "time" bigint DEFAULT (date_part('epoch'::text, now()))::bigint NOT NULL
);



CREATE SEQUENCE bot.civitai_model_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE bot.civitai_model_log_id_seq OWNED BY bot.civitai_model_log.id;



CREATE TABLE bot.civitai_post (
    id bigint NOT NULL,
    model_id bigint NOT NULL,
    user_id bigint NOT NULL,
    "time" bigint NOT NULL,
    txt text NOT NULL,
    rating smallint NOT NULL
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



