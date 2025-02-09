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

DROP DATABASE IF EXISTS universe;

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';

ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET default_tablespace = '';
SET default_table_access_method = heap;

CREATE TABLE public.galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    speed INT NOT NULL,
    description TEXT,
    rotation_speed INT DEFAULT 100000 NOT NULL
);

CREATE TABLE public.star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    radius INT NOT NULL,
    color VARCHAR(255) NOT NULL,
    galaxy_id INT NOT NULL,
    has_planets BOOLEAN DEFAULT true NOT NULL,
    FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id) ON DELETE CASCADE
);

CREATE TABLE public.planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    amount_of_people NUMERIC,
    time_travel BOOLEAN DEFAULT false NOT NULL,
    star_id INT NOT NULL,
    atmosphere BOOLEAN DEFAULT true NOT NULL,
    FOREIGN KEY (star_id) REFERENCES public.star(star_id) ON DELETE CASCADE
);

CREATE TABLE public.moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    has_water BOOLEAN NOT NULL,
    planet_id INT NOT NULL,
    size INT NOT NULL,
    FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id) ON DELETE CASCADE
);

CREATE TABLE public.blackhole (
    blackhole_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    gravity INT NOT NULL,
    galaxy_id INT,
    wormhole BOOLEAN DEFAULT false NOT NULL,
    FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id) ON DELETE SET NULL
);

INSERT INTO public.galaxy (name, speed, description) VALUES
('Andromeda', 250000, 'A spiral galaxy'),
('Milky Way', 220000, 'Our home galaxy'),
('Triangulum', 200000, 'Part of the Local Group'),
('Whirlpool', 180000, 'Interacting galaxy'),
('Sombrero', 150000, 'Known for its bright nucleus'),
('Cartwheel', 130000, 'A ring galaxy');

INSERT INTO public.star (name, radius, color, galaxy_id) VALUES
('Sirius', 1200000, 'Blue', 1),
('Betelgeuse', 887000, 'Red', 2),
('Proxima Centauri', 220000, 'Red', 2),
('Rigel', 1300000, 'Blue', 3),
('Vega', 950000, 'White', 4),
('Altair', 800000, 'Yellow', 5);

INSERT INTO public.planet (name, amount_of_people, star_id) VALUES
('Earth', 8000000000, 2),
('Mars', 0, 2),
('Venus', 0, 2),
('Jupiter', 0, 2),
('Saturn', 0, 2),
('Kepler-22b', NULL, 3),
('Gliese 581g', NULL, 3),
('HD 209458b', NULL, 4),
('55 Cancri e', NULL, 4),
('Proxima b', NULL, 3),
('LHS 1140b', NULL, 5),
('TRAPPIST-1d', NULL, 6);

INSERT INTO public.moon (name, has_water, planet_id, size) VALUES
('Moon', true, 1, 3474),
('Phobos', false, 2, 22),
('Deimos', false, 2, 12),
('Ganymede', true, 4, 5262),
('Callisto', true, 4, 4821),
('Europa', true, 4, 3121),
('Titan', true, 5, 5150),
('Enceladus', true, 5, 504),
('Triton', true, 6, 2707),
('Charon', false, 6, 1212),
('Io', true, 4, 3643),
('Mimas', false, 5, 396),
('Oberon', false, 7, 1523),
('Miranda', false, 7, 471),
('Ariel', false, 7, 1157),
('Umbriel', false, 7, 1169),
('Titania', false, 7, 1577),
('Nereid', false, 8, 340),
('Proteus', false, 8, 418),
('Dysnomia', false, 9, 700),
('Hyperion', false, 5, 270),
('Iapetus', false, 5, 1469);

INSERT INTO public.blackhole (name, gravity, galaxy_id) VALUES
('Sagittarius A*', 4000000, 2),
('M87*', 6500000, 3),
('Cygnus X-1', 1500000, 1);
