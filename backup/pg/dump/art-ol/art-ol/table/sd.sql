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
CREATE SCHEMA sd;
SET search_path TO sd;
CREATE OR REPLACE FUNCTION update_res_ver_down() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
  IF TG_OP = 'UPDATE' THEN 
    IF OLD.down != NEW.down THEN 
UPDATE res SET down = down - OLD.down + NEW.down WHERE res.id = OLD.res_id; 
    END IF;
  ELSIF TG_OP = 'INSERT' THEN
UPDATE res SET down = down + NEW.down WHERE res.id = NEW.res_id; 
  ELSIF TG_OP = 'DELETE' THEN
UPDATE res SET down = down - OLD.down WHERE res.id = OLD.res_id; 
  END IF;
  RETURN NEW;
END;
$$;
SET default_tablespace = '';
SET default_table_access_method = heap;
CREATE TABLE ext (
    id smallint NOT NULL,
    val character varying(255) NOT NULL
);
CREATE SEQUENCE ext_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE ext_id_seq OWNED BY ext.id;
CREATE TABLE kind (
    id public.u16 NOT NULL,
    val character varying(255)
);
CREATE SEQUENCE kind_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE kind_id_seq OWNED BY kind.id;
CREATE TABLE res (
    id public.u64 NOT NULL,
    name character varying(255) NOT NULL,
    cid public.u8 NOT NULL,
    rid public.u64 NOT NULL,
    down public.u64 DEFAULT 0 NOT NULL,
    ctime public.u64 DEFAULT (date_part('epoch'::text, now()))::bigint NOT NULL,
    utime public.u64 DEFAULT (date_part('epoch'::text, now()))::bigint NOT NULL,
    nsfw public.i8 DEFAULT '-1'::integer NOT NULL,
    kind_id public.u16
);
CREATE TABLE res_file (
    id public.u64 NOT NULL,
    res_ver_id public.u64 NOT NULL,
    size public.u64 NOT NULL,
    name character varying(255) NOT NULL,
    rid public.u64 NOT NULL,
    auto_v2 public.u64 NOT NULL,
    sha256 bytea NOT NULL,
    blake3 bytea NOT NULL,
    ext_id public.u32 NOT NULL,
    res_id public.u64 NOT NULL
);
CREATE TABLE res_file_alias (
    id public.u64 NOT NULL,
    val text NOT NULL
);
CREATE TABLE res_file_downed (
    id public.u64 NOT NULL
);
CREATE TABLE res_file_failed (
    id public.u64 NOT NULL
);
CREATE SEQUENCE res_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE res_file_id_seq OWNED BY res_file.id;
CREATE SEQUENCE res_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE res_id_seq OWNED BY res.id;
CREATE TABLE res_ver (
    id public.u64 NOT NULL,
    res_id public.u64 NOT NULL,
    rid public.u64 NOT NULL,
    "time" public.u64 DEFAULT (date_part('epoch'::text, now()))::bigint NOT NULL,
    down public.u64 DEFAULT 0 NOT NULL,
    name character varying(255) NOT NULL
);
CREATE SEQUENCE res_ver_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE res_ver_id_seq OWNED BY res_ver.id;
CREATE TABLE word (
    id bigint NOT NULL,
    val character varying(255) NOT NULL
);
CREATE SEQUENCE res_word_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE res_word_id_seq OWNED BY word.id;
CREATE TABLE word_res_ver (
    id bigint NOT NULL,
    word_id public.u64 NOT NULL,
    res_ver_id public.u64 NOT NULL
);
CREATE SEQUENCE word_res_ver_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE word_res_ver_id_seq OWNED BY word_res_ver.id;
ALTER TABLE ONLY ext ALTER COLUMN id SET DEFAULT nextval('ext_id_seq'::regclass);
ALTER TABLE ONLY kind ALTER COLUMN id SET DEFAULT nextval('kind_id_seq'::regclass);
ALTER TABLE ONLY res ALTER COLUMN id SET DEFAULT nextval('res_id_seq'::regclass);
ALTER TABLE ONLY res_file ALTER COLUMN id SET DEFAULT nextval('res_file_id_seq'::regclass);
ALTER TABLE ONLY res_ver ALTER COLUMN id SET DEFAULT nextval('res_ver_id_seq'::regclass);
ALTER TABLE ONLY word ALTER COLUMN id SET DEFAULT nextval('res_word_id_seq'::regclass);
ALTER TABLE ONLY word_res_ver ALTER COLUMN id SET DEFAULT nextval('word_res_ver_id_seq'::regclass);
ALTER TABLE ONLY ext
    ADD CONSTRAINT ext_pkey PRIMARY KEY (id);
ALTER TABLE ONLY ext
    ADD CONSTRAINT ext_val_key UNIQUE (val);
ALTER TABLE ONLY kind
    ADD CONSTRAINT kind_pkey PRIMARY KEY (id);
ALTER TABLE ONLY res_file_alias
    ADD CONSTRAINT res_alias_pkey PRIMARY KEY (id);
ALTER TABLE ONLY res
    ADD CONSTRAINT res_cid_rid_key UNIQUE (cid, rid);
ALTER TABLE ONLY res_file_downed
    ADD CONSTRAINT res_file_downed_pkey PRIMARY KEY (id);
ALTER TABLE ONLY res_file_failed
    ADD CONSTRAINT res_file_failed_pkey PRIMARY KEY (id);
ALTER TABLE ONLY res_file
    ADD CONSTRAINT res_file_pkey PRIMARY KEY (id);
ALTER TABLE ONLY res
    ADD CONSTRAINT res_pkey PRIMARY KEY (id);
ALTER TABLE ONLY res_ver
    ADD CONSTRAINT res_ver_pkey PRIMARY KEY (id);
ALTER TABLE ONLY res_ver
    ADD CONSTRAINT res_ver_res_id_rid_key UNIQUE (res_id, rid);
ALTER TABLE ONLY word
    ADD CONSTRAINT res_word_pkey PRIMARY KEY (id);
ALTER TABLE ONLY word
    ADD CONSTRAINT res_word_val_key UNIQUE (val);
ALTER TABLE ONLY word_res_ver
    ADD CONSTRAINT word_res_ver_pkey PRIMARY KEY (id);
ALTER TABLE ONLY word_res_ver
    ADD CONSTRAINT word_res_ver_word_id_res_ver_id_key UNIQUE (word_id, res_ver_id);
CREATE INDEX IF NOT EXISTS res_file_alias_val_idx ON res_file_alias USING btree (val);
CREATE INDEX IF NOT EXISTS res_file_res_id_idx ON res_file USING btree (res_id);
CREATE TRIGGER res_ver_down_trigger AFTER INSERT OR DELETE OR UPDATE OF down ON res_ver FOR EACH ROW EXECUTE FUNCTION update_res_ver_down();