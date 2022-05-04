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

DROP DATABASE worldcup;
--
-- Name: worldcup; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE worldcup WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE worldcup OWNER TO freecodecamp;

\connect worldcup

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
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    year integer NOT NULL,
    round character varying(30) NOT NULL,
    winner_id integer NOT NULL,
    opponent_id integer NOT NULL,
    winner_goals integer NOT NULL,
    opponent_goals integer NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.teams (
    team_id integer NOT NULL,
    name character varying(30) NOT NULL
);


ALTER TABLE public.teams OWNER TO freecodecamp;

--
-- Name: teams_team_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.teams_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_team_id_seq OWNER TO freecodecamp;

--
-- Name: teams_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.teams_team_id_seq OWNED BY public.teams.team_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: teams team_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams ALTER COLUMN team_id SET DEFAULT nextval('public.teams_team_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (166, 2018, 'Final', 137, 138, 4, 2);
INSERT INTO public.games VALUES (167, 2018, 'Third Place', 139, 140, 2, 0);
INSERT INTO public.games VALUES (168, 2018, 'Semi-Final', 138, 140, 2, 1);
INSERT INTO public.games VALUES (169, 2018, 'Semi-Final', 137, 139, 1, 0);
INSERT INTO public.games VALUES (170, 2018, 'Quarter-Final', 138, 141, 3, 2);
INSERT INTO public.games VALUES (171, 2018, 'Quarter-Final', 140, 142, 2, 0);
INSERT INTO public.games VALUES (172, 2018, 'Quarter-Final', 139, 143, 2, 1);
INSERT INTO public.games VALUES (173, 2018, 'Quarter-Final', 137, 144, 2, 0);
INSERT INTO public.games VALUES (174, 2018, 'Eighth-Final', 140, 145, 2, 1);
INSERT INTO public.games VALUES (175, 2018, 'Eighth-Final', 142, 146, 1, 0);
INSERT INTO public.games VALUES (176, 2018, 'Eighth-Final', 139, 147, 3, 2);
INSERT INTO public.games VALUES (177, 2018, 'Eighth-Final', 143, 148, 2, 0);
INSERT INTO public.games VALUES (178, 2018, 'Eighth-Final', 138, 149, 2, 1);
INSERT INTO public.games VALUES (179, 2018, 'Eighth-Final', 141, 150, 2, 1);
INSERT INTO public.games VALUES (180, 2018, 'Eighth-Final', 144, 151, 2, 1);
INSERT INTO public.games VALUES (181, 2018, 'Eighth-Final', 137, 152, 4, 3);
INSERT INTO public.games VALUES (182, 2014, 'Final', 153, 152, 1, 0);
INSERT INTO public.games VALUES (183, 2014, 'Third Place', 154, 143, 3, 0);
INSERT INTO public.games VALUES (184, 2014, 'Semi-Final', 152, 154, 1, 0);
INSERT INTO public.games VALUES (185, 2014, 'Semi-Final', 153, 143, 7, 1);
INSERT INTO public.games VALUES (186, 2014, 'Quarter-Final', 154, 155, 1, 0);
INSERT INTO public.games VALUES (187, 2014, 'Quarter-Final', 152, 139, 1, 0);
INSERT INTO public.games VALUES (188, 2014, 'Quarter-Final', 143, 145, 2, 1);
INSERT INTO public.games VALUES (189, 2014, 'Quarter-Final', 153, 137, 1, 0);
INSERT INTO public.games VALUES (190, 2014, 'Eighth-Final', 143, 156, 2, 1);
INSERT INTO public.games VALUES (191, 2014, 'Eighth-Final', 145, 144, 2, 0);
INSERT INTO public.games VALUES (192, 2014, 'Eighth-Final', 137, 157, 2, 0);
INSERT INTO public.games VALUES (193, 2014, 'Eighth-Final', 153, 158, 2, 1);
INSERT INTO public.games VALUES (194, 2014, 'Eighth-Final', 154, 148, 2, 1);
INSERT INTO public.games VALUES (195, 2014, 'Eighth-Final', 155, 159, 2, 1);
INSERT INTO public.games VALUES (196, 2014, 'Eighth-Final', 152, 146, 1, 0);
INSERT INTO public.games VALUES (197, 2014, 'Eighth-Final', 139, 160, 2, 1);


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.teams VALUES (137, 'France');
INSERT INTO public.teams VALUES (138, 'Croatia');
INSERT INTO public.teams VALUES (139, 'Belgium');
INSERT INTO public.teams VALUES (140, 'England');
INSERT INTO public.teams VALUES (141, 'Russia');
INSERT INTO public.teams VALUES (142, 'Sweden');
INSERT INTO public.teams VALUES (143, 'Brazil');
INSERT INTO public.teams VALUES (144, 'Uruguay');
INSERT INTO public.teams VALUES (145, 'Colombia');
INSERT INTO public.teams VALUES (146, 'Switzerland');
INSERT INTO public.teams VALUES (147, 'Japan');
INSERT INTO public.teams VALUES (148, 'Mexico');
INSERT INTO public.teams VALUES (149, 'Denmark');
INSERT INTO public.teams VALUES (150, 'Spain');
INSERT INTO public.teams VALUES (151, 'Portugal');
INSERT INTO public.teams VALUES (152, 'Argentina');
INSERT INTO public.teams VALUES (153, 'Germany');
INSERT INTO public.teams VALUES (154, 'Netherlands');
INSERT INTO public.teams VALUES (155, 'Costa Rica');
INSERT INTO public.teams VALUES (156, 'Chile');
INSERT INTO public.teams VALUES (157, 'Nigeria');
INSERT INTO public.teams VALUES (158, 'Algeria');
INSERT INTO public.teams VALUES (159, 'Greece');
INSERT INTO public.teams VALUES (160, 'United States');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 197, true);


--
-- Name: teams_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.teams_team_id_seq', 160, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: teams teams_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_name_key UNIQUE (name);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);


--
-- Name: games games_opponent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_opponent_id_fkey FOREIGN KEY (opponent_id) REFERENCES public.teams(team_id);


--
-- Name: games games_winner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_winner_id_fkey FOREIGN KEY (winner_id) REFERENCES public.teams(team_id);


--
-- PostgreSQL database dump complete
--


