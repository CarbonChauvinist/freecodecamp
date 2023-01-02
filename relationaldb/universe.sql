--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

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

--
-- Name: classification; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.classification (
    classification_id integer NOT NULL,
    class_type character varying NOT NULL,
    name character varying NOT NULL,
    description text
);


ALTER TABLE public.classification OWNER TO freecodecamp;

--
-- Name: classification_type_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.classification_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.classification_type_id_seq OWNER TO freecodecamp;

--
-- Name: classification_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.classification_type_id_seq OWNED BY public.classification.classification_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying NOT NULL,
    distance numeric(6,3) NOT NULL,
    class_type integer,
    nbr_of_stars text,
    apparent_magnitude numeric(6,2)
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying NOT NULL,
    may_have_water boolean,
    mean_radius_in_km numeric(8,1),
    planet_id integer NOT NULL
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying NOT NULL,
    is_gas_giant boolean NOT NULL,
    mean_radius_in_km numeric(12,4),
    discovery_date date,
    star_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying NOT NULL,
    visible_to_unaided_eye boolean NOT NULL,
    stellar_class integer,
    mass numeric(18,4),
    apparent_magnitude numeric(6,2),
    galaxy_id integer NOT NULL
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: classification classification_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.classification ALTER COLUMN classification_id SET DEFAULT nextval('public.classification_type_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: classification; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.classification VALUES (1, 'galaxy', 'SB(rs)bc', 'Barred Spiral with weak central ring of stars and gas around the nucleus');
INSERT INTO public.classification VALUES (2, 'galaxy', 'Irr', 'Irregular');
INSERT INTO public.classification VALUES (3, 'galaxy', 'dSph', 'Dwarf spheroidal galaxy - small, low-luminosity with very little dust and an older stellar population');
INSERT INTO public.classification VALUES (4, 'galaxy', 'dSph(t)', 'Dwarf spheroidal galaxy - small, low-luminosity with very little dust and an older stellar population with tidal arm -- a spiral arm presumed distorted by tidal forces');
INSERT INTO public.classification VALUES (5, 'galaxy', 'SB(s)m', 'Barred Spiral without rings irregular');
INSERT INTO public.classification VALUES (6, 'galaxy', 'SB(s)m pec', 'Barred Spiral without rings irregular - peculiar, odd in some way');
INSERT INTO public.classification VALUES (7, 'stellar', 'G2V', NULL);
INSERT INTO public.classification VALUES (8, 'stellar', 'M5.5Ve', NULL);
INSERT INTO public.classification VALUES (9, 'stellar', 'K1V', NULL);
INSERT INTO public.classification VALUES (10, 'stellar', 'M4.0Ve', NULL);
INSERT INTO public.classification VALUES (11, 'stellar', 'L8±1', NULL);
INSERT INTO public.classification VALUES (12, 'stellar', 'M2V', NULL);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 0.000, 1, '100-400 billion', NULL);
INSERT INTO public.galaxy VALUES (2, 'Canis Major Dwarf', 0.025, 2, '1 billion', NULL);
INSERT INTO public.galaxy VALUES (3, 'Virgo Stellar Stream', 0.030, 3, NULL, NULL);
INSERT INTO public.galaxy VALUES (4, 'Sagittarius Dwarf Elliptical Galaxy', 0.081, 4, NULL, 4.50);
INSERT INTO public.galaxy VALUES (5, 'Large Magellanic Cloud', 0.163, 5, NULL, 0.13);
INSERT INTO public.galaxy VALUES (6, 'Small Magellanic Cloud', 0.197, 6, NULL, 2.70);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Moon', false, 1737.4, 3);
INSERT INTO public.moon VALUES (2, 'Metis', false, 21.5, 5);
INSERT INTO public.moon VALUES (3, 'Adrastea', false, 8.2, 5);
INSERT INTO public.moon VALUES (4, 'Amalthea', false, 83.5, 5);
INSERT INTO public.moon VALUES (5, 'Thebe', false, 49.3, 5);
INSERT INTO public.moon VALUES (6, 'Io', false, 1821.6, 5);
INSERT INTO public.moon VALUES (7, 'Europa', true, 1560.8, 5);
INSERT INTO public.moon VALUES (8, 'Ganymede', true, 2634.1, 5);
INSERT INTO public.moon VALUES (9, 'Callisto', false, 2410.3, 5);
INSERT INTO public.moon VALUES (10, 'Mimas', false, 198.2, 6);
INSERT INTO public.moon VALUES (11, 'Enceladus', true, 252.1, 6);
INSERT INTO public.moon VALUES (12, 'Tethys', false, 531.1, 6);
INSERT INTO public.moon VALUES (13, 'Dione', false, 561.4, 6);
INSERT INTO public.moon VALUES (14, 'Rhea', false, 763.8, 6);
INSERT INTO public.moon VALUES (15, 'Titan', true, 2574.7, 6);
INSERT INTO public.moon VALUES (16, 'Iapetus', false, 1469.0, 6);
INSERT INTO public.moon VALUES (17, 'Miranda', false, 235.8, 7);
INSERT INTO public.moon VALUES (18, 'Ariel', false, 578.9, 7);
INSERT INTO public.moon VALUES (19, 'Umbriel', false, 584.7, 7);
INSERT INTO public.moon VALUES (20, 'Titania', true, 788.4, 7);
INSERT INTO public.moon VALUES (21, 'Oberon', true, 761.4, 7);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', false, 2440.0000, NULL, 1);
INSERT INTO public.planet VALUES (2, 'Venus', false, 6051.8000, NULL, 1);
INSERT INTO public.planet VALUES (3, 'Earth', false, 6371.0000, NULL, 1);
INSERT INTO public.planet VALUES (4, 'Mars', false, 3389.5000, NULL, 1);
INSERT INTO public.planet VALUES (5, 'Jupiter', true, 69911.0000, NULL, 1);
INSERT INTO public.planet VALUES (6, 'Saturn', true, 58232.0000, NULL, 1);
INSERT INTO public.planet VALUES (7, 'Uranus', false, 25362.0000, '1781-03-13', 1);
INSERT INTO public.planet VALUES (8, 'Neptune', false, 24622.0000, '1846-09-23', 1);
INSERT INTO public.planet VALUES (9, 'Proxima Centauri b', false, 1.3000, '2016-08-24', 2);
INSERT INTO public.planet VALUES (10, 'Proxima Centauri d', false, 0.8100, '2020-01-01', 2);
INSERT INTO public.planet VALUES (11, 'Gliese 411 b', false, NULL, '2017-01-01', 7);
INSERT INTO public.planet VALUES (12, 'Gliese 411 c', false, NULL, '2017-01-01', 7);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', true, 7, 1.0000, -27.74, 1);
INSERT INTO public.star VALUES (2, 'Proxima Centauri', false, 8, 0.1220, 11.09, 1);
INSERT INTO public.star VALUES (3, 'Rigil Kentaurus', true, 7, 1.0790, 0.01, 1);
INSERT INTO public.star VALUES (4, 'Toliman', true, 9, 0.9090, 1.34, 1);
INSERT INTO public.star VALUES (5, 'Barnard''s Star', false, 10, 0.1440, 9.53, 1);
INSERT INTO public.star VALUES (6, 'Luhman 16 A', false, 11, 0.0320, 10.70, 1);
INSERT INTO public.star VALUES (7, 'Lalande 21185', false, 12, 0.3890, 7.52, 1);


--
-- Name: classification_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.classification_type_id_seq', 12, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 21, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 7, true);


--
-- Name: classification classification_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.classification
    ADD CONSTRAINT classification_name_key UNIQUE (name);


--
-- Name: classification classification_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.classification
    ADD CONSTRAINT classification_pkey PRIMARY KEY (classification_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

