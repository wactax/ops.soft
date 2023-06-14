SET statement_timeout = 0;

SET lock_timeout = 0;

SET idle_in_transaction_session_timeout = 0;

SET client_encoding = 'UTF8';

SET standard_conforming_strings = ON;

SELECT pg_catalog.set_config('search_path', '', FALSE);

SET check_function_bodies = FALSE;

SET xmloption = content;

SET client_min_messages = warning;

SET row_security = OFF;

ALTER TABLE IF EXISTS ONLY sd."user"
  DROP CONSTRAINT IF EXISTS user_pkey;

ALTER TABLE IF EXISTS ONLY sd."user"
  DROP CONSTRAINT IF EXISTS user_cid_rid_key;

ALTER TABLE IF EXISTS ONLY sd.kind
  DROP CONSTRAINT IF EXISTS kind_pkey;

ALTER TABLE IF EXISTS ONLY sd.res_ver
  DROP CONSTRAINT IF EXISTS res_ver_pkey;

ALTER TABLE IF EXISTS ONLY sd.res_ver_file
  DROP CONSTRAINT IF EXISTS res_ver_file_pkey;

ALTER TABLE IF EXISTS ONLY sd.res
  DROP CONSTRAINT IF EXISTS res_pkey;

ALTER TABLE IF EXISTS ONLY sd.res
  DROP CONSTRAINT IF EXISTS res_cid_rid_key;

ALTER TABLE IF EXISTS sd."user"
  ALTER COLUMN id DROP DEFAULT;

ALTER TABLE IF EXISTS sd.kind
  ALTER COLUMN id DROP DEFAULT;

ALTER TABLE IF EXISTS sd.res_ver_file
  ALTER COLUMN id DROP DEFAULT;

ALTER TABLE IF EXISTS sd.res_ver
  ALTER COLUMN id DROP DEFAULT;

ALTER TABLE IF EXISTS sd.res
  ALTER COLUMN id DROP DEFAULT;

DROP SEQUENCE IF EXISTS sd.user_id_seq;

DROP TABLE IF EXISTS sd."user";

DROP SEQUENCE IF EXISTS sd.kind_id_seq;

DROP TABLE IF EXISTS sd.kind;

DROP SEQUENCE IF EXISTS sd.res_ver_id_seq;

DROP SEQUENCE IF EXISTS sd.res_ver_file_id_seq;

DROP TABLE IF EXISTS sd.res_ver_file;

DROP TABLE IF EXISTS sd.res_ver;

DROP SEQUENCE IF EXISTS sd.res_id_seq;

DROP TABLE IF EXISTS sd.res;

DROP SCHEMA IF EXISTS sd;

CREATE SCHEMA sd;

SET default_tablespace = '';

SET default_table_access_method = heap;

CREATE TABLE sd.res (
  id public.u64 NOT NULL, name character varying(255) NOT NULL, cid public.u8 NOT NULL, rid public.u64 NOT NULL, down public.u64 NOT NULL, ctime public.u64 DEFAULT (date_part('epoch'::text, now())) ::bigint NOT NULL, utime public.u64 DEFAULT (date_part('epoch'::text, now())) ::bigint NOT NULL, uid public.u64 NOT NULL, nsfw public.i8 DEFAULT '-1' ::integer NOT NULL
);

CREATE SEQUENCE sd.res_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;

ALTER SEQUENCE sd.res_id_seq OWNED BY sd.res.id;

CREATE TABLE sd.res_ver (
  id public.u64 NOT NULL, name bit varying(255) NOT NULL, res_id public.u64 NOT NULL, rid public.u64 NOT NULL, "time" public.u64 DEFAULT (date_part('epoch'::text, now())) ::bigint NOT NULL, down public.u64 DEFAULT 0 NOT NULL
);

CREATE TABLE sd.res_ver_file (
  id public.u64 NOT NULL, res_ver_id public.u64 NOT NULL, size public.u64 NOT NULL, name character varying(255) NOT NULL, rid public.u64 NOT NULL, auto_v2 public.u64 NOT NULL, sha256 bytea NOT NULL, blake3 bytea NOT NULL
);

CREATE SEQUENCE sd.res_ver_file_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;

ALTER SEQUENCE sd.res_ver_file_id_seq OWNED BY sd.res_ver_file.id;

CREATE SEQUENCE sd.res_ver_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;

ALTER SEQUENCE sd.res_ver_id_seq OWNED BY sd.res_ver.id;

CREATE TABLE sd.kind (
  id public.u16 NOT NULL, val bit varying(255) NOT NULL
);

CREATE SEQUENCE sd.kind_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;

ALTER SEQUENCE sd.kind_id_seq OWNED BY sd.kind.id;

CREATE TABLE sd."user" (
  id public.u64 NOT NULL, cid public.u16 NOT NULL, rid public.u64 NOT NULL, name character varying(255) NOT NULL
);

CREATE SEQUENCE sd.user_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;

ALTER SEQUENCE sd.user_id_seq OWNED BY sd."user".id;

ALTER TABLE ONLY sd.res
  ALTER COLUMN id SET DEFAULT nextval('sd.res_id_seq'::regclass);

ALTER TABLE ONLY sd.res_ver
  ALTER COLUMN id SET DEFAULT nextval('sd.res_ver_id_seq'::regclass);

ALTER TABLE ONLY sd.res_ver_file
  ALTER COLUMN id SET DEFAULT nextval('sd.res_ver_file_id_seq'::regclass);

ALTER TABLE ONLY sd.kind
  ALTER COLUMN id SET DEFAULT nextval('sd.kind_id_seq'::regclass);

ALTER TABLE ONLY sd."user"
  ALTER COLUMN id SET DEFAULT nextval('sd.user_id_seq'::regclass);

ALTER TABLE ONLY sd.res
  ADD CONSTRAINT res_cid_rid_key UNIQUE (cid, rid);

ALTER TABLE ONLY sd.res
  ADD CONSTRAINT res_pkey PRIMARY KEY (id);

ALTER TABLE ONLY sd.res_ver_file
  ADD CONSTRAINT res_ver_file_pkey PRIMARY KEY (id);

ALTER TABLE ONLY sd.res_ver
  ADD CONSTRAINT res_ver_pkey PRIMARY KEY (id);

ALTER TABLE ONLY sd.kind
  ADD CONSTRAINT kind_pkey PRIMARY KEY (id);

ALTER TABLE ONLY sd."user"
  ADD CONSTRAINT user_cid_rid_key UNIQUE (cid, rid);

ALTER TABLE ONLY sd."user"
  ADD CONSTRAINT user_pkey PRIMARY KEY (id);
