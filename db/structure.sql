--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.0
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: playlist_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE playlist_items (
    id integer NOT NULL,
    playlist_id integer NOT NULL,
    creator_id integer NOT NULL,
    playlist_position integer NOT NULL,
    media_type character varying NOT NULL,
    media_url character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: playlist_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE playlist_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: playlist_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE playlist_items_id_seq OWNED BY playlist_items.id;


--
-- Name: playlists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE playlists (
    id integer NOT NULL,
    creator_id integer NOT NULL,
    name character varying NOT NULL,
    playlist_items_count integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: playlists_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE playlists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: playlists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE playlists_id_seq OWNED BY playlists.id;


--
-- Name: rooms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE rooms (
    id integer NOT NULL,
    owner_id integer NOT NULL,
    name character varying NOT NULL,
    status character varying DEFAULT 'offline'::character varying NOT NULL,
    media_offset integer DEFAULT 0 NOT NULL,
    last_online_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    playlist_item_id integer,
    CONSTRAINT check_rooms_on_status CHECK (((status)::text = ANY ((ARRAY['playing'::character varying, 'paused'::character varying, 'offline'::character varying])::text[])))
);


--
-- Name: rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rooms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rooms_id_seq OWNED BY rooms.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying NOT NULL,
    email character varying NOT NULL,
    poniverse_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: playlist_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY playlist_items ALTER COLUMN id SET DEFAULT nextval('playlist_items_id_seq'::regclass);


--
-- Name: playlists id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY playlists ALTER COLUMN id SET DEFAULT nextval('playlists_id_seq'::regclass);


--
-- Name: rooms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rooms ALTER COLUMN id SET DEFAULT nextval('rooms_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: playlist_items playlist_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY playlist_items
    ADD CONSTRAINT playlist_items_pkey PRIMARY KEY (id);


--
-- Name: playlists playlists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY playlists
    ADD CONSTRAINT playlists_pkey PRIMARY KEY (id);


--
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_playlist_items_on_creator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_playlist_items_on_creator_id ON playlist_items USING btree (creator_id);


--
-- Name: index_playlist_items_on_playlist_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_playlist_items_on_playlist_id ON playlist_items USING btree (playlist_id);


--
-- Name: index_playlists_on_creator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_playlists_on_creator_id ON playlists USING btree (creator_id);


--
-- Name: index_rooms_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_rooms_on_name ON rooms USING btree (name);


--
-- Name: index_rooms_on_owner_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rooms_on_owner_id ON rooms USING btree (owner_id);


--
-- Name: index_rooms_on_playlist_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rooms_on_playlist_item_id ON rooms USING btree (playlist_item_id);


--
-- Name: index_rooms_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rooms_on_status ON rooms USING btree (status);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_name ON users USING btree (name);


--
-- Name: rooms fk_rails_0704b8e2d2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT fk_rails_0704b8e2d2 FOREIGN KEY (owner_id) REFERENCES users(id);


--
-- Name: playlist_items fk_rails_6b8790694d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY playlist_items
    ADD CONSTRAINT fk_rails_6b8790694d FOREIGN KEY (playlist_id) REFERENCES playlists(id);


--
-- Name: rooms fk_rails_6ea97677d6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY rooms
    ADD CONSTRAINT fk_rails_6ea97677d6 FOREIGN KEY (playlist_item_id) REFERENCES playlist_items(id);


--
-- Name: playlist_items fk_rails_c6af926709; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY playlist_items
    ADD CONSTRAINT fk_rails_c6af926709 FOREIGN KEY (creator_id) REFERENCES users(id);


--
-- Name: playlists fk_rails_eb7ef5df60; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY playlists
    ADD CONSTRAINT fk_rails_eb7ef5df60 FOREIGN KEY (creator_id) REFERENCES users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES
('20170128191746'),
('20170128194508'),
('20170128200145'),
('20170128200522'),
('20170128212033');


