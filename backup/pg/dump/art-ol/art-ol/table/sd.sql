

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


SET default_tablespace = '';

SET default_table_access_method = heap;


CREATE TABLE sd.checkpoint (
    id public.u64 NOT NULL,
    name character varying(255) NOT NULL,
    cid public.u8 NOT NULL,
    rid public.u64 NOT NULL,
    down public.u64 NOT NULL,
    ctime public.u64 DEFAULT (date_part('epoch'::text, now()))::bigint NOT NULL,
    utime public.u64 DEFAULT (date_part('epoch'::text, now()))::bigint NOT NULL,
    uid public.u64 NOT NULL
);



CREATE SEQUENCE sd.checkpoint_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE sd.checkpoint_id_seq OWNED BY sd.checkpoint.id;



CREATE TABLE sd.checkpoint_ver (
    id public.u64 NOT NULL,
    name bit varying(255) NOT NULL,
    checkpoint_id public.u64 NOT NULL,
    rid public.u64 NOT NULL,
    "time" public.u64 DEFAULT (date_part('epoch'::text, now()))::bigint NOT NULL,
    down public.u64 NOT NULL
);



CREATE TABLE sd.checkpoint_ver_file (
    id public.u64 NOT NULL,
    checkpoint_ver_id public.u64 NOT NULL,
    size public.u64 NOT NULL,
    name character varying(255) NOT NULL,
    rid public.u64 NOT NULL,
    auto_v2 public.u64 NOT NULL,
    sha256 bytea NOT NULL,
    blake3 bytea NOT NULL
);



CREATE SEQUENCE sd.checkpoint_ver_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE sd.checkpoint_ver_file_id_seq OWNED BY sd.checkpoint_ver_file.id;



CREATE SEQUENCE sd.checkpoint_ver_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE sd.checkpoint_ver_id_seq OWNED BY sd.checkpoint_ver.id;



CREATE TABLE sd."user" (
    id public.u64 NOT NULL,
    cid public.u16 NOT NULL,
    rid public.u64 NOT NULL,
    name character varying(255) NOT NULL
);



CREATE SEQUENCE sd.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE sd.user_id_seq OWNED BY sd."user".id;



ALTER TABLE ONLY sd.checkpoint ALTER COLUMN id SET DEFAULT nextval('sd.checkpoint_id_seq'::regclass);



ALTER TABLE ONLY sd.checkpoint_ver ALTER COLUMN id SET DEFAULT nextval('sd.checkpoint_ver_id_seq'::regclass);



ALTER TABLE ONLY sd.checkpoint_ver_file ALTER COLUMN id SET DEFAULT nextval('sd.checkpoint_ver_file_id_seq'::regclass);



ALTER TABLE ONLY sd."user" ALTER COLUMN id SET DEFAULT nextval('sd.user_id_seq'::regclass);



ALTER TABLE ONLY sd.checkpoint
    ADD CONSTRAINT checkpoint_cid_rid_key UNIQUE (cid, rid);



ALTER TABLE ONLY sd.checkpoint
    ADD CONSTRAINT checkpoint_pkey PRIMARY KEY (id);



ALTER TABLE ONLY sd.checkpoint_ver_file
    ADD CONSTRAINT checkpoint_ver_file_pkey PRIMARY KEY (id);



ALTER TABLE ONLY sd.checkpoint_ver
    ADD CONSTRAINT checkpoint_ver_pkey PRIMARY KEY (id);



ALTER TABLE ONLY sd."user"
    ADD CONSTRAINT user_cid_rid_key UNIQUE (cid, rid);



ALTER TABLE ONLY sd."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);



