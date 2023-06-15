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
CREATE SCHEMA sd_miss;
SET search_path TO sd_miss;
SET default_tablespace = '';
SET default_table_access_method = heap;
CREATE TABLE kind (
    id bigint NOT NULL,
    val character varying(255) NOT NULL
);
CREATE SEQUENCE kind_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE kind_id_seq OWNED BY kind.id;
CREATE TABLE miss (
    id bigint NOT NULL,
    kind_id public.u8 NOT NULL,
    hash bytea,
    name_li text[] DEFAULT '{}'::text[] NOT NULL
);
CREATE SEQUENCE miss_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE miss_id_seq OWNED BY miss.id;
ALTER TABLE ONLY kind ALTER COLUMN id SET DEFAULT nextval('kind_id_seq'::regclass);
ALTER TABLE ONLY miss ALTER COLUMN id SET DEFAULT nextval('miss_id_seq'::regclass);
ALTER TABLE ONLY kind
    ADD CONSTRAINT kind_val_key UNIQUE (val);
ALTER TABLE ONLY miss
    ADD CONSTRAINT miss_kind_id_hash_key UNIQUE (kind_id, hash);
ALTER TABLE ONLY miss
    ADD CONSTRAINT miss_pkey PRIMARY KEY (id);