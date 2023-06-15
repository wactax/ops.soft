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
DROP INDEX IF EXISTS "prompt.hash";
DROP INDEX IF EXISTS "nprompt.hash";
ALTER TABLE IF EXISTS ONLY tag_en DROP CONSTRAINT IF EXISTS tag_en_val_key;
ALTER TABLE IF EXISTS ONLY tag_en DROP CONSTRAINT IF EXISTS tag_en_pkey;
ALTER TABLE IF EXISTS ONLY sampler DROP CONSTRAINT IF EXISTS sampler_pkey;
ALTER TABLE IF EXISTS ONLY sampler DROP CONSTRAINT IF EXISTS sampler_name_key;
ALTER TABLE IF EXISTS ONLY prompt DROP CONSTRAINT IF EXISTS prompt_pkey;
ALTER TABLE IF EXISTS ONLY prompt DROP CONSTRAINT IF EXISTS prompt_hash_key;
ALTER TABLE IF EXISTS ONLY nprompt DROP CONSTRAINT IF EXISTS nprompt_pkey;
ALTER TABLE IF EXISTS ONLY nprompt DROP CONSTRAINT IF EXISTS nprompt_hash_key;
ALTER TABLE IF EXISTS ONLY genway DROP CONSTRAINT IF EXISTS genway_pkey;
ALTER TABLE IF EXISTS ONLY genway DROP CONSTRAINT IF EXISTS genway_name_key;
ALTER TABLE IF EXISTS tag_en ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS sampler ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS prompt ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS nprompt ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS genway ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS tag_en_id_seq;
DROP TABLE IF EXISTS tag_en;
DROP SEQUENCE IF EXISTS sampler_id_seq;
DROP TABLE IF EXISTS sampler;
DROP SEQUENCE IF EXISTS prompt_id_seq;
DROP TABLE IF EXISTS prompt;
DROP SEQUENCE IF EXISTS nprompt_id_seq;
DROP TABLE IF EXISTS nprompt;
DROP SEQUENCE IF EXISTS genway_id_seq;
DROP TABLE IF EXISTS genway;
DROP SCHEMA IF EXISTS img;
CREATE SCHEMA img;
SET search_path TO img;
SET default_tablespace = '';
SET default_table_access_method = heap;
CREATE TABLE genway (
    id public.u32 NOT NULL,
    name text NOT NULL
);
CREATE SEQUENCE genway_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE genway_id_seq OWNED BY genway.id;
CREATE TABLE nprompt (
    id public.u64 NOT NULL,
    val text NOT NULL,
    hash public.md5hash NOT NULL
);
CREATE SEQUENCE nprompt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE nprompt_id_seq OWNED BY nprompt.id;
CREATE TABLE prompt (
    id public.u64 NOT NULL,
    val text NOT NULL,
    hash public.md5hash NOT NULL
);
CREATE SEQUENCE prompt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE prompt_id_seq OWNED BY prompt.id;
CREATE TABLE sampler (
    id public.u32 NOT NULL,
    name text NOT NULL
);
CREATE SEQUENCE sampler_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE sampler_id_seq OWNED BY sampler.id;
CREATE TABLE tag_en (
    id bigint NOT NULL,
    val text NOT NULL
);
CREATE SEQUENCE tag_en_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE tag_en_id_seq OWNED BY tag_en.id;
ALTER TABLE ONLY genway ALTER COLUMN id SET DEFAULT nextval('genway_id_seq'::regclass);
ALTER TABLE ONLY nprompt ALTER COLUMN id SET DEFAULT nextval('nprompt_id_seq'::regclass);
ALTER TABLE ONLY prompt ALTER COLUMN id SET DEFAULT nextval('prompt_id_seq'::regclass);
ALTER TABLE ONLY sampler ALTER COLUMN id SET DEFAULT nextval('sampler_id_seq'::regclass);
ALTER TABLE ONLY tag_en ALTER COLUMN id SET DEFAULT nextval('tag_en_id_seq'::regclass);
ALTER TABLE ONLY genway
    ADD CONSTRAINT genway_name_key UNIQUE (name);
ALTER TABLE ONLY genway
    ADD CONSTRAINT genway_pkey PRIMARY KEY (id);
ALTER TABLE ONLY nprompt
    ADD CONSTRAINT nprompt_hash_key UNIQUE (hash);
ALTER TABLE ONLY nprompt
    ADD CONSTRAINT nprompt_pkey PRIMARY KEY (id);
ALTER TABLE ONLY prompt
    ADD CONSTRAINT prompt_hash_key UNIQUE (hash);
ALTER TABLE ONLY prompt
    ADD CONSTRAINT prompt_pkey PRIMARY KEY (id);
ALTER TABLE ONLY sampler
    ADD CONSTRAINT sampler_name_key UNIQUE (name);
ALTER TABLE ONLY sampler
    ADD CONSTRAINT sampler_pkey PRIMARY KEY (id);
ALTER TABLE ONLY tag_en
    ADD CONSTRAINT tag_en_pkey PRIMARY KEY (id);
ALTER TABLE ONLY tag_en
    ADD CONSTRAINT tag_en_val_key UNIQUE (val);
CREATE UNIQUE INDEX "nprompt.hash" ON nprompt USING btree (hash);
CREATE UNIQUE INDEX "prompt.hash" ON prompt USING btree (hash);