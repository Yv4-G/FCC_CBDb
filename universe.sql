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

DROP DATABASE universe;

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';

ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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

SET default_tablespace = '';
SET default_table_access_method = heap;

CREATE TABLE public.blackhole (
    blackhole_id integer NOT NULL,
    gravity integer,
    galaxy_id integer,
    wormhole boolean DEFAULT false NOT NULL,
    name character varying(255) NOT NULL
);

ALTER TABLE public.blackhole OWNER TO freecodecamp;

CREATE SEQUENCE public.blackhole_blackhole_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.blackhole_blackhole_id_seq OWNER TO freecodecamp;

ALTER SEQUENCE public.blackhole_blackhole_id_seq OWNED BY public.blackhole.blackhole_id;

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    speed integer,
    description text,
    name character varying(255) NOT NULL,
    rotation_speed integer DEFAULT 100000 NOT NULL
);

ALTER TABLE public.galaxy OWNER TO freecodecamp;

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(255) NOT NULL,
    has_water boolean NOT NULL,
    planet_id integer NOT NULL,
    name_code character varying(255) NOT NULL
);

ALTER TABLE public.moon OWNER TO freecodecamp;

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(255) NOT NULL,
    amount_of_people numeric,
    time_travel boolean DEFAULT false NOT NULL,
    star_id integer NOT NULL
);

ALTER TABLE public.planet OWNER TO freecodecamp;

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;

CREATE TABLE public.star (
    star_id integer NOT NULL,
    radius integer NOT NULL,
    color character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    galaxy_id integer
);

ALTER TABLE public.star OWNER TO freecodecamp;

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;

ALTER TABLE ONLY public.blackhole ALTER COLUMN blackhole_id SET DEFAULT nextval('public.blackhole_blackhole_id_seq'::regclass);
ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);
ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);
ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);
ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);

INSERT INTO public.blackhole VALUES (1, NULL, NULL, false, 'bh1');
INSERT INTO public.blackhole VALUES (2, NULL, NULL, false, 'bh2');
INSERT INTO public.blackhole VALUES (3, NULL, NULL, false, 'bh3');

INSERT INTO public.galaxy VALUES (1, NULL, NULL, 'andromeda', 100000);
INSERT INTO public.galaxy VALUES (2, NULL, NULL, 'galaxy2', 100000);
INSERT INTO public.galaxy VALUES (3, NULL, NULL, 'galaxy3', 100000);
INSERT INTO public.galaxy VALUES (4, NULL, NULL, 'galaxy4', 100000);
INSERT INTO public.galaxy VALUES (5, NULL, NULL, 'galaxy5', 100000);
INSERT INTO public.galaxy VALUES (6, NULL, NULL, 'galaxy6', 100000);

ALTER TABLE ONLY public.blackhole ADD CONSTRAINT blackhole_name_key UNIQUE (name);
ALTER TABLE ONLY public.blackhole ADD CONSTRAINT blackhole_pkey PRIMARY KEY (blackhole_id);
ALTER TABLE ONLY public.galaxy ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);
ALTER TABLE ONLY public.moon ADD CONSTRAINT moon_name_code_key UNIQUE (name_code);
ALTER TABLE ONLY public.moon ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);
ALTER TABLE ONLY public.galaxy ADD CONSTRAINT name_unique UNIQUE (name);
ALTER TABLE ONLY public.planet ADD CONSTRAINT name_unique_planet UNIQUE (name);
ALTER TABLE ONLY public.star ADD CONSTRAINT name_unique_star UNIQUE (name);
ALTER TABLE ONLY public.planet ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);
ALTER TABLE ONLY public.star ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);
ALTER TABLE ONLY public.star ADD CONSTRAINT fk_galaxy FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);
ALTER TABLE ONLY public.moon ADD CONSTRAINT fk_planet FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);
ALTER TABLE ONLY public.planet ADD CONSTRAINT fk_star FOREIGN KEY (star_id) REFERENCES public.star(star_id);
