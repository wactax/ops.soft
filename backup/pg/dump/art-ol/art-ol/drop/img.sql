

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

DROP INDEX IF EXISTS img.res_kind_hash_name_id_prompt_id_idx;
DROP INDEX IF EXISTS img.res_group_val_idx;
DROP INDEX IF EXISTS img."prompt.hash";
DROP INDEX IF EXISTS img."nprompt.hash";
ALTER TABLE IF EXISTS ONLY img.tag_en DROP CONSTRAINT IF EXISTS tag_en_val_key;
ALTER TABLE IF EXISTS ONLY img.tag_en DROP CONSTRAINT IF EXISTS tag_en_pkey;
ALTER TABLE IF EXISTS ONLY img.sampler DROP CONSTRAINT IF EXISTS sampler_pkey;
ALTER TABLE IF EXISTS ONLY img.sampler DROP CONSTRAINT IF EXISTS sampler_name_key;
ALTER TABLE IF EXISTS ONLY img.res_url DROP CONSTRAINT IF EXISTS res_url_pkey;
ALTER TABLE IF EXISTS ONLY img.res_prompt DROP CONSTRAINT IF EXISTS res_prompt_val_key;
ALTER TABLE IF EXISTS ONLY img.res_prompt DROP CONSTRAINT IF EXISTS res_prompt_pkey;
ALTER TABLE IF EXISTS ONLY img.res DROP CONSTRAINT IF EXISTS res_pkey;
ALTER TABLE IF EXISTS ONLY img.res_name DROP CONSTRAINT IF EXISTS res_name_val_key;
ALTER TABLE IF EXISTS ONLY img.res_name DROP CONSTRAINT IF EXISTS res_name_pkey;
ALTER TABLE IF EXISTS ONLY img.res_kind DROP CONSTRAINT IF EXISTS res_kind_val_key;
ALTER TABLE IF EXISTS ONLY img.res_kind DROP CONSTRAINT IF EXISTS res_kind_pkey;
ALTER TABLE IF EXISTS ONLY img.res_group DROP CONSTRAINT IF EXISTS res_group_pkey;
ALTER TABLE IF EXISTS ONLY img.res2url DROP CONSTRAINT IF EXISTS res2url_res_id_url_id_key;
ALTER TABLE IF EXISTS ONLY img.prompt DROP CONSTRAINT IF EXISTS prompt_pkey;
ALTER TABLE IF EXISTS ONLY img.prompt DROP CONSTRAINT IF EXISTS prompt_hash_key;
ALTER TABLE IF EXISTS ONLY img.nprompt DROP CONSTRAINT IF EXISTS nprompt_pkey;
ALTER TABLE IF EXISTS ONLY img.nprompt DROP CONSTRAINT IF EXISTS nprompt_hash_key;
ALTER TABLE IF EXISTS ONLY img.genway DROP CONSTRAINT IF EXISTS genway_pkey;
ALTER TABLE IF EXISTS ONLY img.genway DROP CONSTRAINT IF EXISTS genway_name_key;
ALTER TABLE IF EXISTS img.tag_en ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS img.sampler ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS img.res_url ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS img.res_prompt ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS img.res_name ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS img.res_kind ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS img.res_group ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS img.res2url ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS img.res ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS img.prompt ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS img.nprompt ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS img.genway ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS img.tag_en_id_seq;
DROP TABLE IF EXISTS img.tag_en;
DROP SEQUENCE IF EXISTS img.sampler_id_seq;
DROP TABLE IF EXISTS img.sampler;
DROP SEQUENCE IF EXISTS img.res_prompt_id_seq;
DROP TABLE IF EXISTS img.res_prompt;
DROP SEQUENCE IF EXISTS img.res_name_id_seq;
DROP TABLE IF EXISTS img.res_name;
DROP SEQUENCE IF EXISTS img.res_kind_id_seq;
DROP TABLE IF EXISTS img.res_kind;
DROP SEQUENCE IF EXISTS img.res_id_seq;
DROP TABLE IF EXISTS img.res_url;
DROP SEQUENCE IF EXISTS img.res_hash_id_seq;
DROP SEQUENCE IF EXISTS img.res_group_id_seq;
DROP TABLE IF EXISTS img.res_group;
DROP SEQUENCE IF EXISTS img.res2url_id_seq;
DROP TABLE IF EXISTS img.res2url;
DROP TABLE IF EXISTS img.res;
DROP SEQUENCE IF EXISTS img.prompt_id_seq;
DROP TABLE IF EXISTS img.prompt;
DROP SEQUENCE IF EXISTS img.nprompt_id_seq;
DROP TABLE IF EXISTS img.nprompt;
DROP SEQUENCE IF EXISTS img.genway_id_seq;
DROP TABLE IF EXISTS img.genway;
DROP SCHEMA IF EXISTS img;

CREATE SCHEMA img;


SET default_tablespace = '';

SET default_table_access_method = heap;


CREATE TABLE img.genway (
    id integer NOT NULL,
    name text NOT NULL
);



CREATE SEQUENCE img.genway_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE img.genway_id_seq OWNED BY img.genway.id;



CREATE TABLE img.nprompt (
    id public.u64 NOT NULL,
    val text NOT NULL,
    hash public.md5hash NOT NULL
);



CREATE SEQUENCE img.nprompt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE img.nprompt_id_seq OWNED BY img.nprompt.id;



CREATE TABLE img.prompt (
    id public.u64 NOT NULL,
    val text NOT NULL,
    hash public.md5hash NOT NULL
);



CREATE SEQUENCE img.prompt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE img.prompt_id_seq OWNED BY img.prompt.id;



CREATE TABLE img.res (
    id bigint NOT NULL,
    kind_id public.u32 NOT NULL,
    hash bytea DEFAULT '\x'::bytea NOT NULL,
    name_id public.u64 DEFAULT 0 NOT NULL,
    prompt_id public.u64 DEFAULT 0 NOT NULL,
    n public.u64 DEFAULT 1 NOT NULL
);



CREATE TABLE img.res2url (
    id public.u64 NOT NULL,
    res_id public.u64 NOT NULL,
    url_id public.u64 NOT NULL
);



CREATE SEQUENCE img.res2url_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE img.res2url_id_seq OWNED BY img.res2url.id;



CREATE TABLE img.res_group (
    id bigint NOT NULL,
    val public.u64[] NOT NULL
);



CREATE SEQUENCE img.res_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE img.res_group_id_seq OWNED BY img.res_group.id;



CREATE SEQUENCE img.res_hash_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE img.res_hash_id_seq OWNED BY img.res.id;



CREATE TABLE img.res_url (
    id bigint NOT NULL,
    url character varying(2047) NOT NULL,
    src_id public.u8
);



CREATE SEQUENCE img.res_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE img.res_id_seq OWNED BY img.res_url.id;



CREATE TABLE img.res_kind (
    id public.u64 NOT NULL,
    val character varying(255) NOT NULL
);



CREATE SEQUENCE img.res_kind_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE img.res_kind_id_seq OWNED BY img.res_kind.id;



CREATE TABLE img.res_name (
    id public.u64 NOT NULL,
    val character varying(255) NOT NULL
);



CREATE SEQUENCE img.res_name_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE img.res_name_id_seq OWNED BY img.res_name.id;



CREATE TABLE img.res_prompt (
    id bigint NOT NULL,
    val character varying(255) NOT NULL
);



CREATE SEQUENCE img.res_prompt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE img.res_prompt_id_seq OWNED BY img.res_prompt.id;



CREATE TABLE img.sampler (
    id bigint NOT NULL,
    name text NOT NULL
);



CREATE SEQUENCE img.sampler_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE img.sampler_id_seq OWNED BY img.sampler.id;



CREATE TABLE img.tag_en (
    id bigint NOT NULL,
    val text NOT NULL
);



CREATE SEQUENCE img.tag_en_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE img.tag_en_id_seq OWNED BY img.tag_en.id;



ALTER TABLE ONLY img.genway ALTER COLUMN id SET DEFAULT nextval('img.genway_id_seq'::regclass);



ALTER TABLE ONLY img.nprompt ALTER COLUMN id SET DEFAULT nextval('img.nprompt_id_seq'::regclass);



ALTER TABLE ONLY img.prompt ALTER COLUMN id SET DEFAULT nextval('img.prompt_id_seq'::regclass);



ALTER TABLE ONLY img.res ALTER COLUMN id SET DEFAULT nextval('img.res_hash_id_seq'::regclass);



ALTER TABLE ONLY img.res2url ALTER COLUMN id SET DEFAULT nextval('img.res2url_id_seq'::regclass);



ALTER TABLE ONLY img.res_group ALTER COLUMN id SET DEFAULT nextval('img.res_group_id_seq'::regclass);



ALTER TABLE ONLY img.res_kind ALTER COLUMN id SET DEFAULT nextval('img.res_kind_id_seq'::regclass);



ALTER TABLE ONLY img.res_name ALTER COLUMN id SET DEFAULT nextval('img.res_name_id_seq'::regclass);



ALTER TABLE ONLY img.res_prompt ALTER COLUMN id SET DEFAULT nextval('img.res_prompt_id_seq'::regclass);



ALTER TABLE ONLY img.res_url ALTER COLUMN id SET DEFAULT nextval('img.res_id_seq'::regclass);



ALTER TABLE ONLY img.sampler ALTER COLUMN id SET DEFAULT nextval('img.sampler_id_seq'::regclass);



ALTER TABLE ONLY img.tag_en ALTER COLUMN id SET DEFAULT nextval('img.tag_en_id_seq'::regclass);



ALTER TABLE ONLY img.genway
    ADD CONSTRAINT genway_name_key UNIQUE (name);



ALTER TABLE ONLY img.genway
    ADD CONSTRAINT genway_pkey PRIMARY KEY (id);



ALTER TABLE ONLY img.nprompt
    ADD CONSTRAINT nprompt_hash_key UNIQUE (hash);



ALTER TABLE ONLY img.nprompt
    ADD CONSTRAINT nprompt_pkey PRIMARY KEY (id);



ALTER TABLE ONLY img.prompt
    ADD CONSTRAINT prompt_hash_key UNIQUE (hash);



ALTER TABLE ONLY img.prompt
    ADD CONSTRAINT prompt_pkey PRIMARY KEY (id);



ALTER TABLE ONLY img.res2url
    ADD CONSTRAINT res2url_res_id_url_id_key UNIQUE (res_id, url_id);



ALTER TABLE ONLY img.res_group
    ADD CONSTRAINT res_group_pkey PRIMARY KEY (id);



ALTER TABLE ONLY img.res_kind
    ADD CONSTRAINT res_kind_pkey PRIMARY KEY (id);



ALTER TABLE ONLY img.res_kind
    ADD CONSTRAINT res_kind_val_key UNIQUE (val);



ALTER TABLE ONLY img.res_name
    ADD CONSTRAINT res_name_pkey PRIMARY KEY (id);



ALTER TABLE ONLY img.res_name
    ADD CONSTRAINT res_name_val_key UNIQUE (val);



ALTER TABLE ONLY img.res
    ADD CONSTRAINT res_pkey PRIMARY KEY (id);



ALTER TABLE ONLY img.res_prompt
    ADD CONSTRAINT res_prompt_pkey PRIMARY KEY (id);



ALTER TABLE ONLY img.res_prompt
    ADD CONSTRAINT res_prompt_val_key UNIQUE (val);



ALTER TABLE ONLY img.res_url
    ADD CONSTRAINT res_url_pkey PRIMARY KEY (id);



ALTER TABLE ONLY img.sampler
    ADD CONSTRAINT sampler_name_key UNIQUE (name);



ALTER TABLE ONLY img.sampler
    ADD CONSTRAINT sampler_pkey PRIMARY KEY (id);



ALTER TABLE ONLY img.tag_en
    ADD CONSTRAINT tag_en_pkey PRIMARY KEY (id);



ALTER TABLE ONLY img.tag_en
    ADD CONSTRAINT tag_en_val_key UNIQUE (val);



CREATE UNIQUE INDEX "nprompt.hash" ON img.nprompt USING btree (hash);



CREATE UNIQUE INDEX "prompt.hash" ON img.prompt USING btree (hash);



CREATE UNIQUE INDEX res_group_val_idx ON img.res_group USING btree (val);



CREATE UNIQUE INDEX res_kind_hash_name_id_prompt_id_idx ON img.res USING btree (kind_id, hash, name_id, prompt_id);



