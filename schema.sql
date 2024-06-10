--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.2

-- Started on 2024-06-10 15:24:28

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
-- TOC entry 226 (class 1259 OID 16520)
-- Name: coaches; Type: TABLE; Schema: public; Owner: sports_league_owner
--

CREATE TABLE public.coaches (
    coach_id integer NOT NULL,
    name character varying(255) NOT NULL,
    team_id integer,
    nationality character varying(100)
);


ALTER TABLE public.coaches OWNER TO sports_league_owner;

--
-- TOC entry 225 (class 1259 OID 16519)
-- Name: coaches_coach_id_seq; Type: SEQUENCE; Schema: public; Owner: sports_league_owner
--

CREATE SEQUENCE public.coaches_coach_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coaches_coach_id_seq OWNER TO sports_league_owner;

--
-- TOC entry 3479 (class 0 OID 0)
-- Dependencies: 225
-- Name: coaches_coach_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sports_league_owner
--

ALTER SEQUENCE public.coaches_coach_id_seq OWNED BY public.coaches.coach_id;


--
-- TOC entry 234 (class 1259 OID 106498)
-- Name: countries; Type: TABLE; Schema: public; Owner: sports_league_owner
--

CREATE TABLE public.countries (
    country_id integer NOT NULL,
    name character varying(255) NOT NULL,
    flag_url character varying(255)
);


ALTER TABLE public.countries OWNER TO sports_league_owner;

--
-- TOC entry 233 (class 1259 OID 106497)
-- Name: countries_country_id_seq; Type: SEQUENCE; Schema: public; Owner: sports_league_owner
--

CREATE SEQUENCE public.countries_country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.countries_country_id_seq OWNER TO sports_league_owner;

--
-- TOC entry 3480 (class 0 OID 0)
-- Dependencies: 233
-- Name: countries_country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sports_league_owner
--

ALTER SEQUENCE public.countries_country_id_seq OWNED BY public.countries.country_id;


--
-- TOC entry 220 (class 1259 OID 16480)
-- Name: leagues; Type: TABLE; Schema: public; Owner: sports_league_owner
--

CREATE TABLE public.leagues (
    league_id integer NOT NULL,
    name character varying(255) NOT NULL,
    country character varying(255) NOT NULL,
    country_id integer,
    icon_url character varying(255),
    cl_spot integer,
    uel_spot integer,
    relegation_spot integer
);


ALTER TABLE public.leagues OWNER TO sports_league_owner;

--
-- TOC entry 219 (class 1259 OID 16479)
-- Name: leagues_league_id_seq; Type: SEQUENCE; Schema: public; Owner: sports_league_owner
--

CREATE SEQUENCE public.leagues_league_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.leagues_league_id_seq OWNER TO sports_league_owner;

--
-- TOC entry 3481 (class 0 OID 0)
-- Dependencies: 219
-- Name: leagues_league_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sports_league_owner
--

ALTER SEQUENCE public.leagues_league_id_seq OWNED BY public.leagues.league_id;


--
-- TOC entry 236 (class 1259 OID 122907)
-- Name: match_referees; Type: TABLE; Schema: public; Owner: sports_league_owner
--

CREATE TABLE public.match_referees (
    match_id integer NOT NULL,
    referee_id integer NOT NULL
);


ALTER TABLE public.match_referees OWNER TO sports_league_owner;

--
-- TOC entry 230 (class 1259 OID 16544)
-- Name: matches; Type: TABLE; Schema: public; Owner: sports_league_owner
--

CREATE TABLE public.matches (
    match_id integer NOT NULL,
    season_id integer,
    league_id integer,
    matchday integer,
    home_team_id integer,
    away_team_id integer,
    winner character varying(50),
    utc_date date
);


ALTER TABLE public.matches OWNER TO sports_league_owner;

--
-- TOC entry 229 (class 1259 OID 16543)
-- Name: matches_match_id_seq; Type: SEQUENCE; Schema: public; Owner: sports_league_owner
--

CREATE SEQUENCE public.matches_match_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.matches_match_id_seq OWNER TO sports_league_owner;

--
-- TOC entry 3482 (class 0 OID 0)
-- Dependencies: 229
-- Name: matches_match_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sports_league_owner
--

ALTER SEQUENCE public.matches_match_id_seq OWNED BY public.matches.match_id;


--
-- TOC entry 228 (class 1259 OID 16532)
-- Name: players; Type: TABLE; Schema: public; Owner: sports_league_owner
--

CREATE TABLE public.players (
    player_id integer NOT NULL,
    team_id integer,
    name character varying(255) NOT NULL,
    "position" character varying(50),
    date_of_birth date,
    nationality character varying(100)
);


ALTER TABLE public.players OWNER TO sports_league_owner;

--
-- TOC entry 227 (class 1259 OID 16531)
-- Name: players_player_id_seq; Type: SEQUENCE; Schema: public; Owner: sports_league_owner
--

CREATE SEQUENCE public.players_player_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.players_player_id_seq OWNER TO sports_league_owner;

--
-- TOC entry 3483 (class 0 OID 0)
-- Dependencies: 227
-- Name: players_player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sports_league_owner
--

ALTER SEQUENCE public.players_player_id_seq OWNED BY public.players.player_id;


--
-- TOC entry 235 (class 1259 OID 122902)
-- Name: referees; Type: TABLE; Schema: public; Owner: sports_league_owner
--

CREATE TABLE public.referees (
    referee_id integer NOT NULL,
    name character varying(100),
    nationality character varying(50)
);


ALTER TABLE public.referees OWNER TO sports_league_owner;

--
-- TOC entry 240 (class 1259 OID 139265)
-- Name: scorers; Type: TABLE; Schema: public; Owner: sports_league_owner
--

CREATE TABLE public.scorers (
    scorer_id integer NOT NULL,
    player_id integer NOT NULL,
    season_id integer NOT NULL,
    league_id integer NOT NULL,
    goals integer,
    assists integer,
    penalties integer
);


ALTER TABLE public.scorers OWNER TO sports_league_owner;

--
-- TOC entry 239 (class 1259 OID 139264)
-- Name: scorers_scorer_id_seq; Type: SEQUENCE; Schema: public; Owner: sports_league_owner
--

CREATE SEQUENCE public.scorers_scorer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.scorers_scorer_id_seq OWNER TO sports_league_owner;

--
-- TOC entry 3484 (class 0 OID 0)
-- Dependencies: 239
-- Name: scorers_scorer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sports_league_owner
--

ALTER SEQUENCE public.scorers_scorer_id_seq OWNED BY public.scorers.scorer_id;


--
-- TOC entry 238 (class 1259 OID 131073)
-- Name: scores; Type: TABLE; Schema: public; Owner: sports_league_owner
--

CREATE TABLE public.scores (
    score_id integer NOT NULL,
    match_id integer,
    full_time_home integer,
    full_time_away integer,
    half_time_home integer,
    half_time_away integer
);


ALTER TABLE public.scores OWNER TO sports_league_owner;

--
-- TOC entry 237 (class 1259 OID 131072)
-- Name: scores_score_id_seq; Type: SEQUENCE; Schema: public; Owner: sports_league_owner
--

CREATE SEQUENCE public.scores_score_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.scores_score_id_seq OWNER TO sports_league_owner;

--
-- TOC entry 3485 (class 0 OID 0)
-- Dependencies: 237
-- Name: scores_score_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sports_league_owner
--

ALTER SEQUENCE public.scores_score_id_seq OWNED BY public.scores.score_id;


--
-- TOC entry 222 (class 1259 OID 16489)
-- Name: seasons; Type: TABLE; Schema: public; Owner: sports_league_owner
--

CREATE TABLE public.seasons (
    season_id integer NOT NULL,
    league_id integer,
    year character varying(9) NOT NULL
);


ALTER TABLE public.seasons OWNER TO sports_league_owner;

--
-- TOC entry 221 (class 1259 OID 16488)
-- Name: seasons_season_id_seq; Type: SEQUENCE; Schema: public; Owner: sports_league_owner
--

CREATE SEQUENCE public.seasons_season_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seasons_season_id_seq OWNER TO sports_league_owner;

--
-- TOC entry 3486 (class 0 OID 0)
-- Dependencies: 221
-- Name: seasons_season_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sports_league_owner
--

ALTER SEQUENCE public.seasons_season_id_seq OWNED BY public.seasons.season_id;


--
-- TOC entry 218 (class 1259 OID 16471)
-- Name: stadiums; Type: TABLE; Schema: public; Owner: sports_league_owner
--

CREATE TABLE public.stadiums (
    stadium_id integer NOT NULL,
    name character varying(255) NOT NULL,
    location character varying(255) NOT NULL,
    capacity integer
);


ALTER TABLE public.stadiums OWNER TO sports_league_owner;

--
-- TOC entry 217 (class 1259 OID 16470)
-- Name: stadiums_stadium_id_seq; Type: SEQUENCE; Schema: public; Owner: sports_league_owner
--

CREATE SEQUENCE public.stadiums_stadium_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stadiums_stadium_id_seq OWNER TO sports_league_owner;

--
-- TOC entry 3487 (class 0 OID 0)
-- Dependencies: 217
-- Name: stadiums_stadium_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sports_league_owner
--

ALTER SEQUENCE public.stadiums_stadium_id_seq OWNED BY public.stadiums.stadium_id;


--
-- TOC entry 232 (class 1259 OID 49153)
-- Name: standings; Type: TABLE; Schema: public; Owner: sports_league_owner
--

CREATE TABLE public.standings (
    standing_id integer NOT NULL,
    season_id integer NOT NULL,
    league_id integer NOT NULL,
    "position" integer NOT NULL,
    team_id integer NOT NULL,
    played_games integer NOT NULL,
    won integer NOT NULL,
    draw integer NOT NULL,
    lost integer NOT NULL,
    points integer NOT NULL,
    goals_for integer NOT NULL,
    goals_against integer NOT NULL,
    goal_difference integer NOT NULL,
    form character varying(1)[]
);


ALTER TABLE public.standings OWNER TO sports_league_owner;

--
-- TOC entry 231 (class 1259 OID 49152)
-- Name: standings_standing_id_seq; Type: SEQUENCE; Schema: public; Owner: sports_league_owner
--

CREATE SEQUENCE public.standings_standing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.standings_standing_id_seq OWNER TO sports_league_owner;

--
-- TOC entry 3488 (class 0 OID 0)
-- Dependencies: 231
-- Name: standings_standing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sports_league_owner
--

ALTER SEQUENCE public.standings_standing_id_seq OWNED BY public.standings.standing_id;


--
-- TOC entry 224 (class 1259 OID 16501)
-- Name: teams; Type: TABLE; Schema: public; Owner: sports_league_owner
--

CREATE TABLE public.teams (
    team_id integer NOT NULL,
    name character varying(255) NOT NULL,
    founded_year integer,
    stadium_id integer,
    league_id integer,
    coach_id integer,
    cresturl character varying(255)
);


ALTER TABLE public.teams OWNER TO sports_league_owner;

--
-- TOC entry 223 (class 1259 OID 16500)
-- Name: teams_team_id_seq; Type: SEQUENCE; Schema: public; Owner: sports_league_owner
--

CREATE SEQUENCE public.teams_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.teams_team_id_seq OWNER TO sports_league_owner;

--
-- TOC entry 3489 (class 0 OID 0)
-- Dependencies: 223
-- Name: teams_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sports_league_owner
--

ALTER SEQUENCE public.teams_team_id_seq OWNED BY public.teams.team_id;


--
-- TOC entry 216 (class 1259 OID 16462)
-- Name: users; Type: TABLE; Schema: public; Owner: sports_league_owner
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    is_admin boolean DEFAULT false
);


ALTER TABLE public.users OWNER TO sports_league_owner;

--
-- TOC entry 215 (class 1259 OID 16461)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: sports_league_owner
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO sports_league_owner;

--
-- TOC entry 3490 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sports_league_owner
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 3249 (class 2604 OID 16523)
-- Name: coaches coach_id; Type: DEFAULT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.coaches ALTER COLUMN coach_id SET DEFAULT nextval('public.coaches_coach_id_seq'::regclass);


--
-- TOC entry 3253 (class 2604 OID 106501)
-- Name: countries country_id; Type: DEFAULT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.countries ALTER COLUMN country_id SET DEFAULT nextval('public.countries_country_id_seq'::regclass);


--
-- TOC entry 3246 (class 2604 OID 16483)
-- Name: leagues league_id; Type: DEFAULT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.leagues ALTER COLUMN league_id SET DEFAULT nextval('public.leagues_league_id_seq'::regclass);


--
-- TOC entry 3251 (class 2604 OID 16547)
-- Name: matches match_id; Type: DEFAULT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.matches ALTER COLUMN match_id SET DEFAULT nextval('public.matches_match_id_seq'::regclass);


--
-- TOC entry 3250 (class 2604 OID 16535)
-- Name: players player_id; Type: DEFAULT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.players ALTER COLUMN player_id SET DEFAULT nextval('public.players_player_id_seq'::regclass);


--
-- TOC entry 3255 (class 2604 OID 139268)
-- Name: scorers scorer_id; Type: DEFAULT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.scorers ALTER COLUMN scorer_id SET DEFAULT nextval('public.scorers_scorer_id_seq'::regclass);


--
-- TOC entry 3254 (class 2604 OID 131076)
-- Name: scores score_id; Type: DEFAULT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.scores ALTER COLUMN score_id SET DEFAULT nextval('public.scores_score_id_seq'::regclass);


--
-- TOC entry 3247 (class 2604 OID 16492)
-- Name: seasons season_id; Type: DEFAULT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.seasons ALTER COLUMN season_id SET DEFAULT nextval('public.seasons_season_id_seq'::regclass);


--
-- TOC entry 3245 (class 2604 OID 16474)
-- Name: stadiums stadium_id; Type: DEFAULT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.stadiums ALTER COLUMN stadium_id SET DEFAULT nextval('public.stadiums_stadium_id_seq'::regclass);


--
-- TOC entry 3252 (class 2604 OID 49156)
-- Name: standings standing_id; Type: DEFAULT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.standings ALTER COLUMN standing_id SET DEFAULT nextval('public.standings_standing_id_seq'::regclass);


--
-- TOC entry 3248 (class 2604 OID 16504)
-- Name: teams team_id; Type: DEFAULT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.teams ALTER COLUMN team_id SET DEFAULT nextval('public.teams_team_id_seq'::regclass);


--
-- TOC entry 3243 (class 2604 OID 16465)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 3459 (class 0 OID 16520)
-- Dependencies: 226
-- Data for Name: coaches; Type: TABLE DATA; Schema: public; Owner: sports_league_owner
--

COPY public.coaches (coach_id, name, team_id, nationality) FROM stdin;
34	N/A	354	\N
35	N/A	356	\N
36	N/A	389	\N
37	N/A	397	\N
38	N/A	402	\N
39	N/A	563	\N
40	N/A	1044	\N
101	Kersten Kuhl	1	Germany
102	Pellegrino Matarazzo	2	USA
103	Xabi Alonso	3	Spain
104	Edin Terzić	4	Germany
105	Thomas Tuchel	5	Germany
106	Sebastian Hoeneß	10	Germany
107	Ralph Hasenhüttl	11	Austria
108	Ole Werner	12	Germany
109	Bo Henriksen	15	Denmark
110	Jess Thorup	16	Denmark
111	Christian Streich	17	Germany
112	Gerardo Seoane	18	Switzerland
113	Dino Toppmöller	19	Germany
114	Marco Grote	28	Germany
115	Heiko Butscher	36	Germany
116	Frank Schmidt	44	Germany
117	Torsten Lieberknecht	55	Germany
118	Marco Rose	721	Germany
41	Stefano Pioli	98	Italy
42	Vincenzo Italiano	99	Italy
43	Daniele De Rossi	100	Italy
44	Gian Piero Gasperini	102	Italy
45	Thiago Motta	103	Italy
46	Claudio Ranieri	104	Italy
47	Alberto Gilardino	107	Italy
48	Gianluca Zappalà	108	Italy
49	Paolo Montero	109	Uruguay
50	Igor Tudor	110	Croatia
51	Francesco Calzona	113	Italy
52	Fabio Cannavaro	115	Italy
53	Davide Nicola	445	Italy
54	Marco Baroni	450	Italy
55	Stefano Colantuono	455	Italy
56	Eusebio Di Francesco	470	Italy
57	Davide Ballardini	471	Italy
58	Ivan Juric	586	Croatia
59	Luca Gotti	5890	Italy
60	Raffaele Palladino	5911	Italy
61	Ernesto Valverde	77	Spain
62	Diego Simeone	78	Argentina
63	Jagoba Arrasate	79	Spain
64	Xavi Hernandez	81	Spain
65	Pepe Bordalás	82	Spain
66	Fernando Machado	83	Uruguay
67	Carlo Ancelotti	86	Italy
68	Iñigo Pérez	87	Spain
69	Javier Aguirre	89	Mexico
70	Manuel Pellegrini	90	Chile
71	Imanol Alguacil	92	Spain
72	Marcelino	94	Spain
73	Rubén Baraja	95	Spain
74	Luís García	263	Spain
75	Mauricio Pellegrino	264	Argentina
76	Pepe Mel	267	Spain
77	Albert Peris	275	Spain
78	Michel	298	Spain
79	Claudio	558	Spain
80	Quique Flores	559	Spain
81	Carles Martínez	511	Spain
83	Jean-Louis Gasset	516	France
84	Michel Der Zakarian	518	France
85	Paulo Fonseca	521	Portugal
86	Francesco Farioli	522	Italy
87	Damien Della Santa	523	France
88	Luis Enrique	524	Spain
89	Regis Le Bris	525	France
90	Bouziane Benaraïbi	529	Algeria
91	Luka Elsner	533	Slovenia
92	Pascal Gastien	541	France
94	László Bölöni	545	Romania
96	Samba Diawara	547	Mali
98	Patrick Vieira	576	France
82	Eric Roy	512	France
93	Antoine Kombouare	543	France
95	Franck Haise	546	France
97	Adi Hütter	548	Austria
31	Gary O'Neil	76	\N
21	Mikel Arteta	57	Spain
22	Unai Emery	58	Spain
26	Jürgen Klopp	64	Germany
23	Enzo Maresca	61	Italy
24	Sean Dyche	62	England
25	Marco Silva	63	Portugal
27	Pep Guardiola	65	Spain
28	Erik ten Hag	66	Netherlands
29	Eddie Howe	67	England
30	Ange Postecoglou	73	Greece
32	Vincent Kompany	328	Belgium
33	Nuno Espirito Santo	351	Portugal
\.


--
-- TOC entry 3467 (class 0 OID 106498)
-- Dependencies: 234
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: sports_league_owner
--

COPY public.countries (country_id, name, flag_url) FROM stdin;
1	England	https://upload.wikimedia.org/wikipedia/commons/thumb/b/be/Flag_of_England.svg/1200px-Flag_of_England.svg.png
2	Italy	https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/Flag_of_Italy.svg/1200px-Flag_of_Italy.svg.png
3	Spain	https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Flag_of_Spain.svg/1200px-Flag_of_Spain.svg.png
4	Germany	https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Flag_of_Germany.svg/1200px-Flag_of_Germany.svg.png
5	France	https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Flag_of_France.svg/1200px-Flag_of_France.svg.png
6	Albania	https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/Flag_of_Albania.svg/1200px-Flag_of_Albania.svg.png
7	Algeria	https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Flag_of_Algeria.svg/1200px-Flag_of_Algeria.svg.png
8	Andorra	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Flag_of_Andorra.svg/1200px-Flag_of_Andorra.svg.png
9	Angola	https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Flag_of_Angola.svg/1200px-Flag_of_Angola.svg.png
10	Argentina	https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Flag_of_Argentina.svg/1200px-Flag_of_Argentina.svg.png
11	Armenia	https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Flag_of_Armenia.svg/1200px-Flag_of_Armenia.svg.png
12	Australia	https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/Flag_of_Australia.svg/1200px-Flag_of_Australia.svg.png
13	Austria	https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Flag_of_Austria.svg/1200px-Flag_of_Austria.svg.png
14	Belgium	https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/Flag_of_Belgium.svg/1200px-Flag_of_Belgium.svg.png
15	Benin	https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Flag_of_Benin.svg/1200px-Flag_of_Benin.svg.png
16	Bosnia-Herzegovina	https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Flag_of_Bosnia_and_Herzegovina.svg/1200px-Flag_of_Bosnia_and_Herzegovina.svg.png
17	Brazil	https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Flag_of_Brazil.svg/1200px-Flag_of_Brazil.svg.png
18	Bulgaria	https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Flag_of_Bulgaria.svg/1200px-Flag_of_Bulgaria.svg.png
19	Burkina Faso	https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Flag_of_Burkina_Faso.svg/1200px-Flag_of_Burkina_Faso.svg.png
20	Cameroon	https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Flag_of_Cameroon.svg/1200px-Flag_of_Cameroon.svg.png
21	Canada	https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Flag_of_Canada.svg/1200px-Flag_of_Canada.svg.png
22	Cape Verde Islands	https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Flag_of_Cape_Verde.svg/1200px-Flag_of_Cape_Verde.svg.png
23	Chile	https://upload.wikimedia.org/wikipedia/commons/thumb/7/78/Flag_of_Chile.svg/1200px-Flag_of_Chile.svg.png
24	Colombia	https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Colombia.svg/1200px-Flag_of_Colombia.svg.png
25	Congo	https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Flag_of_the_Republic_of_the_Congo.svg/1200px-Flag_of_the_Republic_of_the_Congo.svg.png
26	Costa Rica	https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Flag_of_Costa_Rica_%28state%29.svg/1200px-Flag_of_Costa_Rica_%28state%29.svg.png
27	Croatia	https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Flag_of_Croatia.svg/1200px-Flag_of_Croatia.svg.png
28	Cyprus	https://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Flag_of_Cyprus.svg/1200px-Flag_of_Cyprus.svg.png
29	Czech Republic	https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Flag_of_the_Czech_Republic.svg/1200px-Flag_of_the_Czech_Republic.svg.png
30	DR Congo	https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Flag_of_the_Democratic_Republic_of_the_Congo.svg/1200px-Flag_of_the_Democratic_Republic_of_the_Congo.svg.png
31	Denmark	https://upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Flag_of_Denmark.svg/1200px-Flag_of_Denmark.svg.png
32	Dominican Republic	https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Flag_of_the_Dominican_Republic.svg/1200px-Flag_of_the_Dominican_Republic.svg.png
33	Ecuador	https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Flag_of_Ecuador.svg/1200px-Flag_of_Ecuador.svg.png
34	Egypt	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Egypt.svg/1200px-Flag_of_Egypt.svg.png
35	Equatorial Guinea	https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Flag_of_Equatorial_Guinea.svg/1200px-Flag_of_Equatorial_Guinea.svg.png
36	Estonia	https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Flag_of_Estonia.svg/1200px-Flag_of_Estonia.svg.png
37	Finland	https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Flag_of_Finland.svg/1200px-Flag_of_Finland.svg.png
38	Gabon	https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/Flag_of_Gabon.svg/1200px-Flag_of_Gabon.svg.png
39	Gambia	https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Flag_of_The_Gambia.svg/1200px-Flag_of_The_Gambia.svg.png
40	Georgia	https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Flag_of_Georgia.svg/1200px-Flag_of_Georgia.svg.png
41	Ghana	https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Flag_of_Ghana.svg/1200px-Flag_of_Ghana.svg.png
42	Greece	https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Flag_of_Greece.svg/1200px-Flag_of_Greece.svg.png
43	Grenada	https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Flag_of_Grenada.svg/1200px-Flag_of_Grenada.svg.png
44	Guadeloupe	https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Flag_of_Guadeloupe_%28local%29.svg/1200px-Flag_of_Guadeloupe_%28local%29.svg.png
45	Guinea	https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Flag_of_Guinea.svg/1200px-Flag_of_Guinea.svg.png
46	Honduras	https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Flag_of_Honduras.svg/1200px-Flag_of_Honduras.svg.png
47	Hungary	https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Flag_of_Hungary.svg/1200px-Flag_of_Hungary.svg.png
48	Iceland	https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Flag_of_Iceland.svg/1200px-Flag_of_Iceland.svg.png
49	Iran	https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/Flag_of_Iran.svg/1200px-Flag_of_Iran.svg.png
50	Ireland	https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/Flag_of_Ireland.svg/1200px-Flag_of_Ireland.svg.png
51	Israel	https://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Flag_of_Israel.svg/1200px-Flag_of_Israel.svg.png
52	Ivory Coast	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Côte_d%27Ivoire.svg/1200px-Flag_of_Côte_d%27Ivoire.svg.png
53	Jamaica	https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Flag_of_Jamaica.svg/1200px-Flag_of_Jamaica.svg.png
54	Japan	https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Flag_of_Japan.svg/1200px-Flag_of_Japan.svg.png
55	Kosovo	https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Flag_of_Kosovo.svg/1200px-Flag_of_Kosovo.svg.png
56	Lithuania	https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Flag_of_Lithuania.svg/1200px-Flag_of_Lithuania.svg.png
57	Luxembourg	https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Flag_of_Luxembourg.svg/1200px-Flag_of_Luxembourg.svg.png
58	Mali	https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Flag_of_Mali.svg/1200px-Flag_of_Mali.svg.png
59	Martinique	https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/Flag_of_Martinique.svg/1200px-Flag_of_Martinique.svg.png
60	Mexico	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Flag_of_Mexico.svg/1200px-Flag_of_Mexico.svg.png
61	Montenegro	https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/Flag_of_Montenegro.svg/1200px-Flag_of_Montenegro.svg.png
62	Morocco	https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Flag_of_Morocco.svg/1200px-Flag_of_Morocco.svg.png
63	Mozambique	https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Flag_of_Mozambique.svg/1200px-Flag_of_Mozambique.svg.png
64	Netherlands	https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Flag_of_the_Netherlands.svg/1200px-Flag_of_the_Netherlands.svg.png
65	New Zealand	https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Flag_of_New_Zealand.svg/1200px-Flag_of_New_Zealand.svg.png
66	Nigeria	https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Flag_of_Nigeria.svg/1200px-Flag_of_Nigeria.svg.png
67	North Macedonia	https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Flag_of_Macedonia.svg/1200px-Flag_of_Macedonia.svg.png
69	Norway	https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Flag_of_Norway.svg/1200px-Flag_of_Norway.svg.png
70	Paraguay	https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Flag_of_Paraguay.svg/1200px-Flag_of_Paraguay.svg.png
71	Peru	https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/Flag_of_Peru_%28state%29.svg/1200px-Flag_of_Peru_%28state%29.svg.png
72	Philippines	https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/Flag_of_the_Philippines.svg/1200px-Flag_of_the_Philippines.svg.png
73	Poland	https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Flag_of_Poland.svg/1200px-Flag_of_Poland.svg.png
74	Portugal	https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Flag_of_Portugal.svg/1200px-Flag_of_Portugal.svg.png
75	Romania	https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Flag_of_Romania.svg/1200px-Flag_of_Romania.svg.png
76	Russia	https://upload.wikimedia.org/wikipedia/commons/thumb/f/f3/Flag_of_Russia.svg/1200px-Flag_of_Russia.svg.png
77	Scotland	https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/Flag_of_Scotland.svg/1200px-Flag_of_Scotland.svg.png
78	Senegal	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Flag_of_Senegal.svg/1200px-Flag_of_Senegal.svg.png
79	Serbia	https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Flag_of_Serbia.svg/1200px-Flag_of_Serbia.svg.png
80	Slovakia	https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Flag_of_Slovakia.svg/1200px-Flag_of_Slovakia.svg.png
81	Slovenia	https://upload.wikimedia.org/wikipedia/commons/thumb/f/f0/Flag_of_Slovenia.svg/1200px-Flag_of_Slovenia.svg.png
82	South Africa	https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Flag_of_South_Africa.svg/1200px-Flag_of_South_Africa.svg.png
83	South Korea	https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Flag_of_South_Korea.svg/1200px-Flag_of_South_Korea.svg.png
84	Suriname	https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/Flag_of_Suriname.svg/1200px-Flag_of_Suriname.svg.png
85	Sweden	https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Flag_of_Sweden.svg/1200px-Flag_of_Sweden.svg.png
86	Switzerland	https://upload.wikimedia.org/wikipedia/commons/thumb/f/f3/Flag_of_Switzerland.svg/1200px-Flag_of_Switzerland.svg.png
87	Syria	https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Flag_of_Syria.svg/1200px-Flag_of_Syria.svg.png
88	Togo	https://upload.wikimedia.org/wikipedia/commons/thumb/6/68/Flag_of_Togo.svg/1200px-Flag_of_Togo.svg.png
89	Tunisia	https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Flag_of_Tunisia.svg/1200px-Flag_of_Tunisia.svg.png
90	Turkey	https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Flag_of_Turkey.svg/1200px-Flag_of_Turkey.svg.png
91	USA	https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Flag_of_the_United_States.svg/1200px-Flag_of_the_United_States.svg.png
92	Ukraine	https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Flag_of_Ukraine.svg/1200px-Flag_of_Ukraine.svg.png
93	Uruguay	https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Uruguay.svg/1200px-Flag_of_Uruguay.svg.png
94	Uzbekistan	https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Flag_of_Uzbekistan.svg/1200px-Flag_of_Uzbekistan.svg.png
95	Venezuela	https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Flag_of_Venezuela.svg/1200px-Flag_of_Venezuela.svg.png
96	Wales	https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Flag_of_Wales.svg/1200px-Flag_of_Wales.svg.png
97	Zambia	https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Flag_of_Zambia.svg/1200px-Flag_of_Zambia.svg.png
98	Zimbabwe	https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Flag_of_Zimbabwe.svg/1200px-Flag_of_Zimbabwe.svg.png
68	Northern Ireland	https://upload.wikimedia.org/wikipedia/commons/4/43/Flag_of_Northern_Ireland_%281953%E2%80%931972%29.svg
\.


--
-- TOC entry 3453 (class 0 OID 16480)
-- Dependencies: 220
-- Data for Name: leagues; Type: TABLE DATA; Schema: public; Owner: sports_league_owner
--

COPY public.leagues (league_id, name, country, country_id, icon_url, cl_spot, uel_spot, relegation_spot) FROM stdin;
2	Serie A	Italy	2	https://crests.football-data.org/SA.png	4	5	18
3	La Liga	Spain	3	https://crests.football-data.org/PD.png	4	5	18
4	Bundesliga	Germany	4	https://crests.football-data.org/BL1.png	4	5	16
5	Ligue 1	France	5	https://crests.football-data.org/FL1.png	3	4	17
1	Premier League	England	1	https://crests.football-data.org/PL.png	4	6	18
\.


--
-- TOC entry 3469 (class 0 OID 122907)
-- Dependencies: 236
-- Data for Name: match_referees; Type: TABLE DATA; Schema: public; Owner: sports_league_owner
--

COPY public.match_referees (match_id, referee_id) FROM stdin;
435943	11585
435944	11605
435945	11309
435946	11556
435947	11494
435948	11327
435949	11423
435950	11446
435951	11580
435952	11430
435959	11309
435955	11317
435956	11620
435962	11423
435960	11605
435958	11446
435953	11580
435961	11327
435954	11556
435968	11446
435963	11396
435969	11585
435970	11494
435964	11520
435965	11309
435966	11580
435972	23568
435967	11405
435971	11327
435980	11520
435982	11423
435974	193220
435976	11469
435977	11396
435981	11605
435975	11494
435978	11446
435979	11430
435973	11580
435992	11605
435984	11469
435986	11405
435987	23568
435990	11309
435991	11423
435988	11585
435983	11556
435985	11430
435989	11446
435998	11520
436000	213800
436001	11580
435994	11605
435996	11378
435993	11446
435995	11327
435997	23568
435999	11443
436002	11494
436004	11423
436003	11405
436005	11580
436007	11443
436008	11620
436011	11503
436012	11585
436010	11430
436009	11520
436006	11396
435957	11309
436019	11327
436015	11494
436017	11556
436018	213813
436020	193220
436016	11585
436014	11580
436021	11309
436022	11446
436013	11605
436027	11585
436023	11520
436025	213800
436028	11446
436029	11396
436030	213813
436026	11443
436031	11605
436024	11556
436032	11580
436038	11423
436037	11430
436033	213813
436034	11396
436042	11580
436041	11494
436035	11327
436036	11405
436039	11443
436040	11520
436046	11327
436043	11620
436044	11309
436045	11396
436048	11585
436051	11446
436049	11494
436050	23568
436047	11423
436052	11605
436062	11396
436054	11605
436058	213813
436060	11503
436053	11443
436055	11430
436056	11327
436059	11520
436061	11405
436057	11580
436068	11443
436064	213813
436067	23568
436069	11430
436070	11580
436071	193220
436063	11396
436072	11446
436065	11327
436066	11405
436074	11309
436075	11580
436076	11443
436081	11520
436080	11446
436073	11620
436077	11585
436078	11494
436082	11605
436079	11430
436090	23568
436087	213813
436084	11309
436086	213800
436088	11430
436091	11585
436083	11327
436092	11443
436085	11396
436089	11405
436095	11423
436094	11430
436099	11309
436100	11494
436102	213813
436093	23568
436096	11605
436097	11520
436098	11396
436101	11443
436111	23568
436107	11423
436109	11520
436110	213813
436106	11580
436104	11396
436105	11556
436112	11443
436108	11605
436114	11327
436113	11580
436121	11430
436115	80758
436117	11469
436119	11446
436120	11494
436116	11443
436122	11556
436131	11443
436123	11396
436132	11635
436127	11520
436130	11585
436125	11423
436128	11405
436129	11327
436126	23568
436124	11605
436137	11520
436133	11494
436134	11446
436138	11556
436142	11620
436139	11396
436135	11309
436140	11430
436136	11580
436141	213813
436147	11378
436148	11580
436151	11443
436149	11556
436150	11327
436144	11520
436145	11469
436152	11405
436143	193220
436146	11585
436153	11430
436155	11446
436156	11620
436157	11378
436158	11327
436159	11556
436161	213813
436162	11520
436154	11396
436160	23568
436169	11605
436166	11430
436167	11317
436171	11620
436172	11520
436163	80758
436168	11396
436170	11423
436164	11580
436165	23568
436178	11327
436175	11469
436176	11396
436177	11443
436180	213813
436182	11430
436179	11580
436181	11585
436173	11446
436174	11605
436183	11605
436184	23568
436186	81840
436189	11405
436190	11620
436192	11580
436188	11423
436191	11494
436187	11556
436185	11520
436118	11469
436199	11423
436195	213813
436196	11378
436198	81840
436200	11605
436193	23568
436194	11520
436202	11317
436201	11430
436203	23568
436205	11585
436206	11430
436209	11396
436210	11520
436212	11327
436207	11605
436204	11556
436208	11423
436211	213813
436220	11430
436213	11580
436218	150766
436222	11378
436214	11446
436215	11443
436216	11405
436221	11469
436219	11605
436217	11327
436103	11635
436225	11317
436229	11469
436228	11446
436231	23568
436239	11446
436233	213813
436236	11469
436240	11443
436241	11396
436242	23568
436234	11520
436235	11430
436237	11556
436238	11580
436247	11605
436250	11378
436243	11503
436246	11620
436248	11327
436244	11585
436245	193220
436252	11469
436251	11494
436249	23568
436255	11520
436253	11405
436256	11605
436257	11635
436258	11423
436262	11378
436254	11327
436259	11580
436260	11446
436261	11430
436270	11396
436265	213813
436266	11430
436269	11327
436271	11585
436263	11378
436268	11443
436272	11494
436264	11556
436267	11520
436278	23568
436280	11423
436282	11520
436276	11580
436273	11396
436275	11503
436277	11585
436223	11430
436232	11494
436226	11620
436227	11423
436230	11405
436224	23568
436291	11580
436286	11494
436287	11327
436288	11378
436292	11556
436285	11469
436284	11585
436283	11520
436290	11605
436289	11430
436197	11446
436300	11396
436293	11556
436294	11503
436296	11580
436302	11443
436301	11585
436295	11446
436297	193220
436299	11520
436298	23568
436306	11580
436303	11626
436305	11494
436308	11469
436310	23568
436311	11605
436312	11620
436309	11378
436307	11520
436304	11430
436281	11443
436274	11405
436279	11446
436313	11605
436314	11430
436315	11585
436316	11503
436317	11580
436318	11317
436319	11443
436320	11626
436321	11327
436322	193220
444255	57836
444256	57868
444257	57842
444258	57878
444260	57882
444261	57762
444259	57837
444263	11018
444262	215611
444254	11002
444266	206189
444271	11068
444267	11065
444270	11043
444265	212567
444268	11060
444269	11119
444272	11280
444273	11029
444264	10985
444281	11039
444280	11018
444275	11116
444283	11079
444274	57868
444279	57878
444277	57762
444282	11053
444276	57842
444278	57836
444290	10977
444289	57826
444287	10985
444284	11065
444286	57794
444291	11119
444285	11002
444292	206189
444293	11280
444288	10980
444300	11039
444298	11018
444299	57762
444301	57878
444297	11006
444296	57868
444294	57882
444303	11053
444295	57842
444302	11079
444310	11280
444304	10980
444305	11018
444308	57837
444309	57836
444311	10985
444313	11072
444306	11129
444312	207664
444307	11116
444317	11002
444318	11029
444320	11006
444315	10977
444323	11043
444314	11053
444319	57762
444321	57764
444322	57882
444316	11060
444325	10985
444331	206189
444328	11079
444329	11018
444327	11039
444332	57836
444326	212567
444330	11116
444324	57826
444333	10980
444337	11006
444342	57762
444341	11060
444339	57842
444335	11065
444340	11053
444334	11119
444338	11043
444343	97887
444336	57837
444346	11029
444353	11280
444350	11068
444348	57882
444344	11002
444351	57794
444347	10977
444352	11116
444345	57836
444349	57868
444355	10980
444362	11018
444354	57826
444360	206189
444359	97848
444356	11079
444361	57878
444357	11053
444358	11072
444363	212567
444372	11084
444365	11116
444369	11006
444367	11039
444370	11065
444371	57794
444364	10977
444373	11068
444368	11029
444366	57837
444383	57794
444374	11043
444381	11060
444376	57762
444377	57826
444378	57764
444382	57836
444380	11079
444379	10980
444375	57878
444389	10985
444385	11068
444386	57837
444388	57762
444387	11065
444384	97887
444393	10977
444391	57868
444390	11029
444392	11039
444400	11116
444398	57842
444394	10980
444399	11060
444397	57836
444401	97848
444403	57826
444402	11018
444396	57878
444395	11043
444407	11029
444409	57764
444411	57868
444412	11119
444410	11068
444406	212567
444413	11072
444405	11079
444408	10977
444404	57882
444422	11079
444415	57762
444419	206189
444421	11065
444416	11043
444423	10985
444414	11018
444417	11116
444418	57868
444420	57878
444426	10980
444432	11060
444427	11065
444430	57882
444424	11072
444425	10977
444433	11116
444428	11043
444431	11119
444429	57826
444434	57878
444437	11039
444436	212567
444438	11029
444441	11006
444435	10980
444442	11043
444443	206189
444440	11079
444439	11068
444447	11280
444453	11119
444448	11065
444452	11018
444450	212567
444445	11072
444446	11002
444451	11079
444444	57794
444449	11039
444459	206189
444463	10977
444456	57837
444455	11280
444460	11116
444458	11065
444465	57878
444464	11039
444469	11119
444471	11029
444467	11002
444468	10980
444472	11072
444470	11116
444466	11068
444473	11060
444479	11280
444476	57882
444483	57794
444477	11002
444475	206189
444482	11053
444480	11039
444474	11079
444478	10977
444481	57868
444492	11043
444485	11060
444491	11079
444493	10980
444486	57882
444484	11072
444490	11029
444487	57878
444489	11065
444488	11006
444454	11053
444502	57842
444498	11039
444501	206189
444497	11060
444494	57794
444499	10977
444495	11002
444503	11043
444496	11280
444500	57878
444462	10980
444504	11006
444513	11068
444512	10985
444507	11129
444508	11018
444505	11002
444509	11065
444510	11116
444511	206189
444506	11079
444461	11053
444457	57878
444519	11060
444523	11072
444520	11039
444522	57762
444517	10977
444515	11018
444516	11079
444514	10980
444521	11043
444518	57842
444532	11116
444525	11129
444533	10980
444524	11002
444527	57882
444530	11053
444531	206189
444528	11079
444526	11029
444529	11068
444535	10985
444540	57868
444543	57878
444542	10977
444536	11018
444539	11280
444537	11043
444541	11072
444538	10980
444551	11002
444547	206189
444553	11068
444549	57878
444546	10977
444544	57882
444545	11065
444552	10985
444550	57868
444548	57837
444562	57826
444559	57836
444561	11079
444555	11029
444556	11116
444560	11065
444554	11018
444557	11072
444558	10980
444563	11039
444568	57764
444569	11043
444572	10977
444565	10980
444570	10985
444571	11029
444567	11129
444566	145272
444564	206189
444576	57882
444574	11039
444575	11072
444577	11079
444582	11065
444583	11018
444581	57762
444579	11280
444580	10977
444578	57878
444573	11002
444587	11129
444592	11087
444590	11043
444591	11029
444589	212567
444585	206189
444584	10985
444593	57826
444586	57868
444588	57837
444602	57826
444598	11002
444601	57762
444594	57868
444595	11065
444596	11018
444597	57794
444599	57878
444600	57882
444603	11068
444606	11280
444613	11002
444612	57826
444610	11068
444607	11043
444608	11119
444609	11087
444604	11079
444611	11029
444605	57764
444615	57762
444617	11018
444622	57882
444621	11065
444618	10985
444623	11116
444616	206189
444619	11072
444620	11060
444614	57842
444625	57794
444628	11087
444630	212567
444632	145272
444624	57826
444633	57837
444626	11029
444627	11065
444629	57764
444631	97887
444534	206189
444534	11116
438482	80747
438479	207080
438481	214213
438483	56995
438474	206211
438476	206206
438480	207048
438478	207113
438477	57930
438475	207133
438491	80747
438490	215462
438492	207048
438493	207080
438485	206223
438488	215559
438487	215569
438484	15628
438486	206215
438489	206206
438503	206215
438495	57930
438496	56995
438498	214213
438499	206211
438501	206208
438500	207133
438494	207113
438497	206203
438502	206223
438508	207133
438513	15628
438512	215462
438511	207105
438507	206206
438505	215569
438509	217698
438510	215559
438506	207048
438522	56995
438514	206215
438520	206211
438515	206223
438516	207080
438517	206208
438521	214213
438519	206203
438523	207113
438518	57930
438527	215569
438529	206206
438526	215462
438528	207105
438532	217698
438531	207133
438530	215559
438533	15628
438525	207048
438524	80747
438539	206215
438542	215569
438534	57930
438541	207080
438543	206223
438537	214213
438540	206208
438536	207113
438538	56995
438535	206203
438547	207048
438548	217698
438550	207105
438549	207133
438551	206211
438552	206206
438546	215559
438544	215462
438545	15628
438553	80747
438554	56995
438558	206203
438563	206215
438562	214213
438560	57930
438561	215569
438555	206223
438556	207080
438557	206208
438559	207113
438564	217698
438572	215559
438567	207113
438569	15628
438565	206215
438573	215462
438568	207048
438571	206211
438566	206203
438570	206206
438579	57930
438583	214213
438577	206211
438582	206206
438578	207113
438576	207080
438581	217698
438574	215559
438575	215569
438580	215462
438593	207105
438585	206223
438584	207048
438586	206208
438592	80747
438587	207133
438589	56995
438590	206215
438591	206203
438588	15628
438594	207133
438600	206206
438603	57930
438596	215559
438598	215569
438602	207080
438597	217698
438599	206211
438595	214213
438606	80747
438612	206223
438610	207113
438608	206208
438604	206203
438611	15628
438613	207048
438607	206215
438605	56995
438609	207105
438601	215462
438623	217698
438618	215462
438614	214213
438621	206206
438615	207133
438620	215559
438622	215569
438619	57930
438617	207080
438616	206211
438629	206215
438626	206223
438625	207113
438631	207105
438633	80747
438624	15628
438628	206203
438627	57930
438630	207048
438632	56995
438635	215462
438636	207080
438634	206211
438638	207133
438639	207048
438642	206206
438641	217698
438643	215569
438640	215559
438637	214213
438652	80747
438645	206223
438650	217698
438648	206215
438644	206203
438651	207113
438646	15628
438649	215462
438647	57930
438653	207105
438656	215559
438662	56995
438660	206211
438658	207133
438655	207048
438661	215569
438657	206208
438654	207113
438659	207080
438663	206206
438670	206208
438673	215462
438671	56995
438664	206223
438666	206215
438672	217698
438668	57930
438677	215569
438682	207105
438681	207048
438680	207133
438676	215559
438675	207080
438683	214213
438674	206211
438678	206206
438679	206203
438692	207048
438691	206208
438693	207113
438686	206223
438690	215462
438685	207105
438687	217698
438689	206215
438684	15628
438688	56995
438667	215559
438665	207113
438669	15628
438694	215559
438700	215569
438699	217698
438697	206203
438698	206211
438701	206206
438696	80747
438695	207133
438703	207080
438702	214213
438706	15628
438704	207105
438711	57930
438710	206203
438713	206215
438707	206208
438709	206223
438708	215462
438705	207048
438712	56995
438721	80747
438715	215559
438717	214213
438718	207133
438720	207113
438722	215569
438719	206211
438723	206206
438716	217698
438714	207080
438731	215462
438726	215569
438725	56995
438732	80747
438727	207048
438724	206215
438733	206223
438730	57930
438728	15628
438737	207080
438739	217698
438742	80747
438738	206206
438740	206211
438741	207133
438735	207113
438743	214213
438734	206208
438736	215559
438746	215462
438750	207133
438747	206206
438749	206203
438748	217698
438745	206223
438753	207048
438751	207105
438744	206208
438752	15628
438762	207113
438761	15628
438756	206203
438757	206223
438754	215569
438758	214213
438759	215559
438763	56995
438760	207133
438755	207080
438767	206215
438768	215462
438773	206206
438770	207048
438766	217698
438764	206208
438769	206211
438765	214213
438772	80747
438771	207105
438729	206208
438776	206203
438775	15628
438780	215559
438781	207080
438778	207133
438783	215569
438779	56995
438774	206215
438782	57930
438777	206223
438784	215462
438785	214213
438791	207105
438790	217698
438788	80747
438787	56995
438793	207048
438786	206211
438792	207113
438789	206208
438801	206223
438803	215559
438802	206215
438796	207133
438794	206203
438798	57930
438799	215569
438800	206206
438795	207080
438797	15628
438806	206211
438813	207048
438812	215462
438807	206208
438811	80747
438804	56995
438805	207113
438809	207105
438808	217698
438810	214213
438817	206223
438823	206203
438822	57930
438820	206206
438814	207080
438819	15628
438815	215559
438821	207133
438816	215569
438818	206215
438824	214213
438830	217698
438827	207080
438828	207048
438829	57930
438825	56995
438826	207105
438833	215462
438832	80747
438831	207113
438837	215559
438834	207133
438835	206206
438836	206203
438838	206211
438839	207113
438840	80747
438841	206215
438842	206208
438843	15628
438847	215569
438844	207105
438851	207080
438849	206223
438852	217698
438850	57930
438846	56995
438845	207048
438853	214213
438848	215462
441789	43878
441792	43875
441794	57518
441795	15824
441796	57517
441797	15408
441790	8825
441791	43943
441793	253
441799	57532
441800	43922
441803	56230
441804	57519
441805	57504
441806	337
441802	57526
441801	15746
441798	15408
441807	57512
441809	15824
441812	43878
441813	57519
441814	15825
441815	43875
441811	8825
441810	57518
441808	57517
441816	57517
441817	9567
441818	43943
441819	43875
441820	253
441821	15408
441822	43922
441823	337
441824	57527
441833	56230
441825	57504
441826	15824
441827	8825
441830	57519
441832	15821
441831	15746
441828	57526
441829	43878
441839	57518
441836	57532
441837	43922
441838	43943
441840	43875
441841	9567
441834	15821
441842	15825
441835	253
441848	15824
441844	337
441845	57527
441850	8825
441851	15408
441849	57526
441846	43878
441843	57519
441847	57517
441852	43875
441858	56230
441860	253
441853	15746
441854	57512
441855	15821
441856	9567
441857	8825
441859	43943
441867	337
441861	15825
441865	57504
441866	43943
441868	57517
441869	43878
441862	43922
441864	57519
441863	15408
441878	15821
441871	15824
441872	43875
441874	15746
441875	57526
441876	57532
441870	8825
441882	43878
441879	253
441885	43875
441886	43943
441887	15408
441884	56230
441881	57527
441883	43922
441880	337
441893	15821
441888	15824
441889	57518
441890	9567
441892	57504
441895	15825
441891	43875
441896	43878
441894	8825
441905	337
441898	57526
441901	57512
441902	57519
441904	15746
441900	43943
441899	15408
441903	253
441911	56230
441907	15825
441908	43878
441909	15821
441912	9567
441914	57517
441906	15824
441913	8825
441910	57532
441920	43878
441919	15746
441921	15824
441922	56230
441923	57504
441916	57519
441917	253
441918	57526
441915	43943
441930	57512
441924	15821
441929	57532
441925	8825
441926	57517
441927	57518
441928	9567
441931	15408
441932	43922
441933	43922
441934	57532
441935	57526
441936	337
441938	43878
441940	15824
441941	8825
441939	43943
441937	253
441943	57517
441946	15408
441947	57527
441948	9567
441950	15746
441945	56230
441942	15821
441949	15825
441897	57532
441954	43878
441951	57526
441952	15824
441953	57504
441956	57515
441958	57539
441955	8825
441959	253
441957	43922
441960	15746
441962	57512
441964	43943
441966	43922
441967	337
441968	15408
441963	57527
441965	57518
441961	15821
441944	15825
441971	253
441970	43922
441972	56230
441975	15824
441976	57519
441977	9567
441969	43878
441973	8825
441974	57526
441984	15408
441979	15825
441980	57504
441981	253
441985	57512
441986	57539
441983	57515
441982	43943
441978	57517
441990	57527
441991	337
441994	8825
441995	57518
441993	57532
441993	15824
441987	9567
441989	57517
441992	15821
441988	15746
441996	15824
441997	57526
441998	253
442000	57515
442001	57519
442003	43878
442004	43922
441999	43943
442002	56230
442006	57519
442009	337
442010	43878
442012	57539
442013	57504
442005	8825
442007	15821
442011	15746
442008	15408
442015	57518
442014	57512
442018	15825
442019	57517
442020	56230
442021	57527
442022	9567
442016	253
442017	43943
442024	15821
442025	57526
442026	9567
442027	57532
442029	8825
442023	253
442028	57515
442030	43878
442031	15824
442036	57504
442032	57519
442033	15408
442034	43922
442037	57539
442040	57517
442039	56230
442038	58466
442035	15746
442042	43943
442041	57518
442045	57526
442046	57532
442047	43878
442049	337
442044	8825
442043	9567
442048	253
442056	15825
442051	57539
442054	57515
442055	57512
442058	56230
442050	15824
442057	57519
442052	15408
442053	15821
442064	43943
442059	8825
442061	57517
442062	57532
442065	57539
442066	43878
442060	9567
442063	43922
442067	15746
442069	253
442068	57539
442073	57527
442075	57519
442076	57504
442070	57515
442074	15821
442071	57526
442072	15824
442084	337
442078	8825
442080	57519
442083	9567
442085	15408
442077	43943
442082	57518
442081	15746
442079	43922
442086	15821
442087	43878
442088	57526
442089	57532
442090	57517
442091	57539
442092	15825
442093	56230
442094	15408
442710	43926
442711	57092
442712	57088
442714	57073
442707	43918
442708	57042
442709	9374
442715	1049
442713	15548
442719	15548
442721	57054
442720	57039
442722	57065
442716	57068
442718	57063
442724	57087
442717	43886
442723	15545
442727	57073
442730	1049
442731	43918
442733	57092
442725	64829
442728	64781
442732	43926
442726	57042
442729	57088
442737	43886
442741	57063
442735	57042
442738	57068
442734	57087
442736	57054
442740	15545
442739	1049
442742	57092
442747	9374
442751	15548
442749	25786
442744	64781
442743	57039
442748	57065
442750	64829
442746	43918
442745	43926
442753	15545
442755	57068
442760	57039
442754	9374
442752	57054
442759	57063
442756	25786
442758	57042
442757	57092
442767	57092
442763	64781
442762	43926
442768	43918
442761	57088
442765	64829
442766	57087
442764	1049
442769	43886
442774	25786
442770	15548
442777	57063
442772	57039
442773	9374
442776	57065
442775	15545
442778	43926
442779	43918
442787	57088
442784	43886
442781	64829
442782	64781
442783	1049
442786	57054
442780	57087
442785	57042
442788	57073
442795	43926
442793	57065
442794	15548
442789	57063
442790	57039
442792	9374
442796	57068
442804	43886
442798	57088
442803	25786
442802	15545
442799	64829
442800	64781
442805	1049
442797	57092
442801	9374
442809	57063
442813	57042
442806	57039
442807	57087
442808	57068
442810	57054
442814	25786
442811	43926
442821	43926
442815	15545
442822	15548
442819	43918
442816	57073
442817	40158
442818	57065
442823	43886
442820	57092
442771	57054
442832	57063
442830	9374
442826	43886
442824	57088
442825	1049
442827	57039
442831	64781
442829	64829
442828	57042
442791	43918
442812	57073
442836	25786
442841	9374
442839	15548
442837	43926
442833	57068
442835	57087
442840	15545
442838	57065
442834	57092
442843	43886
442842	57073
442850	43918
442846	15545
442844	57088
442845	64781
442847	1049
442848	64829
442849	57042
442851	57092
442852	15548
442853	57039
442854	57063
442855	43926
442856	43886
442857	9374
442858	57054
442859	25786
442864	64781
442861	43918
442868	57088
442865	57065
442862	57068
442863	57087
442867	57073
442860	64829
442866	15548
442875	57039
442873	25786
442874	57042
442872	57063
442869	15545
442870	1049
442877	57073
442871	57054
442876	9374
442883	43886
442886	57054
442880	57068
442878	15548
442882	57088
442885	57065
442879	57087
442884	57042
442881	43926
442893	57063
442895	57042
442894	43918
442887	15545
442888	25786
442889	64781
442890	64829
442891	57065
442892	57092
442899	9374
442900	57073
442897	15548
442901	57039
442896	43926
442898	1049
442904	57087
442903	15545
442902	43886
442907	64781
442906	57042
442912	15548
442913	43918
442905	57068
442908	57054
442909	57063
442911	57088
442910	57073
442914	43886
442921	1049
442915	57039
442917	57073
442916	57092
442918	25786
442920	57065
442922	43926
442919	15548
442926	43886
442924	57054
442931	25786
442929	57042
442923	57087
442925	64829
442930	9374
442928	15545
442927	43918
442935	1049
442934	57073
442937	43926
442938	9374
442932	57088
442933	64781
442939	57063
442940	57092
442936	57068
442948	57042
442944	57092
442947	57039
442943	15548
442941	57054
442942	57065
442945	57088
442949	1049
442946	43926
442954	57088
442956	43918
442955	64829
442957	15545
442952	43886
442953	57087
442958	57092
442950	25786
442951	15548
442963	57087
442966	57042
442967	57068
442959	57063
442961	57039
442965	57054
442971	1049
442969	57042
442974	43926
442968	64781
442972	15545
442976	57065
442975	43886
442970	9374
442973	43918
442962	64781
442960	9374
442964	57073
442980	1049
442983	57042
442979	25786
442977	57068
442978	64829
442984	57039
442985	57073
442981	57088
442982	57092
442989	64781
442992	57073
442986	15548
442987	57063
442988	43886
442993	9374
442991	43926
442998	43926
443002	15548
442995	57065
442996	57092
442997	25786
442999	57088
443000	57068
443001	43918
443003	15545
442990	43886
442994	57063
443004	1049
443005	57087
443006	9374
443007	64829
443008	57073
443009	57092
443010	57042
443011	57039
443012	57054
\.


--
-- TOC entry 3463 (class 0 OID 16544)
-- Dependencies: 230
-- Data for Name: matches; Type: TABLE DATA; Schema: public; Owner: sports_league_owner
--

COPY public.matches (match_id, season_id, league_id, matchday, home_team_id, away_team_id, winner, utc_date) FROM stdin;
435943	1	1	1	328	65	AWAY_TEAM	2023-08-11
435944	1	1	1	57	351	HOME_TEAM	2023-08-12
435945	1	1	1	1044	563	DRAW	2023-08-12
435946	1	1	1	397	389	HOME_TEAM	2023-08-12
435947	1	1	1	62	63	AWAY_TEAM	2023-08-12
435948	1	1	1	356	354	AWAY_TEAM	2023-08-12
435949	1	1	1	67	58	HOME_TEAM	2023-08-12
435950	1	1	1	402	73	DRAW	2023-08-13
435951	1	1	1	61	64	DRAW	2023-08-13
435952	1	1	1	66	76	HOME_TEAM	2023-08-14
435959	1	1	2	351	356	HOME_TEAM	2023-08-18
435955	1	1	2	63	402	AWAY_TEAM	2023-08-19
435956	1	1	2	64	1044	HOME_TEAM	2023-08-19
435962	1	1	2	76	397	AWAY_TEAM	2023-08-19
435960	1	1	2	73	66	HOME_TEAM	2023-08-19
435958	1	1	2	65	67	HOME_TEAM	2023-08-19
435953	1	1	2	58	62	HOME_TEAM	2023-08-20
435961	1	1	2	563	61	HOME_TEAM	2023-08-20
435954	1	1	2	354	57	AWAY_TEAM	2023-08-21
435968	1	1	3	61	389	HOME_TEAM	2023-08-25
435963	1	1	3	1044	73	AWAY_TEAM	2023-08-26
435969	1	1	3	62	76	AWAY_TEAM	2023-08-26
435970	1	1	3	66	351	HOME_TEAM	2023-08-26
435964	1	1	3	57	63	DRAW	2023-08-26
435965	1	1	3	402	354	DRAW	2023-08-26
435966	1	1	3	397	563	AWAY_TEAM	2023-08-26
435972	1	1	3	356	65	AWAY_TEAM	2023-08-27
435967	1	1	3	328	58	AWAY_TEAM	2023-08-27
435971	1	1	3	67	64	AWAY_TEAM	2023-08-27
435980	1	1	4	389	563	AWAY_TEAM	2023-09-01
435982	1	1	4	356	62	DRAW	2023-09-02
435974	1	1	4	402	1044	DRAW	2023-09-02
435976	1	1	4	328	73	AWAY_TEAM	2023-09-02
435977	1	1	4	61	351	AWAY_TEAM	2023-09-02
435981	1	1	4	65	63	HOME_TEAM	2023-09-02
435975	1	1	4	397	67	HOME_TEAM	2023-09-02
435978	1	1	4	354	76	HOME_TEAM	2023-09-03
435979	1	1	4	64	58	HOME_TEAM	2023-09-03
435973	1	1	4	57	66	HOME_TEAM	2023-09-03
435992	1	1	5	76	64	AWAY_TEAM	2023-09-16
435984	1	1	5	58	354	HOME_TEAM	2023-09-16
435986	1	1	5	63	389	HOME_TEAM	2023-09-16
435987	1	1	5	66	397	AWAY_TEAM	2023-09-16
435990	1	1	5	73	356	HOME_TEAM	2023-09-16
435991	1	1	5	563	65	AWAY_TEAM	2023-09-16
435988	1	1	5	67	402	HOME_TEAM	2023-09-16
435983	1	1	5	1044	61	DRAW	2023-09-17
435985	1	1	5	62	57	AWAY_TEAM	2023-09-17
435989	1	1	5	351	328	DRAW	2023-09-18
435998	1	1	6	354	63	DRAW	2023-09-23
436000	1	1	6	389	76	DRAW	2023-09-23
436001	1	1	6	65	351	HOME_TEAM	2023-09-23
435994	1	1	6	402	62	AWAY_TEAM	2023-09-23
435996	1	1	6	328	66	AWAY_TEAM	2023-09-23
435993	1	1	6	57	73	DRAW	2023-09-24
435995	1	1	6	397	1044	HOME_TEAM	2023-09-24
435997	1	1	6	61	58	AWAY_TEAM	2023-09-24
435999	1	1	6	64	563	HOME_TEAM	2023-09-24
436002	1	1	6	356	67	AWAY_TEAM	2023-09-24
436004	1	1	7	58	397	HOME_TEAM	2023-09-30
436003	1	1	7	1044	57	AWAY_TEAM	2023-09-30
436005	1	1	7	62	389	AWAY_TEAM	2023-09-30
436007	1	1	7	66	354	AWAY_TEAM	2023-09-30
436008	1	1	7	67	328	HOME_TEAM	2023-09-30
436011	1	1	7	563	356	HOME_TEAM	2023-09-30
436012	1	1	7	76	65	HOME_TEAM	2023-09-30
436010	1	1	7	73	64	HOME_TEAM	2023-09-30
436009	1	1	7	351	402	DRAW	2023-10-01
436006	1	1	7	63	61	AWAY_TEAM	2023-10-02
435957	1	1	2	389	328	AWAY_TEAM	2023-10-03
436019	1	1	8	389	73	AWAY_TEAM	2023-10-07
436015	1	1	8	328	61	AWAY_TEAM	2023-10-07
436017	1	1	8	62	1044	HOME_TEAM	2023-10-07
436018	1	1	8	63	356	HOME_TEAM	2023-10-07
436020	1	1	8	66	402	HOME_TEAM	2023-10-07
436016	1	1	8	354	351	DRAW	2023-10-07
436014	1	1	8	397	64	DRAW	2023-10-08
436021	1	1	8	563	67	DRAW	2023-10-08
436022	1	1	8	76	58	DRAW	2023-10-08
436013	1	1	8	57	65	HOME_TEAM	2023-10-08
436027	1	1	9	64	62	HOME_TEAM	2023-10-21
436023	1	1	9	1044	76	AWAY_TEAM	2023-10-21
436025	1	1	9	402	328	HOME_TEAM	2023-10-21
436028	1	1	9	65	397	HOME_TEAM	2023-10-21
436029	1	1	9	67	354	HOME_TEAM	2023-10-21
436030	1	1	9	351	389	DRAW	2023-10-21
436026	1	1	9	61	57	DRAW	2023-10-21
436031	1	1	9	356	66	AWAY_TEAM	2023-10-21
436024	1	1	9	58	563	HOME_TEAM	2023-10-22
436032	1	1	9	73	63	HOME_TEAM	2023-10-23
436038	1	1	10	354	73	AWAY_TEAM	2023-10-27
436037	1	1	10	61	402	AWAY_TEAM	2023-10-28
436033	1	1	10	1044	328	HOME_TEAM	2023-10-28
436034	1	1	10	57	356	HOME_TEAM	2023-10-28
436042	1	1	10	76	67	DRAW	2023-10-28
436041	1	1	10	563	62	AWAY_TEAM	2023-10-29
436035	1	1	10	58	389	HOME_TEAM	2023-10-29
436036	1	1	10	397	63	DRAW	2023-10-29
436039	1	1	10	64	351	HOME_TEAM	2023-10-29
436040	1	1	10	66	65	AWAY_TEAM	2023-10-29
436046	1	1	11	63	66	AWAY_TEAM	2023-11-04
436043	1	1	11	402	563	HOME_TEAM	2023-11-04
436044	1	1	11	328	354	AWAY_TEAM	2023-11-04
436045	1	1	11	62	397	DRAW	2023-11-04
436048	1	1	11	65	1044	HOME_TEAM	2023-11-04
436051	1	1	11	356	76	HOME_TEAM	2023-11-04
436049	1	1	11	67	57	HOME_TEAM	2023-11-04
436050	1	1	11	351	58	HOME_TEAM	2023-11-05
436047	1	1	11	389	64	DRAW	2023-11-05
436052	1	1	11	73	61	AWAY_TEAM	2023-11-06
436062	1	1	12	76	73	HOME_TEAM	2023-11-11
436054	1	1	12	57	328	HOME_TEAM	2023-11-11
436058	1	1	12	354	62	AWAY_TEAM	2023-11-11
436060	1	1	12	66	389	HOME_TEAM	2023-11-11
436053	1	1	12	1044	67	HOME_TEAM	2023-11-11
436055	1	1	12	58	63	HOME_TEAM	2023-11-12
436056	1	1	12	397	356	DRAW	2023-11-12
436059	1	1	12	64	402	HOME_TEAM	2023-11-12
436061	1	1	12	563	351	HOME_TEAM	2023-11-12
436057	1	1	12	61	65	DRAW	2023-11-12
436068	1	1	13	65	64	DRAW	2023-11-25
436064	1	1	13	328	563	AWAY_TEAM	2023-11-25
436067	1	1	13	389	354	HOME_TEAM	2023-11-25
436069	1	1	13	67	61	HOME_TEAM	2023-11-25
436070	1	1	13	351	397	AWAY_TEAM	2023-11-25
436071	1	1	13	356	1044	AWAY_TEAM	2023-11-25
436063	1	1	13	402	57	AWAY_TEAM	2023-11-25
436072	1	1	13	73	58	AWAY_TEAM	2023-11-26
436065	1	1	13	62	66	AWAY_TEAM	2023-11-26
436066	1	1	13	63	76	HOME_TEAM	2023-11-27
436074	1	1	14	57	76	HOME_TEAM	2023-12-02
436075	1	1	14	402	389	HOME_TEAM	2023-12-02
436076	1	1	14	328	356	HOME_TEAM	2023-12-02
436081	1	1	14	351	62	AWAY_TEAM	2023-12-02
436080	1	1	14	67	66	HOME_TEAM	2023-12-02
436073	1	1	14	1044	58	DRAW	2023-12-03
436077	1	1	14	61	397	HOME_TEAM	2023-12-03
436078	1	1	14	64	63	HOME_TEAM	2023-12-03
436082	1	1	14	563	354	DRAW	2023-12-03
436079	1	1	14	65	73	DRAW	2023-12-03
436090	1	1	15	76	328	HOME_TEAM	2023-12-05
436087	1	1	15	389	57	AWAY_TEAM	2023-12-05
436084	1	1	15	397	402	HOME_TEAM	2023-12-06
436086	1	1	15	63	351	HOME_TEAM	2023-12-06
436088	1	1	15	356	64	AWAY_TEAM	2023-12-06
436091	1	1	15	354	1044	AWAY_TEAM	2023-12-06
436083	1	1	15	58	65	HOME_TEAM	2023-12-06
436092	1	1	15	66	61	HOME_TEAM	2023-12-06
436085	1	1	15	62	67	HOME_TEAM	2023-12-07
436089	1	1	15	73	563	AWAY_TEAM	2023-12-07
436095	1	1	16	354	64	AWAY_TEAM	2023-12-09
436094	1	1	16	397	328	DRAW	2023-12-09
436099	1	1	16	66	1044	AWAY_TEAM	2023-12-09
436100	1	1	16	356	402	HOME_TEAM	2023-12-09
436102	1	1	16	76	351	DRAW	2023-12-09
436093	1	1	16	58	57	HOME_TEAM	2023-12-09
436096	1	1	16	62	61	HOME_TEAM	2023-12-10
436097	1	1	16	63	563	HOME_TEAM	2023-12-10
436098	1	1	16	389	65	AWAY_TEAM	2023-12-10
436101	1	1	16	73	67	HOME_TEAM	2023-12-10
436111	1	1	17	351	73	AWAY_TEAM	2023-12-15
436107	1	1	17	61	356	HOME_TEAM	2023-12-16
436109	1	1	17	65	354	DRAW	2023-12-16
436110	1	1	17	67	63	HOME_TEAM	2023-12-16
436106	1	1	17	328	62	AWAY_TEAM	2023-12-16
436104	1	1	17	57	397	HOME_TEAM	2023-12-17
436105	1	1	17	402	58	AWAY_TEAM	2023-12-17
436112	1	1	17	563	76	HOME_TEAM	2023-12-17
436108	1	1	17	64	66	DRAW	2023-12-17
436114	1	1	18	354	397	DRAW	2023-12-21
436113	1	1	18	58	356	DRAW	2023-12-22
436121	1	1	18	563	66	HOME_TEAM	2023-12-23
436115	1	1	18	63	328	AWAY_TEAM	2023-12-23
436117	1	1	18	389	67	HOME_TEAM	2023-12-23
436119	1	1	18	351	1044	AWAY_TEAM	2023-12-23
436120	1	1	18	73	62	HOME_TEAM	2023-12-23
436116	1	1	18	64	57	DRAW	2023-12-23
436122	1	1	18	76	61	HOME_TEAM	2023-12-24
436131	1	1	19	67	351	AWAY_TEAM	2023-12-26
436123	1	1	19	1044	63	HOME_TEAM	2023-12-26
436132	1	1	19	356	389	AWAY_TEAM	2023-12-26
436127	1	1	19	328	64	AWAY_TEAM	2023-12-26
436130	1	1	19	66	58	HOME_TEAM	2023-12-26
436125	1	1	19	402	76	AWAY_TEAM	2023-12-27
436128	1	1	19	61	354	HOME_TEAM	2023-12-27
436129	1	1	19	62	65	AWAY_TEAM	2023-12-27
436126	1	1	19	397	73	HOME_TEAM	2023-12-28
436124	1	1	19	57	563	AWAY_TEAM	2023-12-28
436137	1	1	20	389	61	AWAY_TEAM	2023-12-30
436133	1	1	20	58	328	HOME_TEAM	2023-12-30
436134	1	1	20	354	402	HOME_TEAM	2023-12-30
436138	1	1	20	65	356	HOME_TEAM	2023-12-30
436142	1	1	20	76	62	HOME_TEAM	2023-12-30
436139	1	1	20	351	66	HOME_TEAM	2023-12-30
436135	1	1	20	63	57	HOME_TEAM	2023-12-31
436140	1	1	20	73	1044	HOME_TEAM	2023-12-31
436136	1	1	20	64	67	HOME_TEAM	2024-01-01
436141	1	1	20	563	397	DRAW	2024-01-02
436147	1	1	21	328	389	DRAW	2024-01-12
436148	1	1	21	61	63	HOME_TEAM	2024-01-13
436151	1	1	21	67	65	AWAY_TEAM	2024-01-13
436149	1	1	21	62	58	DRAW	2024-01-14
436150	1	1	21	66	73	DRAW	2024-01-14
436144	1	1	21	57	354	HOME_TEAM	2024-01-20
436145	1	1	21	402	351	HOME_TEAM	2024-01-20
436152	1	1	21	356	563	DRAW	2024-01-21
436143	1	1	21	1044	64	AWAY_TEAM	2024-01-21
436146	1	1	21	397	76	DRAW	2024-01-22
436153	1	1	22	351	57	AWAY_TEAM	2024-01-30
436155	1	1	22	389	397	HOME_TEAM	2024-01-30
436156	1	1	22	63	62	DRAW	2024-01-30
436157	1	1	22	354	356	HOME_TEAM	2024-01-30
436158	1	1	22	58	67	AWAY_TEAM	2024-01-30
436159	1	1	22	73	402	HOME_TEAM	2024-01-31
436161	1	1	22	65	328	HOME_TEAM	2024-01-31
436162	1	1	22	64	61	HOME_TEAM	2024-01-31
436154	1	1	22	563	1044	DRAW	2024-02-01
436160	1	1	22	76	66	AWAY_TEAM	2024-02-01
436169	1	1	23	62	73	DRAW	2024-02-03
436166	1	1	23	397	354	HOME_TEAM	2024-02-03
436167	1	1	23	328	63	DRAW	2024-02-03
436171	1	1	23	67	389	DRAW	2024-02-03
436172	1	1	23	356	58	AWAY_TEAM	2024-02-03
436163	1	1	23	1044	351	DRAW	2024-02-04
436168	1	1	23	61	76	AWAY_TEAM	2024-02-04
436170	1	1	23	66	563	HOME_TEAM	2024-02-04
436164	1	1	23	57	64	HOME_TEAM	2024-02-04
436165	1	1	23	402	65	AWAY_TEAM	2024-02-05
436178	1	1	24	65	62	HOME_TEAM	2024-02-10
436175	1	1	24	63	1044	HOME_TEAM	2024-02-10
436176	1	1	24	64	328	HOME_TEAM	2024-02-10
436177	1	1	24	389	356	AWAY_TEAM	2024-02-10
436180	1	1	24	73	397	HOME_TEAM	2024-02-10
436182	1	1	24	76	402	AWAY_TEAM	2024-02-10
436179	1	1	24	351	67	AWAY_TEAM	2024-02-10
436181	1	1	24	563	57	AWAY_TEAM	2024-02-11
436173	1	1	24	58	66	AWAY_TEAM	2024-02-11
436174	1	1	24	354	61	AWAY_TEAM	2024-02-12
436183	1	1	25	402	64	AWAY_TEAM	2024-02-17
436184	1	1	25	328	57	AWAY_TEAM	2024-02-17
436186	1	1	25	63	58	AWAY_TEAM	2024-02-17
436189	1	1	25	67	1044	DRAW	2024-02-17
436190	1	1	25	351	563	HOME_TEAM	2024-02-17
436192	1	1	25	73	76	AWAY_TEAM	2024-02-17
436188	1	1	25	65	61	DRAW	2024-02-17
436191	1	1	25	356	397	AWAY_TEAM	2024-02-18
436187	1	1	25	389	66	AWAY_TEAM	2024-02-18
436185	1	1	25	62	354	DRAW	2024-02-19
436118	1	1	18	65	402	HOME_TEAM	2024-02-20
436199	1	1	26	64	389	HOME_TEAM	2024-02-21
436195	1	1	26	58	351	HOME_TEAM	2024-02-24
436196	1	1	26	397	62	DRAW	2024-02-24
436198	1	1	26	354	328	HOME_TEAM	2024-02-24
436200	1	1	26	66	63	AWAY_TEAM	2024-02-24
436193	1	1	26	1044	65	AWAY_TEAM	2024-02-24
436194	1	1	26	57	67	HOME_TEAM	2024-02-24
436202	1	1	26	76	356	HOME_TEAM	2024-02-25
436201	1	1	26	563	402	HOME_TEAM	2024-02-26
436203	1	1	27	402	61	DRAW	2024-03-02
436205	1	1	27	62	563	AWAY_TEAM	2024-03-02
436206	1	1	27	63	397	HOME_TEAM	2024-03-02
436209	1	1	27	67	76	HOME_TEAM	2024-03-02
436210	1	1	27	351	64	AWAY_TEAM	2024-03-02
436212	1	1	27	73	354	HOME_TEAM	2024-03-02
436207	1	1	27	389	58	AWAY_TEAM	2024-03-02
436204	1	1	27	328	1044	AWAY_TEAM	2024-03-03
436208	1	1	27	65	66	HOME_TEAM	2024-03-03
436211	1	1	27	356	57	AWAY_TEAM	2024-03-04
436220	1	1	28	66	62	HOME_TEAM	2024-03-09
436213	1	1	28	1044	356	DRAW	2024-03-09
436218	1	1	28	354	389	DRAW	2024-03-09
436222	1	1	28	76	63	HOME_TEAM	2024-03-09
436214	1	1	28	57	402	HOME_TEAM	2024-03-09
436215	1	1	28	58	73	AWAY_TEAM	2024-03-10
436216	1	1	28	397	351	HOME_TEAM	2024-03-10
436221	1	1	28	563	328	DRAW	2024-03-10
436219	1	1	28	64	65	DRAW	2024-03-10
436217	1	1	28	61	67	HOME_TEAM	2024-03-11
436103	1	1	17	1044	389	HOME_TEAM	2024-03-13
436225	1	1	29	328	402	HOME_TEAM	2024-03-16
436229	1	1	29	389	351	DRAW	2024-03-16
436228	1	1	29	63	73	HOME_TEAM	2024-03-16
436231	1	1	29	563	58	DRAW	2024-03-17
436239	1	1	30	67	563	HOME_TEAM	2024-03-30
436233	1	1	30	1044	62	HOME_TEAM	2024-03-30
436236	1	1	30	61	328	DRAW	2024-03-30
436240	1	1	30	351	354	DRAW	2024-03-30
436241	1	1	30	356	63	DRAW	2024-03-30
436242	1	1	30	73	389	HOME_TEAM	2024-03-30
436234	1	1	30	58	76	HOME_TEAM	2024-03-30
436235	1	1	30	402	66	DRAW	2024-03-30
436237	1	1	30	64	397	HOME_TEAM	2024-03-31
436238	1	1	30	65	57	DRAW	2024-03-31
436247	1	1	31	351	63	HOME_TEAM	2024-04-02
436250	1	1	31	67	62	DRAW	2024-04-02
436243	1	1	31	1044	354	HOME_TEAM	2024-04-02
436246	1	1	31	328	76	DRAW	2024-04-02
436248	1	1	31	563	73	DRAW	2024-04-02
436244	1	1	31	57	389	HOME_TEAM	2024-04-03
436245	1	1	31	402	397	DRAW	2024-04-03
436252	1	1	31	65	58	HOME_TEAM	2024-04-03
436251	1	1	31	64	356	HOME_TEAM	2024-04-04
436249	1	1	31	61	66	HOME_TEAM	2024-04-04
436255	1	1	32	354	65	AWAY_TEAM	2024-04-06
436253	1	1	32	58	402	DRAW	2024-04-06
436256	1	1	32	62	328	HOME_TEAM	2024-04-06
436257	1	1	32	63	67	AWAY_TEAM	2024-04-06
436258	1	1	32	389	1044	HOME_TEAM	2024-04-06
436262	1	1	32	76	563	AWAY_TEAM	2024-04-06
436254	1	1	32	397	57	AWAY_TEAM	2024-04-06
436259	1	1	32	66	64	DRAW	2024-04-07
436260	1	1	32	356	61	DRAW	2024-04-07
436261	1	1	32	73	351	HOME_TEAM	2024-04-07
436270	1	1	33	67	73	HOME_TEAM	2024-04-13
436265	1	1	33	402	356	HOME_TEAM	2024-04-13
436266	1	1	33	328	397	DRAW	2024-04-13
436269	1	1	33	65	389	HOME_TEAM	2024-04-13
436271	1	1	33	351	76	DRAW	2024-04-13
436263	1	1	33	1044	66	DRAW	2024-04-13
436268	1	1	33	64	354	AWAY_TEAM	2024-04-14
436272	1	1	33	563	63	AWAY_TEAM	2024-04-14
436264	1	1	33	57	58	AWAY_TEAM	2024-04-14
436267	1	1	33	61	62	HOME_TEAM	2024-04-15
436278	1	1	34	389	402	AWAY_TEAM	2024-04-20
436280	1	1	34	356	328	AWAY_TEAM	2024-04-20
436282	1	1	34	76	57	AWAY_TEAM	2024-04-20
436276	1	1	34	62	351	HOME_TEAM	2024-04-21
436273	1	1	34	58	1044	HOME_TEAM	2024-04-21
436275	1	1	34	354	563	HOME_TEAM	2024-04-21
436277	1	1	34	63	64	AWAY_TEAM	2024-04-21
436223	1	1	29	57	61	HOME_TEAM	2024-04-23
436232	1	1	29	76	1044	AWAY_TEAM	2024-04-24
436226	1	1	29	354	67	HOME_TEAM	2024-04-24
436227	1	1	29	62	64	HOME_TEAM	2024-04-24
436230	1	1	29	66	356	HOME_TEAM	2024-04-24
436224	1	1	29	397	65	AWAY_TEAM	2024-04-25
436291	1	1	35	563	64	DRAW	2024-04-27
436286	1	1	35	63	354	DRAW	2024-04-27
436287	1	1	35	66	328	DRAW	2024-04-27
436288	1	1	35	67	356	HOME_TEAM	2024-04-27
436292	1	1	35	76	389	HOME_TEAM	2024-04-27
436285	1	1	35	62	402	HOME_TEAM	2024-04-27
436284	1	1	35	58	61	DRAW	2024-04-27
436283	1	1	35	1044	397	HOME_TEAM	2024-04-28
436290	1	1	35	73	57	AWAY_TEAM	2024-04-28
436289	1	1	35	351	65	AWAY_TEAM	2024-04-28
436197	1	1	26	61	73	HOME_TEAM	2024-05-02
436300	1	1	36	389	62	DRAW	2024-05-03
436293	1	1	36	57	1044	HOME_TEAM	2024-05-04
436294	1	1	36	402	63	DRAW	2024-05-04
436296	1	1	36	328	67	AWAY_TEAM	2024-05-04
436302	1	1	36	356	351	AWAY_TEAM	2024-05-04
436301	1	1	36	65	76	HOME_TEAM	2024-05-04
436295	1	1	36	397	58	HOME_TEAM	2024-05-05
436297	1	1	36	61	563	HOME_TEAM	2024-05-05
436299	1	1	36	64	73	HOME_TEAM	2024-05-05
436298	1	1	36	354	66	HOME_TEAM	2024-05-06
436306	1	1	37	63	65	AWAY_TEAM	2024-05-11
436303	1	1	37	1044	402	AWAY_TEAM	2024-05-11
436305	1	1	37	62	356	HOME_TEAM	2024-05-11
436308	1	1	37	67	397	DRAW	2024-05-11
436310	1	1	37	73	328	HOME_TEAM	2024-05-11
436311	1	1	37	563	389	HOME_TEAM	2024-05-11
436312	1	1	37	76	354	AWAY_TEAM	2024-05-11
436309	1	1	37	351	61	AWAY_TEAM	2024-05-11
436307	1	1	37	66	57	AWAY_TEAM	2024-05-12
436304	1	1	37	58	64	DRAW	2024-05-13
436281	1	1	34	73	65	AWAY_TEAM	2024-05-14
436274	1	1	34	397	61	AWAY_TEAM	2024-05-15
436279	1	1	34	66	67	HOME_TEAM	2024-05-15
436313	1	1	38	57	62	HOME_TEAM	2024-05-19
436314	1	1	38	402	67	AWAY_TEAM	2024-05-19
436315	1	1	38	397	66	AWAY_TEAM	2024-05-19
436316	1	1	38	328	351	AWAY_TEAM	2024-05-19
436317	1	1	38	61	1044	HOME_TEAM	2024-05-19
436318	1	1	38	354	58	HOME_TEAM	2024-05-19
436319	1	1	38	64	76	HOME_TEAM	2024-05-19
436320	1	1	38	389	63	AWAY_TEAM	2024-05-19
436321	1	1	38	65	563	HOME_TEAM	2024-05-19
436322	1	1	38	356	73	AWAY_TEAM	2024-05-19
444255	2	2	1	445	450	AWAY_TEAM	2023-08-19
444256	2	2	1	470	113	AWAY_TEAM	2023-08-19
444257	2	2	1	107	99	AWAY_TEAM	2023-08-19
444258	2	2	1	108	5911	HOME_TEAM	2023-08-19
444260	2	2	1	100	455	DRAW	2023-08-20
444261	2	2	1	471	102	AWAY_TEAM	2023-08-20
444259	2	2	1	5890	110	HOME_TEAM	2023-08-20
444263	2	2	1	115	109	AWAY_TEAM	2023-08-20
444262	2	2	1	586	104	DRAW	2023-08-21
444254	2	2	1	103	98	AWAY_TEAM	2023-08-21
444266	2	2	2	470	102	HOME_TEAM	2023-08-26
444271	2	2	2	5911	445	HOME_TEAM	2023-08-26
444267	2	2	2	450	100	HOME_TEAM	2023-08-26
444270	2	2	2	98	586	HOME_TEAM	2023-08-26
444265	2	2	2	99	5890	DRAW	2023-08-27
444268	2	2	2	109	103	DRAW	2023-08-27
444269	2	2	2	110	107	AWAY_TEAM	2023-08-27
444272	2	2	2	113	471	HOME_TEAM	2023-08-27
444273	2	2	2	455	115	DRAW	2023-08-28
444264	2	2	2	104	108	AWAY_TEAM	2023-08-28
444281	2	2	3	471	450	HOME_TEAM	2023-09-01
444280	2	2	3	100	98	AWAY_TEAM	2023-09-01
444275	2	2	3	103	104	HOME_TEAM	2023-09-02
444283	2	2	3	115	470	DRAW	2023-09-02
444274	2	2	3	102	5911	HOME_TEAM	2023-09-02
444279	2	2	3	113	110	AWAY_TEAM	2023-09-02
444277	2	2	3	108	99	HOME_TEAM	2023-09-03
444282	2	2	3	586	107	HOME_TEAM	2023-09-03
444276	2	2	3	445	109	AWAY_TEAM	2023-09-03
444278	2	2	3	5890	455	HOME_TEAM	2023-09-03
444290	2	2	4	109	110	HOME_TEAM	2023-09-16
444289	2	2	4	108	98	HOME_TEAM	2023-09-16
444287	2	2	4	107	113	DRAW	2023-09-16
444284	2	2	4	104	115	DRAW	2023-09-17
444286	2	2	4	470	471	HOME_TEAM	2023-09-17
444291	2	2	4	5911	5890	DRAW	2023-09-17
444285	2	2	4	99	102	HOME_TEAM	2023-09-17
444292	2	2	4	100	445	HOME_TEAM	2023-09-17
444293	2	2	4	455	586	AWAY_TEAM	2023-09-18
444288	2	2	4	450	103	DRAW	2023-09-18
444300	2	2	5	455	470	DRAW	2023-09-22
444298	2	2	5	5890	107	HOME_TEAM	2023-09-22
444299	2	2	5	98	450	HOME_TEAM	2023-09-23
444301	2	2	5	471	109	HOME_TEAM	2023-09-23
444297	2	2	5	110	5911	DRAW	2023-09-23
444296	2	2	5	445	108	AWAY_TEAM	2023-09-24
444294	2	2	5	102	104	HOME_TEAM	2023-09-24
444303	2	2	5	115	99	AWAY_TEAM	2023-09-24
444295	2	2	5	103	113	DRAW	2023-09-24
444302	2	2	5	586	100	DRAW	2023-09-24
444310	2	2	6	109	5890	HOME_TEAM	2023-09-26
444304	2	2	6	104	98	AWAY_TEAM	2023-09-27
444305	2	2	6	445	455	HOME_TEAM	2023-09-27
444308	2	2	6	450	102	AWAY_TEAM	2023-09-27
444309	2	2	6	108	471	AWAY_TEAM	2023-09-27
444311	2	2	6	110	586	HOME_TEAM	2023-09-27
444313	2	2	6	113	115	HOME_TEAM	2023-09-27
444306	2	2	6	470	99	DRAW	2023-09-28
444312	2	2	6	5911	103	DRAW	2023-09-28
444307	2	2	6	107	100	HOME_TEAM	2023-09-28
444317	2	2	7	5890	113	AWAY_TEAM	2023-09-30
444318	2	2	7	98	110	HOME_TEAM	2023-09-30
444320	2	2	7	455	108	AWAY_TEAM	2023-09-30
444315	2	2	7	103	445	HOME_TEAM	2023-10-01
444323	2	2	7	115	107	DRAW	2023-10-01
444314	2	2	7	102	109	DRAW	2023-10-01
444319	2	2	7	100	470	HOME_TEAM	2023-10-01
444321	2	2	7	471	5911	AWAY_TEAM	2023-10-02
444322	2	2	7	586	450	DRAW	2023-10-02
444316	2	2	7	99	104	HOME_TEAM	2023-10-02
444325	2	2	8	445	115	DRAW	2023-10-06
444331	2	2	8	5890	471	DRAW	2023-10-06
444328	2	2	8	108	103	DRAW	2023-10-07
444329	2	2	8	109	586	HOME_TEAM	2023-10-07
444327	2	2	8	107	98	AWAY_TEAM	2023-10-07
444332	2	2	8	5911	455	HOME_TEAM	2023-10-08
444326	2	2	8	470	450	HOME_TEAM	2023-10-08
444330	2	2	8	110	102	HOME_TEAM	2023-10-08
444324	2	2	8	104	100	AWAY_TEAM	2023-10-08
444333	2	2	8	113	99	AWAY_TEAM	2023-10-08
444337	2	2	9	450	113	AWAY_TEAM	2023-10-21
444342	2	2	9	586	108	AWAY_TEAM	2023-10-21
444341	2	2	9	471	110	AWAY_TEAM	2023-10-21
444339	2	2	9	100	5911	HOME_TEAM	2023-10-22
444335	2	2	9	103	470	HOME_TEAM	2023-10-22
444340	2	2	9	455	104	DRAW	2023-10-22
444334	2	2	9	102	107	HOME_TEAM	2023-10-22
444338	2	2	9	98	109	AWAY_TEAM	2023-10-22
444343	2	2	9	115	5890	DRAW	2023-10-23
444336	2	2	9	99	445	AWAY_TEAM	2023-10-23
444346	2	2	10	107	455	HOME_TEAM	2023-10-27
444353	2	2	10	471	103	DRAW	2023-10-28
444350	2	2	10	5890	586	AWAY_TEAM	2023-10-28
444348	2	2	10	109	450	HOME_TEAM	2023-10-28
444344	2	2	10	104	470	HOME_TEAM	2023-10-29
444351	2	2	10	5911	115	DRAW	2023-10-29
444347	2	2	10	108	100	HOME_TEAM	2023-10-29
444352	2	2	10	113	98	DRAW	2023-10-29
444345	2	2	10	445	102	AWAY_TEAM	2023-10-30
444349	2	2	10	110	99	HOME_TEAM	2023-10-30
444355	2	2	11	103	110	HOME_TEAM	2023-11-03
444362	2	2	11	455	113	AWAY_TEAM	2023-11-04
444354	2	2	11	102	108	AWAY_TEAM	2023-11-04
444360	2	2	11	98	115	AWAY_TEAM	2023-11-04
444359	2	2	11	450	5911	AWAY_TEAM	2023-11-05
444356	2	2	11	104	107	HOME_TEAM	2023-11-05
444361	2	2	11	100	5890	HOME_TEAM	2023-11-05
444357	2	2	11	99	109	AWAY_TEAM	2023-11-05
444358	2	2	11	470	445	HOME_TEAM	2023-11-06
444363	2	2	11	586	471	HOME_TEAM	2023-11-06
444372	2	2	12	471	455	DRAW	2023-11-10
444365	2	2	12	107	450	HOME_TEAM	2023-11-10
444369	2	2	12	5890	98	DRAW	2023-11-11
444367	2	2	12	109	104	HOME_TEAM	2023-11-11
444370	2	2	12	5911	586	DRAW	2023-11-11
444371	2	2	12	113	445	AWAY_TEAM	2023-11-12
444364	2	2	12	99	103	HOME_TEAM	2023-11-12
444373	2	2	12	115	102	DRAW	2023-11-12
444368	2	2	12	110	100	DRAW	2023-11-12
444366	2	2	12	108	470	HOME_TEAM	2023-11-12
444383	2	2	13	455	110	HOME_TEAM	2023-11-25
444374	2	2	13	102	113	AWAY_TEAM	2023-11-25
444381	2	2	13	98	99	HOME_TEAM	2023-11-25
444376	2	2	13	104	5911	DRAW	2023-11-26
444377	2	2	13	445	471	AWAY_TEAM	2023-11-26
444378	2	2	13	470	107	HOME_TEAM	2023-11-26
444382	2	2	13	100	115	HOME_TEAM	2023-11-26
444380	2	2	13	109	108	DRAW	2023-11-26
444379	2	2	13	450	5890	DRAW	2023-11-27
444375	2	2	13	103	586	HOME_TEAM	2023-11-27
444389	2	2	14	5911	109	AWAY_TEAM	2023-12-01
444385	2	2	14	107	445	DRAW	2023-12-02
444386	2	2	14	110	104	HOME_TEAM	2023-12-02
444388	2	2	14	98	470	HOME_TEAM	2023-12-02
444387	2	2	14	5890	103	DRAW	2023-12-03
444384	2	2	14	99	455	HOME_TEAM	2023-12-03
444393	2	2	14	115	450	DRAW	2023-12-03
444391	2	2	14	471	100	AWAY_TEAM	2023-12-03
444390	2	2	14	113	108	AWAY_TEAM	2023-12-03
444392	2	2	14	586	102	HOME_TEAM	2023-12-04
444400	2	2	15	109	113	HOME_TEAM	2023-12-08
444398	2	2	15	450	110	DRAW	2023-12-09
444394	2	2	15	102	98	HOME_TEAM	2023-12-09
444399	2	2	15	108	115	HOME_TEAM	2023-12-09
444397	2	2	15	470	586	DRAW	2023-12-10
444401	2	2	15	5911	107	HOME_TEAM	2023-12-10
444403	2	2	15	455	103	AWAY_TEAM	2023-12-10
444402	2	2	15	100	99	DRAW	2023-12-10
444396	2	2	15	445	5890	DRAW	2023-12-11
444395	2	2	15	104	471	HOME_TEAM	2023-12-11
444407	2	2	16	107	109	DRAW	2023-12-15
444409	2	2	16	5890	470	HOME_TEAM	2023-12-16
444411	2	2	16	113	104	HOME_TEAM	2023-12-16
444412	2	2	16	586	445	HOME_TEAM	2023-12-16
444410	2	2	16	98	5911	HOME_TEAM	2023-12-17
444406	2	2	16	99	450	HOME_TEAM	2023-12-17
444413	2	2	16	115	471	DRAW	2023-12-17
444405	2	2	16	103	100	HOME_TEAM	2023-12-17
444408	2	2	16	110	108	AWAY_TEAM	2023-12-17
444404	2	2	16	102	455	HOME_TEAM	2023-12-18
444422	2	2	17	471	107	AWAY_TEAM	2023-12-22
444415	2	2	17	445	110	AWAY_TEAM	2023-12-22
444419	2	2	17	5911	99	AWAY_TEAM	2023-12-22
444421	2	2	17	455	98	DRAW	2023-12-22
444416	2	2	17	470	109	AWAY_TEAM	2023-12-23
444423	2	2	17	586	115	DRAW	2023-12-23
444414	2	2	17	103	102	HOME_TEAM	2023-12-23
444417	2	2	17	450	104	HOME_TEAM	2023-12-23
444418	2	2	17	108	5890	HOME_TEAM	2023-12-23
444420	2	2	17	100	113	HOME_TEAM	2023-12-23
444426	2	2	18	99	586	HOME_TEAM	2023-12-29
444432	2	2	18	113	5911	DRAW	2023-12-29
444427	2	2	18	107	108	DRAW	2023-12-29
444430	2	2	18	110	470	HOME_TEAM	2023-12-29
444424	2	2	18	102	5890	HOME_TEAM	2023-12-30
444425	2	2	18	104	445	DRAW	2023-12-30
444433	2	2	18	115	103	HOME_TEAM	2023-12-30
444428	2	2	18	450	455	AWAY_TEAM	2023-12-30
444431	2	2	18	98	471	HOME_TEAM	2023-12-30
444429	2	2	18	109	100	HOME_TEAM	2023-12-30
444434	2	2	19	103	107	DRAW	2024-01-05
444437	2	2	19	108	450	HOME_TEAM	2024-01-06
444436	2	2	19	470	5911	AWAY_TEAM	2024-01-06
444438	2	2	19	5890	104	DRAW	2024-01-06
444441	2	2	19	471	99	HOME_TEAM	2024-01-06
444435	2	2	19	445	98	AWAY_TEAM	2024-01-07
444442	2	2	19	586	113	HOME_TEAM	2024-01-07
444443	2	2	19	115	110	AWAY_TEAM	2024-01-07
444440	2	2	19	455	109	AWAY_TEAM	2024-01-07
444439	2	2	19	100	102	DRAW	2024-01-07
444447	2	2	20	107	586	DRAW	2024-01-13
444453	2	2	20	113	455	HOME_TEAM	2024-01-13
444448	2	2	20	450	445	HOME_TEAM	2024-01-13
444452	2	2	20	5911	108	AWAY_TEAM	2024-01-13
444450	2	2	20	110	5890	HOME_TEAM	2024-01-14
444445	2	2	20	104	103	HOME_TEAM	2024-01-14
444446	2	2	20	99	115	DRAW	2024-01-14
444451	2	2	20	98	100	HOME_TEAM	2024-01-14
444444	2	2	20	102	470	HOME_TEAM	2024-01-15
444449	2	2	20	109	471	HOME_TEAM	2024-01-16
444459	2	2	21	100	450	HOME_TEAM	2024-01-20
444463	2	2	21	115	98	AWAY_TEAM	2024-01-20
444456	2	2	21	470	104	HOME_TEAM	2024-01-21
444455	2	2	21	445	5911	HOME_TEAM	2024-01-21
444460	2	2	21	455	107	AWAY_TEAM	2024-01-21
444458	2	2	21	5890	109	AWAY_TEAM	2024-01-21
444465	2	2	22	104	586	AWAY_TEAM	2024-01-26
444464	2	2	22	102	115	HOME_TEAM	2024-01-27
444469	2	2	22	109	445	DRAW	2024-01-27
444471	2	2	22	98	103	DRAW	2024-01-27
444467	2	2	22	107	5890	HOME_TEAM	2024-01-28
444468	2	2	22	450	470	DRAW	2024-01-28
444472	2	2	22	5911	471	HOME_TEAM	2024-01-28
444470	2	2	22	110	113	DRAW	2024-01-28
444466	2	2	22	99	108	AWAY_TEAM	2024-01-28
444473	2	2	22	455	100	AWAY_TEAM	2024-01-29
444479	2	2	23	5890	99	HOME_TEAM	2024-02-02
444476	2	2	23	445	107	DRAW	2024-02-03
444483	2	2	23	115	5911	DRAW	2024-02-03
444477	2	2	23	470	98	AWAY_TEAM	2024-02-03
444475	2	2	23	103	471	HOME_TEAM	2024-02-03
444482	2	2	23	586	455	DRAW	2024-02-04
444480	2	2	23	113	450	HOME_TEAM	2024-02-04
444474	2	2	23	102	110	HOME_TEAM	2024-02-04
444478	2	2	23	108	109	HOME_TEAM	2024-02-04
444481	2	2	23	100	104	HOME_TEAM	2024-02-05
444492	2	2	24	455	445	AWAY_TEAM	2024-02-09
444485	2	2	24	104	110	AWAY_TEAM	2024-02-10
444491	2	2	24	100	108	AWAY_TEAM	2024-02-10
444493	2	2	24	471	586	DRAW	2024-02-10
444486	2	2	24	99	470	HOME_TEAM	2024-02-11
444484	2	2	24	103	5890	HOME_TEAM	2024-02-11
444490	2	2	24	5911	450	DRAW	2024-02-11
444487	2	2	24	107	102	AWAY_TEAM	2024-02-11
444489	2	2	24	98	113	HOME_TEAM	2024-02-11
444488	2	2	24	109	115	AWAY_TEAM	2024-02-12
444454	2	2	21	103	99	HOME_TEAM	2024-02-14
444502	2	2	25	586	5890	HOME_TEAM	2024-02-16
444498	2	2	25	108	455	HOME_TEAM	2024-02-16
444501	2	2	25	113	107	DRAW	2024-02-17
444497	2	2	25	450	109	DRAW	2024-02-17
444494	2	2	25	102	471	HOME_TEAM	2024-02-17
444499	2	2	25	110	103	AWAY_TEAM	2024-02-18
444495	2	2	25	445	99	DRAW	2024-02-18
444503	2	2	25	115	104	DRAW	2024-02-18
444496	2	2	25	470	100	AWAY_TEAM	2024-02-18
444500	2	2	25	5911	98	HOME_TEAM	2024-02-18
444462	2	2	21	586	110	AWAY_TEAM	2024-02-22
444504	2	2	26	103	450	HOME_TEAM	2024-02-23
444513	2	2	26	471	445	AWAY_TEAM	2024-02-24
444512	2	2	26	455	5911	AWAY_TEAM	2024-02-24
444507	2	2	26	107	115	HOME_TEAM	2024-02-24
444508	2	2	26	109	470	HOME_TEAM	2024-02-25
444505	2	2	26	104	113	DRAW	2024-02-25
444509	2	2	26	5890	108	AWAY_TEAM	2024-02-25
444510	2	2	26	98	102	DRAW	2024-02-25
444511	2	2	26	100	586	HOME_TEAM	2024-02-26
444506	2	2	26	99	110	HOME_TEAM	2024-02-26
444461	2	2	21	471	113	AWAY_TEAM	2024-02-28
444457	2	2	21	108	102	HOME_TEAM	2024-02-28
444519	2	2	27	110	98	AWAY_TEAM	2024-03-01
444523	2	2	27	115	455	DRAW	2024-03-02
444520	2	2	27	5911	100	AWAY_TEAM	2024-03-02
444522	2	2	27	586	99	DRAW	2024-03-02
444517	2	2	27	450	471	HOME_TEAM	2024-03-03
444515	2	2	27	445	104	AWAY_TEAM	2024-03-03
444516	2	2	27	470	5890	DRAW	2024-03-03
444514	2	2	27	102	103	AWAY_TEAM	2024-03-03
444521	2	2	27	113	109	HOME_TEAM	2024-03-03
444518	2	2	27	108	107	HOME_TEAM	2024-03-04
444532	2	2	28	113	586	DRAW	2024-03-08
444525	2	2	28	104	455	HOME_TEAM	2024-03-09
444533	2	2	28	471	470	HOME_TEAM	2024-03-09
444524	2	2	28	103	108	AWAY_TEAM	2024-03-09
444527	2	2	28	107	5911	AWAY_TEAM	2024-03-09
444530	2	2	28	5890	450	AWAY_TEAM	2024-03-10
444531	2	2	28	98	445	HOME_TEAM	2024-03-10
444528	2	2	28	109	102	DRAW	2024-03-10
444526	2	2	28	99	100	DRAW	2024-03-10
444529	2	2	28	110	115	AWAY_TEAM	2024-03-11
444535	2	2	29	445	103	AWAY_TEAM	2024-03-15
444540	2	2	29	5911	104	HOME_TEAM	2024-03-16
444543	2	2	29	115	586	AWAY_TEAM	2024-03-16
444542	2	2	29	455	5890	AWAY_TEAM	2024-03-16
444536	2	2	29	470	110	AWAY_TEAM	2024-03-16
444539	2	2	29	109	107	DRAW	2024-03-17
444537	2	2	29	450	98	AWAY_TEAM	2024-03-17
444541	2	2	29	100	471	HOME_TEAM	2024-03-17
444538	2	2	29	108	113	DRAW	2024-03-17
444551	2	2	30	113	102	AWAY_TEAM	2024-03-30
444547	2	2	30	107	470	DRAW	2024-03-30
444553	2	2	30	586	5911	HOME_TEAM	2024-03-30
444549	2	2	30	110	109	HOME_TEAM	2024-03-30
444546	2	2	30	99	98	AWAY_TEAM	2024-03-30
444544	2	2	30	103	455	HOME_TEAM	2024-04-01
444545	2	2	30	104	450	DRAW	2024-04-01
444552	2	2	30	471	115	DRAW	2024-04-01
444550	2	2	30	5890	100	DRAW	2024-04-01
444548	2	2	30	108	445	HOME_TEAM	2024-04-01
444562	2	2	31	455	471	DRAW	2024-04-05
444559	2	2	31	98	5890	HOME_TEAM	2024-04-06
444561	2	2	31	100	110	HOME_TEAM	2024-04-06
444555	2	2	31	445	586	HOME_TEAM	2024-04-06
444556	2	2	31	470	103	DRAW	2024-04-07
444560	2	2	31	5911	113	AWAY_TEAM	2024-04-07
444554	2	2	31	104	102	HOME_TEAM	2024-04-07
444557	2	2	31	450	107	AWAY_TEAM	2024-04-07
444558	2	2	31	109	99	HOME_TEAM	2024-04-07
444563	2	2	31	115	108	AWAY_TEAM	2024-04-08
444568	2	2	32	110	455	HOME_TEAM	2024-04-12
444569	2	2	32	5890	445	HOME_TEAM	2024-04-13
444572	2	2	32	586	109	DRAW	2024-04-13
444565	2	2	32	103	5911	DRAW	2024-04-13
444570	2	2	32	113	470	DRAW	2024-04-14
444571	2	2	32	471	98	DRAW	2024-04-14
444567	2	2	32	108	104	DRAW	2024-04-14
444566	2	2	32	99	107	DRAW	2024-04-15
444564	2	2	32	102	450	DRAW	2024-04-15
444576	2	2	33	107	110	AWAY_TEAM	2024-04-19
444574	2	2	33	104	109	DRAW	2024-04-19
444575	2	2	33	445	113	HOME_TEAM	2024-04-20
444577	2	2	33	450	115	HOME_TEAM	2024-04-20
444582	2	2	33	471	5890	AWAY_TEAM	2024-04-21
444583	2	2	33	586	470	DRAW	2024-04-21
444581	2	2	33	455	99	AWAY_TEAM	2024-04-21
444579	2	2	33	5911	102	AWAY_TEAM	2024-04-21
444580	2	2	33	100	103	AWAY_TEAM	2024-04-22
444578	2	2	33	98	108	AWAY_TEAM	2024-04-22
444573	2	2	32	115	100	AWAY_TEAM	2024-04-25
444587	2	2	34	470	455	HOME_TEAM	2024-04-26
444592	2	2	34	5890	5911	DRAW	2024-04-27
444590	2	2	34	109	98	DRAW	2024-04-27
444591	2	2	34	110	450	HOME_TEAM	2024-04-27
444589	2	2	34	108	586	HOME_TEAM	2024-04-28
444585	2	2	34	103	115	DRAW	2024-04-28
444584	2	2	34	102	445	HOME_TEAM	2024-04-28
444593	2	2	34	113	100	DRAW	2024-04-28
444586	2	2	34	99	471	HOME_TEAM	2024-04-28
444588	2	2	34	107	104	HOME_TEAM	2024-04-29
444602	2	2	35	586	103	DRAW	2024-05-03
444598	2	2	35	5911	110	DRAW	2024-05-04
444601	2	2	35	471	108	HOME_TEAM	2024-05-04
444594	2	2	35	104	5890	DRAW	2024-05-05
444595	2	2	35	445	470	DRAW	2024-05-05
444596	2	2	35	450	99	HOME_TEAM	2024-05-05
444597	2	2	35	98	107	DRAW	2024-05-05
444599	2	2	35	100	109	DRAW	2024-05-05
444600	2	2	35	455	102	AWAY_TEAM	2024-05-06
444603	2	2	35	115	113	DRAW	2024-05-06
444606	2	2	36	470	108	AWAY_TEAM	2024-05-10
444613	2	2	36	113	103	AWAY_TEAM	2024-05-11
444612	2	2	36	98	104	HOME_TEAM	2024-05-11
444610	2	2	36	110	445	HOME_TEAM	2024-05-12
444607	2	2	36	107	471	HOME_TEAM	2024-05-12
444608	2	2	36	450	586	AWAY_TEAM	2024-05-12
444609	2	2	36	109	455	DRAW	2024-05-12
444604	2	2	36	102	100	HOME_TEAM	2024-05-12
444611	2	2	36	5890	115	AWAY_TEAM	2024-05-13
444605	2	2	36	99	5911	HOME_TEAM	2024-05-13
444615	2	2	37	99	113	DRAW	2024-05-17
444617	2	2	37	5890	102	AWAY_TEAM	2024-05-18
444622	2	2	37	586	98	HOME_TEAM	2024-05-18
444621	2	2	37	471	104	AWAY_TEAM	2024-05-19
444618	2	2	37	5911	470	AWAY_TEAM	2024-05-19
444623	2	2	37	115	445	DRAW	2024-05-19
444616	2	2	37	108	110	DRAW	2024-05-19
444619	2	2	37	100	107	HOME_TEAM	2024-05-19
444620	2	2	37	455	450	AWAY_TEAM	2024-05-20
444614	2	2	37	103	109	DRAW	2024-05-20
444625	2	2	38	104	99	AWAY_TEAM	2024-05-23
444628	2	2	38	107	103	HOME_TEAM	2024-05-24
444630	2	2	38	109	5911	HOME_TEAM	2024-05-25
444632	2	2	38	98	455	DRAW	2024-05-25
444624	2	2	38	102	586	HOME_TEAM	2024-05-26
444633	2	2	38	113	5890	DRAW	2024-05-26
444626	2	2	38	445	100	HOME_TEAM	2024-05-26
444627	2	2	38	470	115	AWAY_TEAM	2024-05-26
444629	2	2	38	450	108	DRAW	2024-05-26
444631	2	2	38	110	471	DRAW	2024-05-26
444534	2	2	29	102	99	AWAY_TEAM	2024-06-02
438482	3	3	1	267	87	AWAY_TEAM	2023-08-11
438479	3	3	1	559	95	AWAY_TEAM	2023-08-11
438481	3	3	1	92	298	DRAW	2023-08-12
438483	3	3	1	275	89	DRAW	2023-08-12
438474	3	3	1	77	86	AWAY_TEAM	2023-08-12
438476	3	3	1	558	79	AWAY_TEAM	2023-08-13
438480	3	3	1	94	90	AWAY_TEAM	2023-08-13
438478	3	3	1	82	81	DRAW	2023-08-13
438477	3	3	1	264	263	HOME_TEAM	2023-08-14
438475	3	3	1	78	83	HOME_TEAM	2023-08-14
438491	3	3	2	89	94	AWAY_TEAM	2023-08-18
438490	3	3	2	95	275	HOME_TEAM	2023-08-18
438492	3	3	2	92	558	DRAW	2023-08-19
438493	3	3	2	267	86	AWAY_TEAM	2023-08-19
438485	3	3	2	79	77	AWAY_TEAM	2023-08-19
438488	3	3	2	298	82	HOME_TEAM	2023-08-20
438487	3	3	2	81	264	HOME_TEAM	2023-08-20
438484	3	3	2	90	78	DRAW	2023-08-20
438486	3	3	2	263	559	HOME_TEAM	2023-08-21
438489	3	3	2	83	87	AWAY_TEAM	2023-08-21
438503	3	3	3	275	92	DRAW	2023-08-25
438495	3	3	3	558	86	AWAY_TEAM	2023-08-25
438496	3	3	3	264	267	DRAW	2023-08-26
438498	3	3	3	83	89	HOME_TEAM	2023-08-26
438499	3	3	3	559	298	AWAY_TEAM	2023-08-26
438501	3	3	3	94	81	AWAY_TEAM	2023-08-27
438500	3	3	3	95	79	AWAY_TEAM	2023-08-27
438494	3	3	3	77	90	HOME_TEAM	2023-08-27
438497	3	3	3	82	263	HOME_TEAM	2023-08-28
438502	3	3	3	87	78	AWAY_TEAM	2023-08-28
438508	3	3	4	264	94	HOME_TEAM	2023-09-01
438513	3	3	4	267	558	AWAY_TEAM	2023-09-01
438512	3	3	4	92	83	HOME_TEAM	2023-09-02
438511	3	3	4	86	82	HOME_TEAM	2023-09-02
438507	3	3	4	263	95	HOME_TEAM	2023-09-02
438505	3	3	4	90	87	HOME_TEAM	2023-09-02
438509	3	3	4	298	275	HOME_TEAM	2023-09-03
438510	3	3	4	89	77	DRAW	2023-09-03
438506	3	3	4	79	81	AWAY_TEAM	2023-09-03
438522	3	3	5	87	263	HOME_TEAM	2023-09-15
438514	3	3	5	77	264	HOME_TEAM	2023-09-16
438520	3	3	5	95	78	HOME_TEAM	2023-09-16
438515	3	3	5	558	89	AWAY_TEAM	2023-09-16
438516	3	3	5	81	90	HOME_TEAM	2023-09-16
438517	3	3	5	82	79	HOME_TEAM	2023-09-17
438521	3	3	5	94	267	HOME_TEAM	2023-09-17
438519	3	3	5	559	275	HOME_TEAM	2023-09-17
438523	3	3	5	86	92	HOME_TEAM	2023-09-17
438518	3	3	5	83	298	AWAY_TEAM	2023-09-18
438527	3	3	6	263	77	AWAY_TEAM	2023-09-22
438529	3	3	6	298	89	HOME_TEAM	2023-09-23
438526	3	3	6	79	559	DRAW	2023-09-23
438528	3	3	6	81	558	HOME_TEAM	2023-09-23
438532	3	3	6	267	95	DRAW	2023-09-23
438531	3	3	6	92	82	HOME_TEAM	2023-09-24
438530	3	3	6	87	94	DRAW	2023-09-24
438533	3	3	6	275	83	HOME_TEAM	2023-09-24
438525	3	3	6	90	264	DRAW	2023-09-24
438524	3	3	6	78	86	HOME_TEAM	2023-09-24
438539	3	3	7	559	267	HOME_TEAM	2023-09-26
438542	3	3	7	89	81	DRAW	2023-09-26
438534	3	3	7	77	82	DRAW	2023-09-27
438541	3	3	7	94	298	AWAY_TEAM	2023-09-27
438543	3	3	7	86	275	HOME_TEAM	2023-09-27
438537	3	3	7	264	87	DRAW	2023-09-27
438540	3	3	7	95	92	AWAY_TEAM	2023-09-27
438536	3	3	7	558	263	DRAW	2023-09-28
438538	3	3	7	83	90	DRAW	2023-09-28
438535	3	3	7	79	78	AWAY_TEAM	2023-09-28
438547	3	3	8	81	559	HOME_TEAM	2023-09-29
438548	3	3	8	82	94	DRAW	2023-09-30
438550	3	3	8	87	89	DRAW	2023-09-30
438549	3	3	8	298	86	AWAY_TEAM	2023-09-30
438551	3	3	8	92	77	HOME_TEAM	2023-09-30
438552	3	3	8	267	83	DRAW	2023-10-01
438546	3	3	8	263	79	AWAY_TEAM	2023-10-01
438544	3	3	8	78	264	HOME_TEAM	2023-10-01
438545	3	3	8	90	95	HOME_TEAM	2023-10-01
438553	3	3	8	275	558	HOME_TEAM	2023-10-02
438554	3	3	9	77	267	HOME_TEAM	2023-10-06
438558	3	3	9	264	298	AWAY_TEAM	2023-10-07
438563	3	3	9	86	79	HOME_TEAM	2023-10-07
438562	3	3	9	89	95	DRAW	2023-10-07
438560	3	3	9	559	87	DRAW	2023-10-07
438561	3	3	9	94	275	AWAY_TEAM	2023-10-08
438555	3	3	9	78	92	HOME_TEAM	2023-10-08
438556	3	3	9	558	82	DRAW	2023-10-08
438557	3	3	9	263	90	DRAW	2023-10-08
438559	3	3	9	83	81	DRAW	2023-10-08
438564	3	3	10	79	83	HOME_TEAM	2023-10-20
438572	3	3	10	92	89	HOME_TEAM	2023-10-21
438567	3	3	10	82	90	DRAW	2023-10-21
438569	3	3	10	559	86	DRAW	2023-10-21
438565	3	3	10	558	78	AWAY_TEAM	2023-10-21
438573	3	3	10	275	87	AWAY_TEAM	2023-10-22
438568	3	3	10	298	267	HOME_TEAM	2023-10-22
438571	3	3	10	94	263	DRAW	2023-10-22
438566	3	3	10	81	77	HOME_TEAM	2023-10-22
438570	3	3	10	95	264	HOME_TEAM	2023-10-23
438579	3	3	11	298	558	HOME_TEAM	2023-10-27
438583	3	3	11	267	275	AWAY_TEAM	2023-10-28
438577	3	3	11	81	86	AWAY_TEAM	2023-10-28
438582	3	3	11	89	82	DRAW	2023-10-28
438578	3	3	11	264	559	DRAW	2023-10-28
438576	3	3	11	90	79	HOME_TEAM	2023-10-29
438581	3	3	11	87	92	DRAW	2023-10-29
438574	3	3	11	77	95	DRAW	2023-10-29
438575	3	3	11	78	263	HOME_TEAM	2023-10-29
438580	3	3	11	83	94	AWAY_TEAM	2023-10-30
438593	3	3	12	275	78	HOME_TEAM	2023-11-03
438585	3	3	12	79	298	AWAY_TEAM	2023-11-04
438584	3	3	12	90	89	HOME_TEAM	2023-11-04
438586	3	3	12	558	559	DRAW	2023-11-04
438592	3	3	12	92	81	AWAY_TEAM	2023-11-04
438587	3	3	12	263	267	HOME_TEAM	2023-11-05
438589	3	3	12	95	83	HOME_TEAM	2023-11-05
438590	3	3	12	94	77	AWAY_TEAM	2023-11-05
438591	3	3	12	86	87	DRAW	2023-11-05
438588	3	3	12	82	264	HOME_TEAM	2023-11-06
438594	3	3	13	77	558	HOME_TEAM	2023-11-10
438600	3	3	13	87	298	AWAY_TEAM	2023-11-11
438603	3	3	13	267	92	AWAY_TEAM	2023-11-11
438596	3	3	13	79	275	DRAW	2023-11-11
438598	3	3	13	83	82	DRAW	2023-11-11
438602	3	3	13	86	95	HOME_TEAM	2023-11-11
438597	3	3	13	81	263	HOME_TEAM	2023-11-12
438599	3	3	13	559	90	DRAW	2023-11-12
438595	3	3	13	78	94	HOME_TEAM	2023-11-12
438606	3	3	14	263	83	HOME_TEAM	2023-11-24
438612	3	3	14	87	81	DRAW	2023-11-25
438610	3	3	14	95	558	DRAW	2023-11-25
438608	3	3	14	82	267	HOME_TEAM	2023-11-25
438604	3	3	14	78	89	HOME_TEAM	2023-11-25
438611	3	3	14	94	79	HOME_TEAM	2023-11-26
438613	3	3	14	92	559	HOME_TEAM	2023-11-26
438607	3	3	14	264	86	AWAY_TEAM	2023-11-26
438605	3	3	14	90	275	HOME_TEAM	2023-11-26
438609	3	3	14	298	77	DRAW	2023-11-27
438601	3	3	13	89	264	DRAW	2023-11-29
438623	3	3	15	275	82	HOME_TEAM	2023-12-01
438618	3	3	15	298	95	HOME_TEAM	2023-12-02
438614	3	3	15	77	87	HOME_TEAM	2023-12-02
438621	3	3	15	86	83	HOME_TEAM	2023-12-02
438615	3	3	15	79	92	DRAW	2023-12-02
438620	3	3	15	89	263	DRAW	2023-12-03
438622	3	3	15	267	90	DRAW	2023-12-03
438619	3	3	15	559	94	DRAW	2023-12-03
438617	3	3	15	81	78	HOME_TEAM	2023-12-03
438616	3	3	15	558	264	DRAW	2023-12-04
438629	3	3	16	82	95	HOME_TEAM	2023-12-08
438626	3	3	16	263	275	AWAY_TEAM	2023-12-09
438625	3	3	16	90	86	DRAW	2023-12-09
438631	3	3	16	94	92	AWAY_TEAM	2023-12-09
438633	3	3	16	89	559	HOME_TEAM	2023-12-09
438624	3	3	16	78	267	HOME_TEAM	2023-12-10
438628	3	3	16	264	79	DRAW	2023-12-10
438627	3	3	16	81	298	AWAY_TEAM	2023-12-10
438630	3	3	16	83	77	DRAW	2023-12-11
438632	3	3	16	87	558	DRAW	2023-12-11
438635	3	3	17	79	87	HOME_TEAM	2023-12-15
438636	3	3	17	558	83	HOME_TEAM	2023-12-16
438634	3	3	17	77	78	HOME_TEAM	2023-12-16
438638	3	3	17	559	82	AWAY_TEAM	2023-12-16
438639	3	3	17	95	81	DRAW	2023-12-16
438642	3	3	17	267	89	DRAW	2023-12-17
438641	3	3	17	92	90	DRAW	2023-12-17
438643	3	3	17	275	264	DRAW	2023-12-17
438640	3	3	17	86	94	HOME_TEAM	2023-12-17
438637	3	3	17	298	263	HOME_TEAM	2023-12-18
438652	3	3	18	87	95	AWAY_TEAM	2023-12-19
438645	3	3	18	78	82	DRAW	2023-12-19
438650	3	3	18	83	559	AWAY_TEAM	2023-12-19
438648	3	3	18	81	267	HOME_TEAM	2023-12-20
438644	3	3	18	77	275	HOME_TEAM	2023-12-20
438651	3	3	18	94	558	HOME_TEAM	2023-12-20
438646	3	3	18	90	298	DRAW	2023-12-21
438649	3	3	18	264	92	DRAW	2023-12-21
438647	3	3	18	263	86	AWAY_TEAM	2023-12-21
438653	3	3	18	89	79	HOME_TEAM	2023-12-21
438504	3	3	4	78	559	HOME_TEAM	2023-12-23
438656	3	3	19	82	87	AWAY_TEAM	2024-01-02
438662	3	3	19	92	263	DRAW	2024-01-02
438660	3	3	19	95	94	HOME_TEAM	2024-01-02
438658	3	3	19	83	264	HOME_TEAM	2024-01-03
438655	3	3	19	558	90	HOME_TEAM	2024-01-03
438661	3	3	19	86	89	HOME_TEAM	2024-01-03
438657	3	3	19	298	78	HOME_TEAM	2024-01-03
438654	3	3	19	79	267	HOME_TEAM	2024-01-04
438659	3	3	19	559	77	AWAY_TEAM	2024-01-04
438663	3	3	19	275	81	AWAY_TEAM	2024-01-04
438670	3	3	20	559	263	AWAY_TEAM	2024-01-12
438673	3	3	20	275	94	HOME_TEAM	2024-01-13
438671	3	3	20	89	558	DRAW	2024-01-13
438664	3	3	20	77	92	HOME_TEAM	2024-01-13
438666	3	3	20	90	83	HOME_TEAM	2024-01-13
438672	3	3	20	267	298	DRAW	2024-01-14
438668	3	3	20	264	95	AWAY_TEAM	2024-01-14
438677	3	3	21	263	264	HOME_TEAM	2024-01-19
438682	3	3	21	87	275	AWAY_TEAM	2024-01-20
438681	3	3	21	94	89	DRAW	2024-01-20
438680	3	3	21	95	77	HOME_TEAM	2024-01-20
438676	3	3	21	558	92	AWAY_TEAM	2024-01-20
438675	3	3	21	79	82	HOME_TEAM	2024-01-21
438683	3	3	21	86	267	HOME_TEAM	2024-01-21
438674	3	3	21	90	81	AWAY_TEAM	2024-01-21
438678	3	3	21	298	559	HOME_TEAM	2024-01-21
438679	3	3	21	83	78	AWAY_TEAM	2024-01-22
438692	3	3	22	267	263	AWAY_TEAM	2024-01-26
438691	3	3	22	92	87	DRAW	2024-01-27
438693	3	3	22	275	86	AWAY_TEAM	2024-01-27
438686	3	3	22	81	94	AWAY_TEAM	2024-01-27
438690	3	3	22	89	90	AWAY_TEAM	2024-01-27
438685	3	3	22	558	298	AWAY_TEAM	2024-01-28
438687	3	3	22	264	77	DRAW	2024-01-28
438689	3	3	22	559	79	DRAW	2024-01-28
438684	3	3	22	78	95	HOME_TEAM	2024-01-28
438688	3	3	22	82	83	HOME_TEAM	2024-01-29
438667	3	3	20	81	79	HOME_TEAM	2024-01-31
438665	3	3	20	78	87	HOME_TEAM	2024-01-31
438669	3	3	20	82	86	AWAY_TEAM	2024-02-01
438694	3	3	23	77	89	HOME_TEAM	2024-02-02
438700	3	3	23	95	267	HOME_TEAM	2024-02-03
438699	3	3	23	83	275	DRAW	2024-02-03
438697	3	3	23	263	81	AWAY_TEAM	2024-02-03
438698	3	3	23	298	92	DRAW	2024-02-03
438701	3	3	23	94	264	DRAW	2024-02-04
438696	3	3	23	79	558	AWAY_TEAM	2024-02-04
438695	3	3	23	90	82	DRAW	2024-02-04
438703	3	3	23	86	78	DRAW	2024-02-04
438702	3	3	23	87	559	AWAY_TEAM	2024-02-05
438706	3	3	24	264	90	AWAY_TEAM	2024-02-09
438704	3	3	24	263	94	DRAW	2024-02-10
438711	3	3	24	92	79	AWAY_TEAM	2024-02-10
438710	3	3	24	86	298	HOME_TEAM	2024-02-10
438713	3	3	24	275	95	HOME_TEAM	2024-02-10
438707	3	3	24	82	558	HOME_TEAM	2024-02-11
438709	3	3	24	89	87	HOME_TEAM	2024-02-11
438708	3	3	24	559	78	HOME_TEAM	2024-02-11
438705	3	3	24	81	83	DRAW	2024-02-11
438712	3	3	24	267	77	DRAW	2024-02-12
438721	3	3	25	94	82	DRAW	2024-02-16
438715	3	3	25	78	275	HOME_TEAM	2024-02-17
438717	3	3	25	79	264	HOME_TEAM	2024-02-17
438718	3	3	25	558	81	AWAY_TEAM	2024-02-17
438720	3	3	25	95	559	DRAW	2024-02-17
438722	3	3	25	87	86	DRAW	2024-02-18
438719	3	3	25	83	267	DRAW	2024-02-18
438723	3	3	25	89	92	AWAY_TEAM	2024-02-18
438716	3	3	25	90	263	DRAW	2024-02-18
438714	3	3	25	77	298	HOME_TEAM	2024-02-19
438731	3	3	26	92	94	AWAY_TEAM	2024-02-23
438726	3	3	26	81	82	HOME_TEAM	2024-02-24
438725	3	3	26	263	89	DRAW	2024-02-24
438732	3	3	26	267	78	DRAW	2024-02-24
438727	3	3	26	264	558	DRAW	2024-02-25
438724	3	3	26	90	77	HOME_TEAM	2024-02-25
438733	3	3	26	275	79	DRAW	2024-02-25
438730	3	3	26	86	559	HOME_TEAM	2024-02-25
438728	3	3	26	298	87	HOME_TEAM	2024-02-26
438737	3	3	27	558	267	HOME_TEAM	2024-03-01
438739	3	3	27	559	92	HOME_TEAM	2024-03-02
438742	3	3	27	87	264	DRAW	2024-03-02
438738	3	3	27	82	275	DRAW	2024-03-02
438740	3	3	27	95	86	DRAW	2024-03-02
438741	3	3	27	94	83	HOME_TEAM	2024-03-03
438735	3	3	27	78	90	HOME_TEAM	2024-03-03
438743	3	3	27	89	298	HOME_TEAM	2024-03-03
438734	3	3	27	77	81	DRAW	2024-03-03
438736	3	3	27	79	263	HOME_TEAM	2024-03-04
438746	3	3	28	81	89	HOME_TEAM	2024-03-08
438750	3	3	28	95	82	HOME_TEAM	2024-03-09
438747	3	3	28	264	78	HOME_TEAM	2024-03-09
438749	3	3	28	83	92	AWAY_TEAM	2024-03-09
438748	3	3	28	298	79	HOME_TEAM	2024-03-09
438745	3	3	28	263	87	HOME_TEAM	2024-03-10
438753	3	3	28	275	77	AWAY_TEAM	2024-03-10
438751	3	3	28	86	558	HOME_TEAM	2024-03-10
438744	3	3	28	90	94	AWAY_TEAM	2024-03-10
438752	3	3	28	267	559	DRAW	2024-03-11
438762	3	3	29	92	264	HOME_TEAM	2024-03-15
438761	3	3	29	89	83	HOME_TEAM	2024-03-16
438756	3	3	29	79	86	AWAY_TEAM	2024-03-16
438757	3	3	29	82	298	HOME_TEAM	2024-03-16
438754	3	3	29	77	263	HOME_TEAM	2024-03-16
438758	3	3	29	559	558	AWAY_TEAM	2024-03-17
438759	3	3	29	94	95	HOME_TEAM	2024-03-17
438763	3	3	29	275	267	AWAY_TEAM	2024-03-17
438760	3	3	29	87	90	HOME_TEAM	2024-03-17
438755	3	3	29	78	81	AWAY_TEAM	2024-03-17
438767	3	3	30	264	83	HOME_TEAM	2024-03-29
438768	3	3	30	82	559	AWAY_TEAM	2024-03-30
438773	3	3	30	267	79	AWAY_TEAM	2024-03-30
438770	3	3	30	95	89	DRAW	2024-03-30
438766	3	3	30	81	275	HOME_TEAM	2024-03-30
438764	3	3	30	558	87	DRAW	2024-03-31
438769	3	3	30	298	90	HOME_TEAM	2024-03-31
438765	3	3	30	263	92	AWAY_TEAM	2024-03-31
438772	3	3	30	86	77	HOME_TEAM	2024-03-31
438771	3	3	30	94	78	AWAY_TEAM	2024-04-01
438729	3	3	26	83	95	AWAY_TEAM	2024-04-04
438776	3	3	31	90	558	HOME_TEAM	2024-04-12
438775	3	3	31	78	298	HOME_TEAM	2024-04-13
438780	3	3	31	87	82	DRAW	2024-04-13
438781	3	3	31	89	86	AWAY_TEAM	2024-04-13
438778	3	3	31	264	81	AWAY_TEAM	2024-04-13
438783	3	3	31	275	559	AWAY_TEAM	2024-04-14
438779	3	3	31	83	263	HOME_TEAM	2024-04-14
438774	3	3	31	77	94	DRAW	2024-04-14
438782	3	3	31	92	267	DRAW	2024-04-14
438777	3	3	31	79	95	AWAY_TEAM	2024-04-15
438784	3	3	32	77	83	DRAW	2024-04-19
438785	3	3	32	558	275	HOME_TEAM	2024-04-20
438791	3	3	32	87	79	HOME_TEAM	2024-04-20
438790	3	3	32	95	90	AWAY_TEAM	2024-04-20
438788	3	3	32	298	264	HOME_TEAM	2024-04-20
438787	3	3	32	82	92	DRAW	2024-04-21
438793	3	3	32	267	94	AWAY_TEAM	2024-04-21
438786	3	3	32	263	78	HOME_TEAM	2024-04-21
438792	3	3	32	86	81	HOME_TEAM	2024-04-21
438789	3	3	32	559	89	HOME_TEAM	2024-04-22
438801	3	3	33	92	86	AWAY_TEAM	2024-04-26
438803	3	3	33	275	298	AWAY_TEAM	2024-04-27
438802	3	3	33	267	82	AWAY_TEAM	2024-04-27
438796	3	3	33	263	558	HOME_TEAM	2024-04-27
438794	3	3	33	78	77	HOME_TEAM	2024-04-27
438798	3	3	33	264	89	DRAW	2024-04-28
438799	3	3	33	83	79	HOME_TEAM	2024-04-28
438800	3	3	33	94	87	HOME_TEAM	2024-04-28
438795	3	3	33	90	559	DRAW	2024-04-28
438797	3	3	33	81	95	HOME_TEAM	2024-04-29
438806	3	3	34	82	77	AWAY_TEAM	2024-05-03
438813	3	3	34	92	275	HOME_TEAM	2024-05-04
438812	3	3	34	86	264	HOME_TEAM	2024-05-04
438807	3	3	34	298	81	HOME_TEAM	2024-05-04
438811	3	3	34	89	78	AWAY_TEAM	2024-05-04
438804	3	3	34	79	90	AWAY_TEAM	2024-05-05
438805	3	3	34	558	94	HOME_TEAM	2024-05-05
438809	3	3	34	95	263	AWAY_TEAM	2024-05-05
438808	3	3	34	559	83	HOME_TEAM	2024-05-05
438810	3	3	34	87	267	AWAY_TEAM	2024-05-05
438817	3	3	35	263	298	DRAW	2024-05-10
438823	3	3	35	89	275	HOME_TEAM	2024-05-11
438822	3	3	35	94	559	HOME_TEAM	2024-05-11
438820	3	3	35	83	86	AWAY_TEAM	2024-05-11
438814	3	3	35	77	79	DRAW	2024-05-11
438819	3	3	35	264	82	HOME_TEAM	2024-05-12
438815	3	3	35	78	558	HOME_TEAM	2024-05-12
438821	3	3	35	95	87	DRAW	2024-05-12
438816	3	3	35	90	267	HOME_TEAM	2024-05-12
438818	3	3	35	81	92	HOME_TEAM	2024-05-13
438824	3	3	36	79	89	DRAW	2024-05-14
438830	3	3	36	86	263	HOME_TEAM	2024-05-14
438827	3	3	36	298	94	AWAY_TEAM	2024-05-14
438828	3	3	36	559	264	AWAY_TEAM	2024-05-15
438829	3	3	36	87	83	HOME_TEAM	2024-05-15
438825	3	3	36	558	77	HOME_TEAM	2024-05-15
438826	3	3	36	82	78	AWAY_TEAM	2024-05-15
438833	3	3	36	275	90	DRAW	2024-05-16
438832	3	3	36	267	81	AWAY_TEAM	2024-05-16
438831	3	3	36	92	95	HOME_TEAM	2024-05-16
438837	3	3	37	263	82	HOME_TEAM	2024-05-18
438834	3	3	37	77	559	HOME_TEAM	2024-05-19
438835	3	3	37	78	79	AWAY_TEAM	2024-05-19
438836	3	3	37	90	92	AWAY_TEAM	2024-05-19
438838	3	3	37	81	87	HOME_TEAM	2024-05-19
438839	3	3	37	264	275	DRAW	2024-05-19
438840	3	3	37	83	558	AWAY_TEAM	2024-05-19
438841	3	3	37	95	298	AWAY_TEAM	2024-05-19
438842	3	3	37	94	86	DRAW	2024-05-19
438843	3	3	37	89	267	DRAW	2024-05-19
438847	3	3	38	298	83	HOME_TEAM	2024-05-24
438844	3	3	38	79	94	DRAW	2024-05-25
438851	3	3	38	92	78	AWAY_TEAM	2024-05-25
438849	3	3	38	87	77	AWAY_TEAM	2024-05-25
438852	3	3	38	267	264	HOME_TEAM	2024-05-25
438850	3	3	38	86	90	DRAW	2024-05-25
438846	3	3	38	82	89	AWAY_TEAM	2024-05-26
438845	3	3	38	558	95	DRAW	2024-05-26
438853	3	3	38	275	263	DRAW	2024-05-26
438848	3	3	38	559	81	AWAY_TEAM	2024-05-26
441789	4	4	1	12	5	AWAY_TEAM	2023-08-18
441792	4	4	1	3	721	HOME_TEAM	2023-08-19
441794	4	4	1	11	44	HOME_TEAM	2023-08-19
441795	4	4	1	2	17	AWAY_TEAM	2023-08-19
441796	4	4	1	16	18	DRAW	2023-08-19
441797	4	4	1	10	36	HOME_TEAM	2023-08-19
441790	4	4	1	4	1	HOME_TEAM	2023-08-19
441791	4	4	1	28	15	HOME_TEAM	2023-08-20
441793	4	4	1	19	55	HOME_TEAM	2023-08-20
441799	4	4	2	721	10	HOME_TEAM	2023-08-25
441800	4	4	2	17	12	HOME_TEAM	2023-08-26
441803	4	4	2	1	11	AWAY_TEAM	2023-08-26
441804	4	4	2	36	4	DRAW	2023-08-26
441805	4	4	2	44	2	AWAY_TEAM	2023-08-26
441806	4	4	2	55	28	AWAY_TEAM	2023-08-26
441802	4	4	2	18	3	AWAY_TEAM	2023-08-26
441801	4	4	2	15	19	DRAW	2023-08-27
441798	4	4	2	5	16	HOME_TEAM	2023-08-27
441807	4	4	3	4	44	DRAW	2023-09-01
441809	4	4	3	3	55	HOME_TEAM	2023-09-02
441812	4	4	3	2	11	HOME_TEAM	2023-09-02
441813	4	4	3	12	15	HOME_TEAM	2023-09-02
441814	4	4	3	16	36	DRAW	2023-09-02
441815	4	4	3	10	17	HOME_TEAM	2023-09-02
441811	4	4	3	18	5	AWAY_TEAM	2023-09-02
441810	4	4	3	19	1	DRAW	2023-09-03
441808	4	4	3	28	721	AWAY_TEAM	2023-09-03
441816	4	4	4	5	3	DRAW	2023-09-15
441817	4	4	4	721	16	HOME_TEAM	2023-09-16
441818	4	4	4	17	4	AWAY_TEAM	2023-09-16
441819	4	4	4	11	28	HOME_TEAM	2023-09-16
441820	4	4	4	15	10	AWAY_TEAM	2023-09-16
441821	4	4	4	1	2	AWAY_TEAM	2023-09-16
441822	4	4	4	36	19	DRAW	2023-09-16
441823	4	4	4	44	12	HOME_TEAM	2023-09-17
441824	4	4	4	55	18	DRAW	2023-09-17
441833	4	4	5	10	55	HOME_TEAM	2023-09-22
441825	4	4	5	5	36	HOME_TEAM	2023-09-23
441826	4	4	5	4	11	HOME_TEAM	2023-09-23
441827	4	4	5	28	2	AWAY_TEAM	2023-09-23
441830	4	4	5	18	721	AWAY_TEAM	2023-09-23
441832	4	4	5	16	15	HOME_TEAM	2023-09-23
441831	4	4	5	12	1	HOME_TEAM	2023-09-23
441828	4	4	5	3	44	HOME_TEAM	2023-09-24
441829	4	4	5	19	17	DRAW	2023-09-24
441839	4	4	6	2	4	AWAY_TEAM	2023-09-29
441836	4	4	6	11	19	HOME_TEAM	2023-09-30
441837	4	4	6	15	3	AWAY_TEAM	2023-09-30
441838	4	4	6	1	10	AWAY_TEAM	2023-09-30
441840	4	4	6	36	18	AWAY_TEAM	2023-09-30
441841	4	4	6	44	28	HOME_TEAM	2023-09-30
441834	4	4	6	721	5	DRAW	2023-09-30
441842	4	4	6	55	12	HOME_TEAM	2023-10-01
441835	4	4	6	17	16	HOME_TEAM	2023-10-01
441848	4	4	7	18	15	DRAW	2023-10-06
441844	4	4	7	4	28	HOME_TEAM	2023-10-07
441845	4	4	7	721	36	DRAW	2023-10-07
441850	4	4	7	16	55	AWAY_TEAM	2023-10-07
441851	4	4	7	10	11	HOME_TEAM	2023-10-07
441849	4	4	7	12	2	AWAY_TEAM	2023-10-07
441846	4	4	7	3	1	HOME_TEAM	2023-10-08
441843	4	4	7	5	17	HOME_TEAM	2023-10-08
441847	4	4	7	19	44	HOME_TEAM	2023-10-08
441852	4	4	8	4	12	HOME_TEAM	2023-10-20
441858	4	4	8	2	19	AWAY_TEAM	2023-10-21
441860	4	4	8	55	721	AWAY_TEAM	2023-10-21
441853	4	4	8	28	10	AWAY_TEAM	2023-10-21
441854	4	4	8	17	36	HOME_TEAM	2023-10-21
441855	4	4	8	11	3	AWAY_TEAM	2023-10-21
441856	4	4	8	15	5	AWAY_TEAM	2023-10-21
441857	4	4	8	1	18	HOME_TEAM	2023-10-22
441859	4	4	8	44	16	AWAY_TEAM	2023-10-22
441867	4	4	9	36	15	DRAW	2023-10-27
441861	4	4	9	5	55	HOME_TEAM	2023-10-28
441865	4	4	9	18	44	HOME_TEAM	2023-10-28
441866	4	4	9	12	28	HOME_TEAM	2023-10-28
441868	4	4	9	16	11	HOME_TEAM	2023-10-28
441869	4	4	9	10	2	AWAY_TEAM	2023-10-28
441862	4	4	9	721	1	HOME_TEAM	2023-10-28
441864	4	4	9	19	4	DRAW	2023-10-29
441863	4	4	9	3	17	HOME_TEAM	2023-10-29
441878	4	4	10	55	36	AWAY_TEAM	2023-11-03
441871	4	4	10	28	19	AWAY_TEAM	2023-11-04
441872	4	4	10	17	18	DRAW	2023-11-04
441874	4	4	10	15	721	HOME_TEAM	2023-11-04
441875	4	4	10	1	16	DRAW	2023-11-04
441876	4	4	10	2	3	AWAY_TEAM	2023-11-04
441870	4	4	10	4	5	AWAY_TEAM	2023-11-04
441873	4	4	10	11	12	DRAW	2023-11-05
441877	4	4	10	44	10	HOME_TEAM	2023-11-05
441882	4	4	11	18	11	HOME_TEAM	2023-11-10
441879	4	4	11	5	44	HOME_TEAM	2023-11-11
441885	4	4	11	16	2	DRAW	2023-11-11
441886	4	4	11	10	4	HOME_TEAM	2023-11-11
441887	4	4	11	55	15	DRAW	2023-11-11
441884	4	4	11	36	1	DRAW	2023-11-11
441881	4	4	11	3	28	HOME_TEAM	2023-11-12
441883	4	4	11	12	19	DRAW	2023-11-12
441880	4	4	11	721	17	HOME_TEAM	2023-11-12
441893	4	4	12	1	5	AWAY_TEAM	2023-11-24
441888	4	4	12	4	18	HOME_TEAM	2023-11-25
441889	4	4	12	28	16	DRAW	2023-11-25
441890	4	4	12	17	55	DRAW	2023-11-25
441892	4	4	12	11	721	HOME_TEAM	2023-11-25
441895	4	4	12	12	3	AWAY_TEAM	2023-11-25
441891	4	4	12	19	10	AWAY_TEAM	2023-11-25
441896	4	4	12	44	36	DRAW	2023-11-26
441894	4	4	12	2	15	DRAW	2023-11-26
441905	4	4	13	55	1	AWAY_TEAM	2023-12-01
441898	4	4	13	721	44	HOME_TEAM	2023-12-02
441901	4	4	13	18	2	HOME_TEAM	2023-12-02
441902	4	4	13	36	11	HOME_TEAM	2023-12-02
441904	4	4	13	10	12	HOME_TEAM	2023-12-02
441900	4	4	13	15	17	AWAY_TEAM	2023-12-03
441899	4	4	13	3	4	DRAW	2023-12-03
441903	4	4	13	16	19	HOME_TEAM	2023-12-03
441911	4	4	14	2	36	HOME_TEAM	2023-12-08
441907	4	4	14	28	18	HOME_TEAM	2023-12-09
441908	4	4	14	19	5	HOME_TEAM	2023-12-09
441909	4	4	14	11	17	AWAY_TEAM	2023-12-09
441912	4	4	14	12	16	HOME_TEAM	2023-12-09
441914	4	4	14	44	55	HOME_TEAM	2023-12-09
441906	4	4	14	4	721	AWAY_TEAM	2023-12-09
441913	4	4	14	10	3	DRAW	2023-12-10
441910	4	4	14	1	15	DRAW	2023-12-10
441920	4	4	15	18	12	DRAW	2023-12-15
441919	4	4	15	15	44	AWAY_TEAM	2023-12-16
441921	4	4	15	36	28	HOME_TEAM	2023-12-16
441922	4	4	15	16	4	DRAW	2023-12-16
441923	4	4	15	55	11	AWAY_TEAM	2023-12-16
441916	4	4	15	721	2	HOME_TEAM	2023-12-16
441917	4	4	15	17	1	HOME_TEAM	2023-12-17
441918	4	4	15	3	19	HOME_TEAM	2023-12-17
441915	4	4	15	5	10	HOME_TEAM	2023-12-17
441930	4	4	16	12	721	DRAW	2023-12-19
441924	4	4	16	4	15	DRAW	2023-12-19
441929	4	4	16	2	55	DRAW	2023-12-19
441925	4	4	16	28	1	HOME_TEAM	2023-12-20
441926	4	4	16	3	36	HOME_TEAM	2023-12-20
441927	4	4	16	19	18	HOME_TEAM	2023-12-20
441928	4	4	16	11	5	AWAY_TEAM	2023-12-20
441931	4	4	16	10	16	HOME_TEAM	2023-12-20
441932	4	4	16	44	17	HOME_TEAM	2023-12-20
441933	4	4	17	5	2	HOME_TEAM	2024-01-12
441934	4	4	17	721	19	AWAY_TEAM	2024-01-13
441935	4	4	17	17	28	DRAW	2024-01-13
441936	4	4	17	15	11	DRAW	2024-01-13
441938	4	4	17	1	44	DRAW	2024-01-13
441940	4	4	17	16	3	AWAY_TEAM	2024-01-13
441941	4	4	17	55	4	AWAY_TEAM	2024-01-13
441939	4	4	17	36	12	DRAW	2024-01-14
441937	4	4	17	18	10	HOME_TEAM	2024-01-14
441943	4	4	18	1	4	AWAY_TEAM	2024-01-20
441946	4	4	18	55	19	DRAW	2024-01-20
441947	4	4	18	44	11	DRAW	2024-01-20
441948	4	4	18	17	2	HOME_TEAM	2024-01-20
441950	4	4	18	36	10	HOME_TEAM	2024-01-20
441945	4	4	18	721	3	AWAY_TEAM	2024-01-20
441942	4	4	18	5	12	AWAY_TEAM	2024-01-21
441949	4	4	18	18	16	AWAY_TEAM	2024-01-21
441897	4	4	13	5	28	HOME_TEAM	2024-01-24
441954	4	4	19	19	15	HOME_TEAM	2024-01-26
441951	4	4	19	16	5	AWAY_TEAM	2024-01-27
441952	4	4	19	10	721	HOME_TEAM	2024-01-27
441953	4	4	19	12	17	HOME_TEAM	2024-01-27
441956	4	4	19	11	1	DRAW	2024-01-27
441958	4	4	19	2	44	DRAW	2024-01-27
441955	4	4	19	3	18	DRAW	2024-01-27
441959	4	4	19	28	55	HOME_TEAM	2024-01-28
441957	4	4	19	4	36	HOME_TEAM	2024-01-28
441960	4	4	20	44	4	DRAW	2024-02-02
441962	4	4	20	55	3	AWAY_TEAM	2024-02-03
441964	4	4	20	5	18	HOME_TEAM	2024-02-03
441966	4	4	20	15	12	AWAY_TEAM	2024-02-03
441967	4	4	20	36	16	DRAW	2024-02-03
441968	4	4	20	17	10	AWAY_TEAM	2024-02-03
441963	4	4	20	1	19	HOME_TEAM	2024-02-03
441965	4	4	20	11	2	DRAW	2024-02-04
441961	4	4	20	721	28	HOME_TEAM	2024-02-04
441944	4	4	18	15	28	DRAW	2024-02-07
441971	4	4	21	4	17	HOME_TEAM	2024-02-09
441970	4	4	21	16	721	DRAW	2024-02-10
441972	4	4	21	28	11	HOME_TEAM	2024-02-10
441975	4	4	21	19	36	DRAW	2024-02-10
441976	4	4	21	12	44	AWAY_TEAM	2024-02-10
441977	4	4	21	18	55	DRAW	2024-02-10
441969	4	4	21	3	5	HOME_TEAM	2024-02-10
441973	4	4	21	10	15	HOME_TEAM	2024-02-11
441974	4	4	21	2	1	DRAW	2024-02-11
441984	4	4	22	1	12	AWAY_TEAM	2024-02-16
441979	4	4	22	11	4	DRAW	2024-02-17
441980	4	4	22	2	28	AWAY_TEAM	2024-02-17
441981	4	4	22	44	3	AWAY_TEAM	2024-02-17
441985	4	4	22	15	16	HOME_TEAM	2024-02-17
441986	4	4	22	55	10	AWAY_TEAM	2024-02-17
441983	4	4	22	721	18	HOME_TEAM	2024-02-17
441982	4	4	22	17	19	DRAW	2024-02-18
441978	4	4	22	36	5	HOME_TEAM	2024-02-18
441990	4	4	23	3	15	HOME_TEAM	2024-02-23
441991	4	4	23	10	1	DRAW	2024-02-24
441994	4	4	23	28	44	DRAW	2024-02-24
441995	4	4	23	12	55	DRAW	2024-02-24
441993	4	4	23	18	36	HOME_TEAM	2024-02-24
441987	4	4	23	5	721	HOME_TEAM	2024-02-24
441989	4	4	23	19	11	DRAW	2024-02-25
441992	4	4	23	4	2	AWAY_TEAM	2024-02-25
441988	4	4	23	16	17	HOME_TEAM	2024-02-25
441996	4	4	24	17	5	DRAW	2024-03-01
441997	4	4	24	28	4	AWAY_TEAM	2024-03-02
441998	4	4	24	36	721	AWAY_TEAM	2024-03-02
442000	4	4	24	44	19	AWAY_TEAM	2024-03-02
442001	4	4	24	15	18	DRAW	2024-03-02
442003	4	4	24	55	16	AWAY_TEAM	2024-03-02
442004	4	4	24	11	10	AWAY_TEAM	2024-03-02
441999	4	4	24	1	3	AWAY_TEAM	2024-03-03
442002	4	4	24	2	12	HOME_TEAM	2024-03-03
442006	4	4	25	10	28	HOME_TEAM	2024-03-08
442009	4	4	25	5	15	HOME_TEAM	2024-03-09
442010	4	4	25	18	1	DRAW	2024-03-09
442012	4	4	25	16	44	HOME_TEAM	2024-03-09
442013	4	4	25	721	55	HOME_TEAM	2024-03-09
442005	4	4	25	12	4	AWAY_TEAM	2024-03-09
442007	4	4	25	36	17	AWAY_TEAM	2024-03-10
442011	4	4	25	19	2	HOME_TEAM	2024-03-10
442008	4	4	25	3	11	HOME_TEAM	2024-03-10
442015	4	4	26	1	721	AWAY_TEAM	2024-03-15
442014	4	4	26	55	5	AWAY_TEAM	2024-03-16
442018	4	4	26	44	18	DRAW	2024-03-16
442019	4	4	26	28	12	HOME_TEAM	2024-03-16
442020	4	4	26	15	36	HOME_TEAM	2024-03-16
442021	4	4	26	11	16	AWAY_TEAM	2024-03-16
442022	4	4	26	2	10	AWAY_TEAM	2024-03-16
442016	4	4	26	17	3	AWAY_TEAM	2024-03-17
442017	4	4	26	4	19	HOME_TEAM	2024-03-17
442024	4	4	27	19	28	DRAW	2024-03-30
442025	4	4	27	18	17	AWAY_TEAM	2024-03-30
442026	4	4	27	12	11	AWAY_TEAM	2024-03-30
442027	4	4	27	721	15	DRAW	2024-03-30
442029	4	4	27	3	2	HOME_TEAM	2024-03-30
442023	4	4	27	5	4	AWAY_TEAM	2024-03-30
442028	4	4	27	16	1	DRAW	2024-03-31
442030	4	4	27	10	44	DRAW	2024-03-31
442031	4	4	27	36	55	DRAW	2024-03-31
442036	4	4	28	19	12	DRAW	2024-04-05
442032	4	4	28	44	5	HOME_TEAM	2024-04-06
442033	4	4	28	17	721	AWAY_TEAM	2024-04-06
442034	4	4	28	28	3	AWAY_TEAM	2024-04-06
442037	4	4	28	1	36	HOME_TEAM	2024-04-06
442040	4	4	28	15	55	HOME_TEAM	2024-04-06
442039	4	4	28	4	10	AWAY_TEAM	2024-04-06
442038	4	4	28	2	16	HOME_TEAM	2024-04-07
442035	4	4	28	11	18	AWAY_TEAM	2024-04-07
442042	4	4	29	16	28	HOME_TEAM	2024-04-12
442041	4	4	29	18	4	AWAY_TEAM	2024-04-13
442045	4	4	29	721	11	HOME_TEAM	2024-04-13
442046	4	4	29	5	1	HOME_TEAM	2024-04-13
442047	4	4	29	15	2	HOME_TEAM	2024-04-13
442049	4	4	29	36	44	DRAW	2024-04-13
442044	4	4	29	10	19	HOME_TEAM	2024-04-13
442043	4	4	29	55	17	AWAY_TEAM	2024-04-14
442048	4	4	29	3	12	HOME_TEAM	2024-04-14
442056	4	4	30	19	16	HOME_TEAM	2024-04-19
442051	4	4	30	44	721	AWAY_TEAM	2024-04-20
442054	4	4	30	2	18	HOME_TEAM	2024-04-20
442055	4	4	30	11	36	HOME_TEAM	2024-04-20
442058	4	4	30	1	55	AWAY_TEAM	2024-04-20
442050	4	4	30	28	5	AWAY_TEAM	2024-04-20
442057	4	4	30	12	10	HOME_TEAM	2024-04-21
442052	4	4	30	4	3	DRAW	2024-04-21
442053	4	4	30	17	15	DRAW	2024-04-21
442064	4	4	31	36	2	HOME_TEAM	2024-04-26
442059	4	4	31	721	4	HOME_TEAM	2024-04-27
442061	4	4	31	5	19	HOME_TEAM	2024-04-27
442062	4	4	31	17	11	AWAY_TEAM	2024-04-27
442065	4	4	31	16	12	AWAY_TEAM	2024-04-27
442066	4	4	31	3	10	DRAW	2024-04-27
442060	4	4	31	18	28	DRAW	2024-04-28
442063	4	4	31	15	1	DRAW	2024-04-28
442067	4	4	31	55	44	AWAY_TEAM	2024-04-28
442069	4	4	32	2	721	DRAW	2024-05-03
442068	4	4	32	10	5	HOME_TEAM	2024-05-04
442073	4	4	32	12	18	DRAW	2024-05-04
442075	4	4	32	4	16	HOME_TEAM	2024-05-04
442076	4	4	32	11	55	HOME_TEAM	2024-05-04
442070	4	4	32	1	17	DRAW	2024-05-04
442074	4	4	32	28	36	AWAY_TEAM	2024-05-05
442071	4	4	32	19	3	AWAY_TEAM	2024-05-05
442072	4	4	32	44	15	DRAW	2024-05-05
442084	4	4	33	16	10	AWAY_TEAM	2024-05-10
442078	4	4	33	1	28	HOME_TEAM	2024-05-11
442080	4	4	33	18	19	DRAW	2024-05-11
442083	4	4	33	721	12	DRAW	2024-05-11
442085	4	4	33	17	44	DRAW	2024-05-11
442077	4	4	33	15	4	HOME_TEAM	2024-05-11
442082	4	4	33	55	2	AWAY_TEAM	2024-05-12
442081	4	4	33	5	11	HOME_TEAM	2024-05-12
442079	4	4	33	36	3	AWAY_TEAM	2024-05-12
442086	4	4	34	2	5	HOME_TEAM	2024-05-18
442087	4	4	34	19	721	DRAW	2024-05-18
442088	4	4	34	28	17	HOME_TEAM	2024-05-18
442089	4	4	34	11	15	AWAY_TEAM	2024-05-18
442090	4	4	34	10	18	HOME_TEAM	2024-05-18
442091	4	4	34	44	1	HOME_TEAM	2024-05-18
442092	4	4	34	12	36	HOME_TEAM	2024-05-18
442093	4	4	34	3	16	HOME_TEAM	2024-05-18
442094	4	4	34	4	55	HOME_TEAM	2024-05-18
442710	5	5	1	522	521	DRAW	2023-08-11
442711	5	5	1	516	547	HOME_TEAM	2023-08-12
442712	5	5	1	524	525	DRAW	2023-08-12
442714	5	5	1	512	546	HOME_TEAM	2023-08-13
442707	5	5	1	541	548	AWAY_TEAM	2023-08-13
442708	5	5	1	543	511	AWAY_TEAM	2023-08-13
442709	5	5	1	518	533	DRAW	2023-08-13
442715	5	5	1	529	545	HOME_TEAM	2023-08-13
442713	5	5	1	576	523	HOME_TEAM	2023-08-13
442719	5	5	2	545	516	DRAW	2023-08-18
442721	5	5	2	523	518	AWAY_TEAM	2023-08-19
442720	5	5	2	511	524	DRAW	2023-08-19
442722	5	5	2	521	543	HOME_TEAM	2023-08-20
442716	5	5	2	533	512	AWAY_TEAM	2023-08-20
442718	5	5	2	525	522	DRAW	2023-08-20
442724	5	5	2	547	541	HOME_TEAM	2023-08-20
442717	5	5	2	548	576	HOME_TEAM	2023-08-20
442723	5	5	2	546	529	DRAW	2023-08-20
442727	5	5	3	543	548	DRAW	2023-08-25
442730	5	5	3	516	512	HOME_TEAM	2023-08-26
442731	5	5	3	524	546	HOME_TEAM	2023-08-26
442733	5	5	3	529	533	DRAW	2023-08-27
442725	5	5	3	541	545	AWAY_TEAM	2023-08-27
442728	5	5	3	518	547	AWAY_TEAM	2023-08-27
442732	5	5	3	576	511	HOME_TEAM	2023-08-27
442726	5	5	3	525	521	HOME_TEAM	2023-08-27
442729	5	5	3	522	523	DRAW	2023-08-27
442737	5	5	4	543	516	DRAW	2023-09-01
442741	5	5	4	512	529	DRAW	2023-09-02
442735	5	5	4	548	546	HOME_TEAM	2023-09-02
442738	5	5	4	511	541	DRAW	2023-09-03
442734	5	5	4	533	525	HOME_TEAM	2023-09-03
442736	5	5	4	545	547	DRAW	2023-09-03
442740	5	5	4	521	518	HOME_TEAM	2023-09-03
442739	5	5	4	522	576	HOME_TEAM	2023-09-03
442742	5	5	4	523	524	AWAY_TEAM	2023-09-03
442747	5	5	5	524	522	AWAY_TEAM	2023-09-15
442751	5	5	5	529	521	DRAW	2023-09-16
442749	5	5	5	546	545	AWAY_TEAM	2023-09-16
442744	5	5	5	525	548	DRAW	2023-09-17
442743	5	5	5	541	543	AWAY_TEAM	2023-09-17
442748	5	5	5	576	518	DRAW	2023-09-17
442750	5	5	5	547	512	AWAY_TEAM	2023-09-17
442746	5	5	5	516	511	DRAW	2023-09-17
442745	5	5	5	523	533	DRAW	2023-09-17
442753	5	5	6	548	522	AWAY_TEAM	2023-09-22
442755	5	5	6	543	525	HOME_TEAM	2023-09-23
442760	5	5	6	512	523	HOME_TEAM	2023-09-23
442754	5	5	6	545	576	AWAY_TEAM	2023-09-24
442752	5	5	6	533	541	HOME_TEAM	2023-09-24
442759	5	5	6	546	511	HOME_TEAM	2023-09-24
442756	5	5	6	518	529	DRAW	2023-09-24
442758	5	5	6	524	516	HOME_TEAM	2023-09-24
442757	5	5	6	521	547	AWAY_TEAM	2023-09-26
442767	5	5	7	576	546	AWAY_TEAM	2023-09-29
442763	5	5	7	541	524	DRAW	2023-09-30
442762	5	5	7	548	516	HOME_TEAM	2023-09-30
442768	5	5	7	547	523	HOME_TEAM	2023-10-01
442761	5	5	7	533	521	AWAY_TEAM	2023-10-01
442765	5	5	7	511	545	HOME_TEAM	2023-10-01
442766	5	5	7	522	512	DRAW	2023-10-01
442764	5	5	7	525	518	AWAY_TEAM	2023-10-01
442769	5	5	7	529	543	HOME_TEAM	2023-10-01
442774	5	5	8	576	543	AWAY_TEAM	2023-10-06
442770	5	5	8	545	522	AWAY_TEAM	2023-10-07
442777	5	5	8	547	548	AWAY_TEAM	2023-10-07
442772	5	5	8	516	533	HOME_TEAM	2023-10-08
442773	5	5	8	523	525	DRAW	2023-10-08
442776	5	5	8	512	511	DRAW	2023-10-08
442775	5	5	8	546	521	DRAW	2023-10-08
442778	5	5	8	529	524	AWAY_TEAM	2023-10-08
442779	5	5	9	533	546	DRAW	2023-10-20
442787	5	5	9	524	576	HOME_TEAM	2023-10-21
442784	5	5	9	522	516	HOME_TEAM	2023-10-21
442781	5	5	9	525	529	HOME_TEAM	2023-10-22
442782	5	5	9	543	518	HOME_TEAM	2023-10-22
442783	5	5	9	511	547	DRAW	2023-10-22
442786	5	5	9	521	512	HOME_TEAM	2023-10-22
442780	5	5	9	548	545	HOME_TEAM	2023-10-22
442785	5	5	9	523	541	AWAY_TEAM	2023-10-22
442788	5	5	10	541	522	AWAY_TEAM	2023-10-27
442795	5	5	10	547	525	HOME_TEAM	2023-10-28
442793	5	5	10	546	543	HOME_TEAM	2023-10-28
442794	5	5	10	512	524	AWAY_TEAM	2023-10-29
442789	5	5	10	545	533	DRAW	2023-10-29
442790	5	5	10	518	511	HOME_TEAM	2023-10-29
442792	5	5	10	521	548	HOME_TEAM	2023-10-29
442796	5	5	10	529	576	DRAW	2023-10-29
442804	5	5	11	524	518	HOME_TEAM	2023-11-03
442798	5	5	11	525	546	DRAW	2023-11-04
442803	5	5	11	516	521	DRAW	2023-11-04
442802	5	5	11	523	545	DRAW	2023-11-05
442799	5	5	11	543	547	AWAY_TEAM	2023-11-05
442800	5	5	11	511	533	AWAY_TEAM	2023-11-05
442805	5	5	11	576	541	DRAW	2023-11-05
442797	5	5	11	548	512	HOME_TEAM	2023-11-05
442801	5	5	11	522	529	HOME_TEAM	2023-11-05
442809	5	5	12	518	522	DRAW	2023-11-10
442813	5	5	12	547	524	AWAY_TEAM	2023-11-11
442806	5	5	12	533	548	DRAW	2023-11-11
442807	5	5	12	541	525	HOME_TEAM	2023-11-12
442808	5	5	12	545	543	HOME_TEAM	2023-11-12
442810	5	5	12	521	511	DRAW	2023-11-12
442814	5	5	12	529	523	AWAY_TEAM	2023-11-12
442811	5	5	12	546	516	HOME_TEAM	2023-11-12
442821	5	5	13	524	548	HOME_TEAM	2023-11-24
442815	5	5	13	541	546	AWAY_TEAM	2023-11-25
442822	5	5	13	576	516	DRAW	2023-11-25
442819	5	5	13	522	511	HOME_TEAM	2023-11-26
442816	5	5	13	525	545	AWAY_TEAM	2023-11-26
442817	5	5	13	543	533	DRAW	2023-11-26
442818	5	5	13	518	512	AWAY_TEAM	2023-11-26
442823	5	5	13	529	547	HOME_TEAM	2023-11-26
442820	5	5	13	523	521	AWAY_TEAM	2023-11-26
442771	5	5	8	518	541	DRAW	2023-11-29
442832	5	5	14	547	576	HOME_TEAM	2023-12-01
442830	5	5	14	546	523	HOME_TEAM	2023-12-02
442826	5	5	14	543	522	HOME_TEAM	2023-12-02
442824	5	5	14	533	524	AWAY_TEAM	2023-12-03
442825	5	5	14	548	518	HOME_TEAM	2023-12-03
442827	5	5	14	511	525	DRAW	2023-12-03
442831	5	5	14	512	541	HOME_TEAM	2023-12-03
442829	5	5	14	521	545	HOME_TEAM	2023-12-03
442828	5	5	14	516	529	HOME_TEAM	2023-12-03
442791	5	5	10	516	523	HOME_TEAM	2023-12-06
442812	5	5	12	512	576	DRAW	2023-12-07
442836	5	5	15	518	546	DRAW	2023-12-08
442841	5	5	15	529	548	AWAY_TEAM	2023-12-09
442839	5	5	15	524	543	HOME_TEAM	2023-12-09
442837	5	5	15	522	547	HOME_TEAM	2023-12-10
442833	5	5	15	541	521	DRAW	2023-12-10
442835	5	5	15	545	512	AWAY_TEAM	2023-12-10
442840	5	5	15	576	533	HOME_TEAM	2023-12-10
442838	5	5	15	523	511	HOME_TEAM	2023-12-10
442834	5	5	15	525	516	AWAY_TEAM	2023-12-10
442843	5	5	16	548	523	AWAY_TEAM	2023-12-15
442842	5	5	16	533	522	HOME_TEAM	2023-12-16
442850	5	5	16	546	547	HOME_TEAM	2023-12-16
442846	5	5	16	543	512	AWAY_TEAM	2023-12-17
442844	5	5	16	525	576	AWAY_TEAM	2023-12-17
442845	5	5	16	545	518	AWAY_TEAM	2023-12-17
442847	5	5	16	511	529	DRAW	2023-12-17
442848	5	5	16	516	541	HOME_TEAM	2023-12-17
442849	5	5	16	521	524	DRAW	2023-12-17
442851	5	5	17	541	529	AWAY_TEAM	2023-12-20
442852	5	5	17	511	548	AWAY_TEAM	2023-12-20
442853	5	5	17	518	516	DRAW	2023-12-20
442854	5	5	17	522	546	HOME_TEAM	2023-12-20
442855	5	5	17	523	543	HOME_TEAM	2023-12-20
442856	5	5	17	524	545	HOME_TEAM	2023-12-20
442857	5	5	17	576	521	HOME_TEAM	2023-12-20
442858	5	5	17	512	525	HOME_TEAM	2023-12-20
442859	5	5	17	547	533	HOME_TEAM	2023-12-20
442864	5	5	18	516	576	DRAW	2024-01-12
442861	5	5	18	548	547	AWAY_TEAM	2024-01-13
442868	5	5	18	529	522	HOME_TEAM	2024-01-13
442865	5	5	18	521	525	HOME_TEAM	2024-01-14
442862	5	5	18	545	511	AWAY_TEAM	2024-01-14
442863	5	5	18	543	541	AWAY_TEAM	2024-01-14
442867	5	5	18	512	518	HOME_TEAM	2024-01-14
442860	5	5	18	533	523	HOME_TEAM	2024-01-14
442866	5	5	18	546	524	AWAY_TEAM	2024-01-14
442875	5	5	19	523	529	AWAY_TEAM	2024-01-26
442873	5	5	19	522	545	HOME_TEAM	2024-01-27
442874	5	5	19	516	548	DRAW	2024-01-27
442872	5	5	19	518	521	DRAW	2024-01-28
442869	5	5	19	541	576	DRAW	2024-01-28
442870	5	5	19	525	533	DRAW	2024-01-28
442877	5	5	19	547	543	DRAW	2024-01-28
442871	5	5	19	511	546	AWAY_TEAM	2024-01-28
442876	5	5	19	524	512	DRAW	2024-01-28
442883	5	5	20	576	524	AWAY_TEAM	2024-02-02
442886	5	5	20	529	518	HOME_TEAM	2024-02-03
442880	5	5	20	543	546	AWAY_TEAM	2024-02-03
442878	5	5	20	548	533	DRAW	2024-02-04
442882	5	5	20	521	541	HOME_TEAM	2024-02-04
442885	5	5	20	547	511	AWAY_TEAM	2024-02-04
442879	5	5	20	545	525	AWAY_TEAM	2024-02-04
442884	5	5	20	512	522	DRAW	2024-02-04
442881	5	5	20	523	516	HOME_TEAM	2024-02-04
442893	5	5	21	516	545	DRAW	2024-02-09
442895	5	5	21	546	576	HOME_TEAM	2024-02-10
442894	5	5	21	524	521	HOME_TEAM	2024-02-10
442887	5	5	21	533	529	AWAY_TEAM	2024-02-11
442888	5	5	21	541	512	DRAW	2024-02-11
442889	5	5	21	525	547	HOME_TEAM	2024-02-11
442890	5	5	21	511	543	AWAY_TEAM	2024-02-11
442891	5	5	21	518	523	AWAY_TEAM	2024-02-11
442892	5	5	21	522	548	AWAY_TEAM	2024-02-11
442899	5	5	22	523	522	HOME_TEAM	2024-02-16
442900	5	5	22	521	533	HOME_TEAM	2024-02-17
442897	5	5	22	543	524	AWAY_TEAM	2024-02-17
442901	5	5	22	576	525	AWAY_TEAM	2024-02-18
442896	5	5	22	548	511	AWAY_TEAM	2024-02-18
442898	5	5	22	518	545	HOME_TEAM	2024-02-18
442904	5	5	22	529	541	HOME_TEAM	2024-02-18
442903	5	5	22	547	546	DRAW	2024-02-18
442902	5	5	22	512	516	HOME_TEAM	2024-02-18
442907	5	5	23	545	523	AWAY_TEAM	2024-02-23
442906	5	5	23	525	543	AWAY_TEAM	2024-02-24
442912	5	5	23	576	512	AWAY_TEAM	2024-02-24
442913	5	5	23	546	548	AWAY_TEAM	2024-02-25
442905	5	5	23	533	547	AWAY_TEAM	2024-02-25
442908	5	5	23	511	521	HOME_TEAM	2024-02-25
442909	5	5	23	522	541	DRAW	2024-02-25
442911	5	5	23	524	529	DRAW	2024-02-25
442910	5	5	23	516	518	HOME_TEAM	2024-02-25
442914	5	5	24	548	524	DRAW	2024-03-01
442921	5	5	24	547	521	AWAY_TEAM	2024-03-02
442915	5	5	24	541	516	AWAY_TEAM	2024-03-02
442917	5	5	24	511	522	HOME_TEAM	2024-03-03
442916	5	5	24	543	545	AWAY_TEAM	2024-03-03
442918	5	5	24	518	576	DRAW	2024-03-03
442920	5	5	24	512	533	HOME_TEAM	2024-03-03
442922	5	5	24	529	525	AWAY_TEAM	2024-03-03
442919	5	5	24	523	546	AWAY_TEAM	2024-03-03
442926	5	5	25	522	518	AWAY_TEAM	2024-03-08
442924	5	5	25	525	523	AWAY_TEAM	2024-03-09
442931	5	5	25	546	512	HOME_TEAM	2024-03-09
442929	5	5	25	524	547	DRAW	2024-03-10
442923	5	5	25	533	511	HOME_TEAM	2024-03-10
442925	5	5	25	545	541	HOME_TEAM	2024-03-10
442930	5	5	25	576	548	AWAY_TEAM	2024-03-10
442928	5	5	25	521	529	DRAW	2024-03-10
442927	5	5	25	516	543	HOME_TEAM	2024-03-10
442935	5	5	26	511	523	AWAY_TEAM	2024-03-15
442934	5	5	26	543	576	AWAY_TEAM	2024-03-16
442937	5	5	26	546	522	AWAY_TEAM	2024-03-16
442938	5	5	26	512	521	DRAW	2024-03-17
442932	5	5	26	548	525	DRAW	2024-03-17
442933	5	5	26	541	533	HOME_TEAM	2024-03-17
442939	5	5	26	547	545	HOME_TEAM	2024-03-17
442940	5	5	26	529	516	HOME_TEAM	2024-03-17
442936	5	5	26	518	524	AWAY_TEAM	2024-03-17
442948	5	5	27	521	546	HOME_TEAM	2024-03-29
442944	5	5	27	545	548	AWAY_TEAM	2024-03-30
442947	5	5	27	523	547	DRAW	2024-03-30
442943	5	5	27	525	512	AWAY_TEAM	2024-03-31
442941	5	5	27	533	518	AWAY_TEAM	2024-03-31
442942	5	5	27	541	511	AWAY_TEAM	2024-03-31
442945	5	5	27	522	543	AWAY_TEAM	2024-03-31
442949	5	5	27	576	529	HOME_TEAM	2024-03-31
442946	5	5	27	516	524	AWAY_TEAM	2024-03-31
442954	5	5	28	521	516	HOME_TEAM	2024-04-05
442956	5	5	28	546	533	DRAW	2024-04-06
442955	5	5	28	524	541	DRAW	2024-04-06
442957	5	5	28	512	545	HOME_TEAM	2024-04-07
442952	5	5	28	511	576	DRAW	2024-04-07
442953	5	5	28	518	525	HOME_TEAM	2024-04-07
442958	5	5	28	547	522	DRAW	2024-04-07
442950	5	5	28	548	529	HOME_TEAM	2024-04-07
442951	5	5	28	543	523	AWAY_TEAM	2024-04-07
442963	5	5	29	545	546	HOME_TEAM	2024-04-12
442966	5	5	29	576	547	HOME_TEAM	2024-04-13
442967	5	5	29	529	511	AWAY_TEAM	2024-04-13
442959	5	5	29	533	543	AWAY_TEAM	2024-04-14
442961	5	5	29	541	518	DRAW	2024-04-14
442965	5	5	29	523	512	HOME_TEAM	2024-04-14
442971	5	5	30	522	525	HOME_TEAM	2024-04-19
442969	5	5	30	543	529	AWAY_TEAM	2024-04-20
442974	5	5	30	546	541	HOME_TEAM	2024-04-20
442968	5	5	30	533	545	AWAY_TEAM	2024-04-21
442972	5	5	30	521	576	HOME_TEAM	2024-04-21
442976	5	5	30	547	518	AWAY_TEAM	2024-04-21
442975	5	5	30	512	548	AWAY_TEAM	2024-04-21
442970	5	5	30	511	516	DRAW	2024-04-21
442973	5	5	30	524	523	HOME_TEAM	2024-04-21
442962	5	5	29	525	524	AWAY_TEAM	2024-04-24
442960	5	5	29	548	521	HOME_TEAM	2024-04-24
442964	5	5	29	516	522	DRAW	2024-04-24
442980	5	5	31	518	543	DRAW	2024-04-26
442983	5	5	31	524	533	DRAW	2024-04-27
442979	5	5	31	545	521	AWAY_TEAM	2024-04-28
442977	5	5	31	541	547	HOME_TEAM	2024-04-28
442978	5	5	31	525	511	AWAY_TEAM	2024-04-28
442984	5	5	31	576	522	AWAY_TEAM	2024-04-28
442985	5	5	31	529	512	AWAY_TEAM	2024-04-28
442981	5	5	31	523	548	HOME_TEAM	2024-04-28
442982	5	5	31	516	546	HOME_TEAM	2024-04-28
442989	5	5	32	511	518	AWAY_TEAM	2024-05-03
442992	5	5	32	546	525	HOME_TEAM	2024-05-03
442986	5	5	32	533	576	HOME_TEAM	2024-05-04
442987	5	5	32	548	541	HOME_TEAM	2024-05-04
442988	5	5	32	545	529	AWAY_TEAM	2024-05-04
442993	5	5	32	512	543	DRAW	2024-05-04
442991	5	5	32	521	523	AWAY_TEAM	2024-05-06
442998	5	5	33	522	533	HOME_TEAM	2024-05-10
443002	5	5	33	512	547	DRAW	2024-05-10
442995	5	5	33	541	523	AWAY_TEAM	2024-05-12
442996	5	5	33	543	521	AWAY_TEAM	2024-05-12
442997	5	5	33	518	548	AWAY_TEAM	2024-05-12
442999	5	5	33	516	525	HOME_TEAM	2024-05-12
443000	5	5	33	524	511	AWAY_TEAM	2024-05-12
443001	5	5	33	576	545	HOME_TEAM	2024-05-12
443003	5	5	33	529	546	DRAW	2024-05-12
442990	5	5	32	522	524	AWAY_TEAM	2024-05-15
442994	5	5	32	547	516	HOME_TEAM	2024-05-15
443004	5	5	34	533	516	AWAY_TEAM	2024-05-19
443005	5	5	34	548	543	HOME_TEAM	2024-05-19
443006	5	5	34	525	541	HOME_TEAM	2024-05-19
443007	5	5	34	545	524	AWAY_TEAM	2024-05-19
443008	5	5	34	511	512	AWAY_TEAM	2024-05-19
443009	5	5	34	523	576	HOME_TEAM	2024-05-19
443010	5	5	34	521	522	DRAW	2024-05-19
443011	5	5	34	546	518	DRAW	2024-05-19
443012	5	5	34	547	529	HOME_TEAM	2024-05-19
\.


--
-- TOC entry 3461 (class 0 OID 16532)
-- Dependencies: 228
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: sports_league_owner
--

COPY public.players (player_id, team_id, name, "position", date_of_birth, nationality) FROM stdin;
3222	65	Ederson	Goalkeeper	1993-08-17	Brazil
4172	65	Scott Carson	Goalkeeper	1985-09-03	England
6958	65	Stefan Ortega Moreno	Goalkeeper	1992-11-06	Germany
244993	65	True Grant	Goalkeeper	2005-11-02	England
143	65	Manuel Akanji	Defence	1995-07-19	Switzerland
164	65	Sergio Gómez	Defence	2000-09-04	Spain
3311	65	Kyle Walker	Defence	1990-05-28	England
3313	65	John Stones	Defence	1994-05-28	England
8240	65	Nathan Aké	Defence	1995-02-18	Netherlands
10183	65	Rúben Dias	Defence	1997-05-14	Portugal
122266	65	Joško Gvardiol	Defence	2002-01-23	Croatia
244856	65	Max Alleyne	Defence	2005-07-21	England
65	65	Mateo Kovačić	Midfield	1994-05-06	Croatia
3199	65	Rodri	Midfield	1996-06-22	Spain
3254	65	Bernardo Silva	Midfield	1994-08-10	Portugal
3654	65	Kevin De Bruyne	Midfield	1991-06-28	Belgium
3895	65	Jack Grealish	Midfield	1995-09-10	England
7888	65	Phil Foden	Midfield	2000-05-28	England
91512	65	Matheus Nunes	Midfield	1998-08-27	Portugal
179716	65	Oscar Bobb	Midfield	2003-07-12	Norway
221259	65	Micah Hamilton	Midfield	2003-11-13	England
244846	65	Mahamadou Susoho	Midfield	2005-01-20	Spain
245445	65	Jacob Wright	Midfield	2005-09-21	England
38101	65	Erling Haaland	Offence	2000-07-21	Norway
98571	65	Julián Álvarez	Offence	2000-01-31	Argentina
99775	65	Jeremy Doku	Offence	2002-05-27	Belgium
4832	57	David Raya	Goalkeeper	1995-09-15	Spain
5530	57	Aaron Ramsdale	Goalkeeper	1998-05-14	England
153843	57	Karl Jakob Hein	Goalkeeper	2002-04-13	Estonia
3244	57	Cédric	Defence	1991-08-31	Portugal
6154	57	Ben White	Defence	1997-10-08	England
7889	57	Oleksandr Zinchenko	Defence	1996-12-15	Ukraine
9034	57	Takehiro Tomiyasu	Defence	1998-11-05	Japan
23128	57	Gabriel	Defence	1997-12-19	Brazil
80171	57	William Saliba	Defence	2001-03-24	France
98816	57	Jurrien Timber	Defence	2001-06-17	Netherlands
147286	57	Jakub Kiwior	Defence	2000-02-15	Poland
204501	57	Reuell Walters	Defence	2004-12-16	England
247644	57	Ayden Heaven	Defence	2006-09-22	England
110	57	Thomas Partey	Midfield	1993-06-13	Ghana
171	57	Kai Havertz	Midfield	1999-06-11	Germany
2094	57	Jorginho	Midfield	1991-12-20	Italy
7427	57	Martin Ødegaard	Midfield	1998-12-17	Norway
8215	57	Declan Rice	Midfield	1999-01-14	England
8984	57	Leandro Trossard	Midfield	1994-12-04	Belgium
85570	57	Emile Smith Rowe	Midfield	2000-07-28	England
112948	57	Fabio Vieira	Midfield	2000-05-30	Portugal
179669	57	Mohamed Elneny	Midfield	1992-07-11	Egypt
204461	57	Mauro Bandeira	Midfield	2004-04-19	Portugal
204503	57	Amario Cozier-Duberry	Midfield	2005-05-29	England
221250	57	James Sweet	Midfield	2003-11-03	Wales
244120	57	Myles Lewis-Skelly	Midfield	2006-09-26	England
3236	57	Gabriel Jesus	Offence	1997-04-03	Brazil
7799	57	Reiss Nelson	Offence	1999-12-10	England
7800	57	Eddie Nketiah	Offence	1999-05-30	England
61450	57	Martinelli	Offence	2001-06-18	Brazil
99813	57	Bukayo Saka	Offence	2001-09-05	England
188476	57	Ethan Nwaneri	Offence	2007-03-21	England
1795	64	Alisson	Goalkeeper	1992-10-02	Brazil
8197	64	Adrián	Goalkeeper	1987-01-03	Spain
102046	64	Caoimhin Kelleher	Goalkeeper	1998-11-23	Ireland
221770	64	Fabian Mrozek	Goalkeeper	2003-09-28	Poland
3269	64	Wataru Endō	Defence	1993-02-09	Japan
7383	64	Kostas Tsimikas	Defence	1996-05-12	Greece
7862	64	Joe Gomez	Defence	1997-05-23	England
7865	64	Joël Matip	Defence	1991-08-08	Cameroon
7867	64	Trent Alexander-Arnold	Defence	1998-10-07	England
7868	64	Andrew Robertson	Defence	1994-03-11	Scotland
7869	64	Virgil van Dijk	Defence	1991-07-08	Netherlands
9542	64	Ibrahima Konaté	Defence	1999-05-25	France
135636	64	Rhys Williams	Defence	2001-02-03	England
175865	64	Conor Bradley	Defence	2003-07-09	Northern Ireland
176718	64	Jarell Quansah	Defence	2003-01-29	England
186701	64	Stefan Bajcetic	Defence	2004-10-22	Spain
226978	64	Calum Scanlon	Defence	2005-02-14	England
248990	64	Amara Nallo	Defence	2006-11-18	England
356	64	Thiago Alcântara	Midfield	1991-04-11	Spain
7873	64	Curtis Jones	Midfield	2001-01-30	England
16347	64	Dominik Szoboszlai	Midfield	2000-10-25	Hungary
45681	64	Alexis Mac Allister	Midfield	1998-12-24	Argentina
81793	64	Ryan Gravenberch	Midfield	2002-05-16	Netherlands
186708	64	Bobby Clark	Midfield	2005-02-07	England
214502	64	James McConnell	Midfield	2004-09-13	England
230517	64	Trey Nyoni	Midfield	2007-06-30	England
244935	64	Tom Hill	Midfield	2002-10-13	England
3754	64	Mohamed Salah	Offence	1992-06-15	Egypt
4092	64	Diogo Jota	Offence	1996-12-04	Portugal
7459	64	Cody Gakpo	Offence	1999-05-07	Netherlands
22396	64	Luis Díaz	Offence	1997-01-13	Colombia
28612	64	Darwin Núñez	Offence	1999-06-24	Uruguay
124824	64	Harvey Elliott	Offence	2003-04-04	England
157176	64	Kaide Gordon	Offence	2004-10-05	England
176789	64	Ben Doak	Offence	2005-11-11	Scotland
244989	64	Lewis Koumas	Offence	2005-09-19	Wales
247657	64	Jayden Danns	Offence	2006-01-16	England
249379	64	Mateusz Musiałowski	Offence	2003-10-16	Poland
3141	58	Emiliano Martínez	Goalkeeper	1992-09-02	Argentina
187202	65	Rico Lewis	Defence	2004-11-21	England
15512	58	Robin Olsen	Goalkeeper	1990-01-08	Sweden
81871	58	Joe Gauci	Goalkeeper	2000-07-04	Australia
204460	58	James Wright	Goalkeeper	2004-12-02	England
244962	58	Sam Proctor	Goalkeeper	2006-12-21	England
252845	58	Lander Emery	Goalkeeper	2004-03-29	Spain
63	58	Clément Lenglet	Defence	1995-06-17	France
3359	58	Lucas Digne	Defence	1993-07-20	France
4082	58	Kortney Hause	Defence	1995-07-16	England
6317	58	Ezri Konsa	Defence	1998-04-06	England
7787	58	Calum Chambers	Defence	1995-01-20	England
8235	58	Tyrone Mings	Defence	1993-03-13	England
8346	58	Boubacar Kamara	Defence	1999-11-23	France
8698	58	Diego Carlos	Defence	1993-03-15	Brazil
11644	58	Matty Cash	Defence	1997-08-07	Poland
32123	58	Alex Moreno	Defence	1993-06-08	Spain
33109	58	Pau Torres	Defence	1997-01-16	Spain
171509	58	Kaine Kesler	Defence	2002-10-23	England
204428	58	Travis Patterson	Defence	2005-10-06	England
246589	58	Finley Munroe	Defence	2005-02-08	England
2013	58	Nicolò Zaniolo	Midfield	1999-07-02	Italy
3658	58	Youri Tielemans	Midfield	1997-05-07	Belgium
31941	58	Emiliano Buendía	Midfield	1996-12-25	Argentina
33525	58	Douglas Luiz	Midfield	1998-05-09	Brazil
34646	58	John McGinn	Midfield	1994-10-18	Scotland
111437	58	Jacob Ramsey	Midfield	2001-05-28	England
169326	58	Tim Iroegbunam	Midfield	2002-08-12	England
190563	58	Kadan Young	Midfield	2006-01-19	England
157	58	Leon Bailey	Offence	1997-08-09	Jamaica
2240	58	Moussa Diaby	Offence	1999-07-07	France
4444	58	Ollie Watkins	Offence	1995-12-30	England
82140	58	Morgan Rogers	Offence	2002-07-26	England
104493	58	Jhon Durán	Offence	2003-12-13	Colombia
214417	58	Omari Kellyman	Offence	2005-09-25	Northern Ireland
3086	73	Guglielmo Vicario	Goalkeeper	1996-10-07	Italy
7992	73	Alfie Whiteman	Goalkeeper	1998-10-02	England
8079	73	Fraser Forster	Goalkeeper	1988-03-17	England
133229	73	Brandon Austin	Goalkeeper	1999-01-08	England
1131	73	Emerson Royal	Defence	1999-01-14	Brazil
7994	73	Ben Davies	Defence	1993-04-24	Wales
45735	73	Christian Romero	Defence	1998-04-27	Argentina
81037	73	Pedro Porro	Defence	1999-09-13	Spain
131177	73	Mickey van de Ven	Defence	2001-04-19	Netherlands
140432	73	Radu Drăgușin	Defence	2002-02-03	Romania
170378	73	Destiny Udogie	Defence	2002-11-28	Italy
230351	73	Alfie Dorrington	Defence	2005-04-20	England
2041	73	Rodrigo Bentancur	Midfield	1997-06-25	Uruguay
3216	73	Giovani Lo Celso	Midfield	1996-04-09	Argentina
3959	73	Ryan Sessegnon	Midfield	2000-05-18	England
3992	73	James Maddison	Midfield	1996-11-23	England
8093	73	Pierre Emile Højbjerg	Midfield	1995-08-05	Denmark
8410	73	Yves Bissouma	Midfield	1996-08-30	Mali
96974	73	Oliver Skipp	Midfield	2000-09-16	England
124694	73	Brennan Johnson	Midfield	2001-05-23	Wales
170281	73	Heung-min Son	Midfield	1992-07-08	South Korea
170391	73	Pape Sarr	Midfield	2002-09-14	Senegal
206810	73	Yago Santiago	Midfield	2003-04-15	Spain
251740	73	Tyrese Hall	Midfield	2005-09-04	England
1859	73	Dejan Kulusevski	Offence	2000-04-25	Sweden
3187	73	Timo Werner	Offence	1996-03-06	Germany
8133	73	Richarlison	Offence	1997-05-10	Brazil
40541	73	Manor Solomon	Offence	1999-07-24	Israel
101912	73	Bryan Gil	Offence	2001-02-11	Spain
156616	73	Dane Scarlett	Offence	2004-03-24	England
221328	73	Jamie Donley	Offence	2005-01-03	Northern Ireland
251079	73	Mikey Moore	Offence	2007-08-11	England
3953	61	Marcus Bettinelli	Goalkeeper	1992-05-24	England
121765	61	Đorđe Petrović	Goalkeeper	1999-10-08	Serbia
135555	61	Robert Sánchez	Goalkeeper	1997-11-18	Spain
175910	61	Teddy Sharman-Lowe	Goalkeeper	2003-01-19	England
246715	61	Max Merrick	Goalkeeper	2005-11-10	England
246743	61	Ted Curd	Goalkeeper	2006-02-14	England
813	61	Axel Disasi	Defence	1998-03-11	France
3224	61	Thiago Silva	Defence	1984-09-22	Brazil
7810	61	Trevoh Chalobah	Defence	1999-07-05	England
8065	61	Ben Chilwell	Defence	1996-12-21	England
8424	61	Malang Sarr	Defence	1999-01-23	France
8545	61	Wesley Fofana	Defence	2000-12-17	France
15863	61	Cucurella	Defence	1998-07-22	Spain
56628	61	Reece James	Defence	1999-12-08	England
152498	61	Malo Gusto	Defence	2003-05-19	France
170426	61	Benoît Badiashile	Defence	2001-03-26	France
170440	61	Levi Colwill	Defence	2003-02-26	England
179698	61	Dylan Williams	Defence	2003-09-13	England
189625	61	Ishe Samuels-Smith	Defence	2006-06-05	England
206825	61	Alfie Gilchrist	Defence	2003-11-28	England
221263	61	Joshua Brooking	Defence	2002-09-01	England
248984	61	Harrison Murray-Campbell	Defence	2006-08-04	England
249320	61	Josh Acheampong	Defence	2006-05-05	England
8484	61	Christopher Nkunku	Midfield	1997-11-14	France
98978	61	Mykhailo Mudryk	Midfield	2001-01-05	Ukraine
102603	61	Enzo Fernández	Midfield	2001-01-17	Argentina
119265	61	Conor Gallagher	Midfield	2000-02-06	England
121103	61	Moisés Caicedo	Midfield	2001-11-02	Ecuador
144892	61	Cole Palmer	Midfield	2002-05-06	England
153555	61	Chimuanya Ugochukwu	Midfield	2004-03-26	France
167570	61	Carney Chukwuemeka	Midfield	2003-10-20	England
167720	61	Noni Madueke	Midfield	2002-03-10	England
172738	61	Romeo Lavia	Midfield	2004-01-06	Belgium
179558	61	Cesare Casadei	Midfield	2003-01-10	Italy
203375	61	Deivid Washington	Midfield	2005-06-05	Brazil
217744	61	Zak Sturge	Midfield	2004-06-15	England
228509	61	Leo Castledine	Midfield	2005-08-20	England
245340	61	Michael Golding	Midfield	2006-05-23	England
247243	61	Ollie Harrison	Midfield	2007-08-07	England
248777	61	Billy Gee	Midfield	2005-07-30	England
250364	61	Kiano Dyer	Midfield	2006-11-21	England
3329	61	Raheem Sterling	Offence	1994-12-08	England
152515	61	Nicolas Jackson	Offence	2001-06-20	Senegal
218431	61	Ronnie Stutter	Offence	2005-01-06	England
248767	61	Jimi Tauriainen	Offence	2004-03-09	Finland
250436	61	Tyrique George	Offence	2006-02-04	England
3310	67	Nick Pope	Goalkeeper	1992-04-19	England
5048	67	Mark Gillespie	Goalkeeper	1992-03-27	England
7856	67	Loris Karius	Goalkeeper	1993-06-22	Germany
7914	67	Martin Dúbravka	Goalkeeper	1989-01-15	Slovakia
220503	67	Aidan Harris	Goalkeeper	2006-12-16	England
244853	67	Adam Harrison	Goalkeeper	2006-10-20	England
88	67	Fabian Schär	Defence	1991-12-20	Switzerland
1868	67	Emil Krafth	Defence	1994-08-02	Sweden
3312	67	Kieran Trippier	Defence	1990-09-19	England
3962	67	Matt Targett	Defence	1995-09-18	England
4870	67	Dan Burn	Defence	1992-05-09	England
7917	67	Paul Dummett	Defence	1991-09-26	Wales
7919	67	Jamaal Lascelles	Defence	1993-11-11	England
7930	67	Matt Ritchie	Defence	1989-09-10	Scotland
81082	67	Sven Botman	Defence	2000-01-12	Netherlands
124683	67	Joe White	Defence	2002-10-01	England
168712	67	Valentino Livramento	Defence	2002-11-12	England
230364	67	Alex Murphy	Defence	2004-06-25	Ireland
1684	67	Bruno Guimarães	Midfield	1997-11-16	Brazil
2563	67	Sandro Tonali	Midfield	2000-05-08	Italy
4955	67	Sean Longstaff	Midfield	1997-10-30	England
6486	67	Alexander Isak	Midfield	1999-09-21	Sweden
7798	67	Joe Willock	Midfield	1999-08-20	England
7934	67	Jacob Murphy	Midfield	1995-02-24	England
8076	67	Harvey Barnes	Midfield	1997-12-09	England
76861	67	Miguel Almirón	Midfield	1994-02-10	Paraguay
107330	67	Elliot Anderson	Midfield	2002-11-06	Scotland
176852	67	Lewis Hall	Midfield	2004-09-08	England
177513	67	Lucas De Bolle	Midfield	2002-10-22	Scotland
204719	67	Travis Hernes	Midfield	2005-11-04	England
243652	67	James Huntley	Midfield	2004-03-02	England
7848	67	Anthony Gordon	Offence	2001-02-24	England
8251	67	Callum Wilson	Offence	1992-02-27	England
10653	67	Joelinton	Offence	1996-08-14	Brazil
181158	67	Garang Kuol	Offence	2004-09-15	Australia
191939	67	Lewis Miley	Offence	2006-05-01	England
228507	67	Ben Parkinson	Offence	2005-03-10	England
228508	67	Amadou Diallo	Offence	2003-02-15	England
7544	66	André Onana	Goalkeeper	1996-04-02	Cameroon
8035	66	Tom Heaton	Goalkeeper	1986-04-15	England
29518	66	Altay Bayındır	Goalkeeper	1998-04-14	Turkey
210730	66	Dermot Mee	Goalkeeper	2002-11-20	England
3326	66	Harry Maguire	Defence	1993-03-05	England
3360	66	Raphaël Varane	Defence	1993-04-25	France
3492	66	Victor Nilsson-Lindelöf	Defence	1994-07-17	Sweden
7467	66	Tyrell Malacia	Defence	1999-08-17	Netherlands
7898	66	Luke Shaw	Defence	1995-07-12	England
8014	66	Jonny Evans	Defence	1988-01-03	Northern Ireland
8158	66	Aaron Wan-Bissaka	Defence	1997-11-26	England
15905	66	Diogo Dalot	Defence	1999-03-18	Portugal
46451	66	Lisandro Martínez	Defence	1998-01-18	Argentina
244860	66	Willy Kambwala	Defence	2004-08-25	DR Congo
248978	66	Habeeb Ogunneye	Defence	2005-11-12	England
250886	66	Louis Jackson	Defence	2005-09-18	England
3231	66	Casemiro	Midfield	1992-02-23	Brazil
3257	66	Bruno Fernandes	Midfield	1994-09-08	Portugal
3459	66	Christian Eriksen	Midfield	1992-02-14	Denmark
3705	66	Sofyan Amrabat	Midfield	1996-08-21	Morocco
7599	66	Mason Mount	Midfield	1999-01-10	England
7905	66	Scott McTominay	Midfield	1996-12-08	Scotland
190797	66	Kobbie Mainoo	Midfield	2005-04-19	England
210150	66	Harry Amass	Midfield	2007-03-16	England
220574	66	Omari Forson	Midfield	2004-07-20	England
248734	66	Toby Collyer	Midfield	2004-01-03	England
3331	66	Marcus Rashford	Offence	1997-10-31	England
3372	66	Anthony Martial	Offence	1995-12-05	France
97085	66	Antony	Offence	2000-02-24	Brazil
133584	66	Amad Diallo	Offence	2002-07-11	Ivory Coast
152770	66	Rasmus Højlund	Offence	2003-02-04	Denmark
160846	66	Shola Shoretire	Offence	2004-02-02	Nigeria
250421	66	Ethan Wheatley	Offence	2006-01-20	England
3357	563	Alphonse Aréola	Goalkeeper	1993-02-27	France
3526	563	Łukasz Fabiański	Goalkeeper	1985-04-18	Poland
137390	563	Joseph Anang	Goalkeeper	2000-06-08	England
249553	563	Jacob Knightbridge	Goalkeeper	2004-01-25	England
3293	563	Edson Álvarez	Defence	1997-10-24	Mexico
7789	563	Konstantinos Mavropanos	Defence	1997-12-11	Greece
7809	563	Emerson	Defence	1994-08-03	Italy
7948	563	Kurt Zouma	Defence	1994-10-27	France
8201	563	Aaron Cresswell	Defence	1989-12-15	England
8202	563	Angelo Ogbonna	Defence	1988-05-23	Italy
8224	563	Ben Johnson	Defence	2000-01-24	England
15742	563	Tomáš Souček	Defence	1995-02-27	Czech Republic
62631	563	Vladimir Coufal	Defence	1992-08-22	Czech Republic
81191	563	Nayef Aguerd	Defence	1996-03-30	Morocco
1543	563	Lucas Paquetá	Midfield	1997-08-27	Brazil
4147	563	Kalvin Phillips	Midfield	1995-12-02	England
8088	563	James Ward-Prowse	Midfield	1994-11-01	England
8212	563	Michail Antonio	Midfield	1990-03-28	Jamaica
77399	563	Mohammed Kudus	Midfield	2000-08-02	Ghana
179657	563	Kamarai Simon-Swyer	Midfield	2002-12-04	England
188900	563	Oliver Scarles	Midfield	2005-12-12	England
191334	563	Levi Laing	Midfield	2003-04-12	England
209125	563	Kaelan Casey	Midfield	2004-10-28	England
209130	563	Lewis Orford	Midfield	2006-02-18	England
248957	563	George Earthy	Midfield	2004-09-05	England
7875	563	Danny Ings	Offence	1992-07-23	England
8471	563	Maxwel Cornet	Offence	1996-09-27	Ivory Coast
11414	563	Jarrod Bowen	Offence	1996-01-01	England
187380	563	Divin Mubama	Offence	2004-10-25	England
3884	354	Sam Johnstone	Goalkeeper	1993-03-25	England
5457	354	Dean Henderson	Goalkeeper	1997-03-12	England
182192	61	Diego Moreira	Offence	2004-08-06	Portugal
6413	354	Remi Matthews	Goalkeeper	1994-02-10	England
187229	354	Joe Whitworth	Goalkeeper	2004-02-29	England
2253	354	Joachim Andersen	Defence	1996-05-31	Denmark
7784	354	Rob Holding	Defence	1995-09-20	England
7863	354	Nathaniel Clyne	Defence	1991-04-05	England
8029	354	Nathan Ferguson	Defence	2000-10-06	England
8141	354	Joel Ward	Defence	1989-10-29	England
8144	354	James Tomkins	Defence	1989-03-29	England
8145	354	Jeffrey Schlupp	Defence	1992-12-23	Ghana
8147	354	Jaïro Riedewald	Defence	1996-09-09	Netherlands
22010	354	Daniel Muñoz	Defence	1996-05-26	Colombia
99856	354	Chris Richards	Defence	2000-03-28	USA
118489	354	Marc Guéhi	Defence	2000-07-13	England
137068	354	Tyrick Mitchell	Defence	1999-09-01	England
3737	354	Jefferson Lerma	Midfield	1994-10-25	Colombia
4032	354	Eberechi Eze	Midfield	1998-06-29	England
8124	354	Will Hughes	Midfield	1995-04-17	England
74677	354	Cheick Doucouré	Midfield	2000-01-08	Mali
113765	354	Michael Olise	Midfield	2001-12-12	France
131752	354	Naouirou Ahamada	Midfield	2002-03-29	France
179712	354	Jesurun Rak-Sakyi	Midfield	2002-10-05	England
180389	354	Adam Wharton	Midfield	2004-02-06	England
204522	354	David Ozoh	Midfield	2005-06-01	England
221789	354	Jadan Raymond	Midfield	2003-10-15	England
641	354	Jean-Philippe Mateta	Offence	1997-06-28	France
7984	354	Jordan Ayew	Offence	1991-09-11	Ghana
16077	354	Odsonne Edouard	Offence	1998-01-16	France
176241	354	Matheus Franca	Offence	2004-04-01	Brazil
247375	354	Franco Umeh	Offence	2005-01-26	Ireland
250297	354	Roshaun Mathurin	Offence	2004-01-23	England
4040	397	Jason Steele	Goalkeeper	1990-08-18	England
126870	397	Bart Verbruggen	Goalkeeper	2002-08-18	Netherlands
140203	397	Thomas McGill	Goalkeeper	2000-03-25	England
4228	397	Adam Webster	Defence	1995-01-04	England
7547	397	Joël Veltman	Defence	1992-01-15	Netherlands
7861	397	James Milner	Defence	1986-01-04	England
8259	397	Lewis Dunk	Defence	1991-11-21	England
10777	397	Igor	Defence	1998-02-07	Brazil
32642	397	Pervis Estupiñán	Defence	1998-01-21	Ecuador
98566	397	Jan Paul van Hecke	Defence	2000-06-08	Netherlands
133787	397	Tariq Lamptey	Defence	2000-09-30	Ghana
170261	397	Valentin Barco	Defence	2004-07-23	Argentina
175855	397	Odel Offiah	Defence	2002-10-26	England
240199	397	Benjamin Jackson	Defence	2003-09-03	England
244632	397	Leigh Kavanagh	Defence	2003-12-27	Ireland
252810	397	Noël Atom	Defence	2005-01-05	Germany
3318	397	Adam Lallana	Midfield	1988-05-10	England
8273	397	Pascal Groß	Midfield	1991-06-15	Germany
99952	397	Jakub Moder	Midfield	1999-04-07	Poland
126289	397	Billy Gilmour	Midfield	2001-06-11	Scotland
132707	397	Kaoru Mitoma	Midfield	1997-05-20	Japan
161365	397	Solly March	Midfield	1994-07-20	England
168949	397	Julio Enciso	Midfield	2004-01-23	Paraguay
178604	397	Carlos Baleba	Midfield	2004-01-03	Cameroon
184273	397	Facundo Buonanotte	Midfield	2004-12-23	Argentina
190851	397	Jack Hinshelwood	Midfield	2005-04-11	England
204449	397	Cameron Peupion	Midfield	2002-09-23	Australia
213692	397	Caylan Vickers	Midfield	2004-12-22	England
244662	397	Samy Chouchane	Midfield	2003-09-05	France
3328	397	Danny Welbeck	Offence	1990-11-26	England
103125	397	João Pedro	Offence	2001-09-26	Brazil
128040	397	Ansu Fati	Offence	2002-10-31	Spain
130809	397	Evan Ferguson	Offence	2004-10-19	Ireland
166249	397	Simon Adingra	Offence	2002-01-01	Ivory Coast
227761	397	Joshua Duffus	Offence	2004-12-15	England
230534	397	Mark O'Mahony	Offence	2005-01-14	Ireland
230535	397	Benicio Boaitey	Offence	2004-01-09	England
244609	397	Luca Barrington	Offence	2004-12-12	England
2788	1044	Ionuț Radu	Goalkeeper	1997-05-28	Romania
3221	1044	Neto	Goalkeeper	1989-07-19	Brazil
4203	1044	Darren Randolph	Goalkeeper	1987-05-12	Ireland
82135	1044	Mark Travers	Goalkeeper	1999-05-18	Ireland
189567	1044	Cameron Plain	Goalkeeper	2002-11-28	England
246451	1044	Callan McKenna	Goalkeeper	2006-12-22	Scotland
3966	1044	Ryan Fredericks	Defence	1992-10-10	England
4393	1044	Lloyd Kelly	Defence	1998-10-06	England
4427	1044	Chris Mepham	Defence	1997-11-05	Wales
8231	1044	Adam Smith	Defence	1991-04-29	England
46046	1044	Marcos Senesi	Defence	1997-05-10	Argentina
77596	1044	Tyler Adams	Defence	1999-02-14	USA
80765	1044	Max Aarons	Defence	2000-01-04	England
82145	1044	James Hill	Defence	2002-01-10	England
143573	1044	Illia Zabarnyi	Defence	2002-09-01	Ukraine
171141	1044	Milos Kerkez	Defence	2003-11-07	Hungary
191449	1044	Maxwell Kinsey-Wellings	Defence	2005-02-02	England
3327	1044	Lewis Cook	Midfield	1997-02-03	England
6396	1044	Marcus Tavernier	Midfield	1999-03-22	England
8184	1044	Philip Billing	Midfield	1996-06-11	Denmark
8762	1044	Romain Faivre	Midfield	1998-07-14	France
34495	1044	Ryan Christie	Midfield	1995-02-22	Scotland
177305	1044	Dango Ouattara	Midfield	2002-02-11	Burkina Faso
209103	1044	Dominic Sadi	Midfield	2003-09-02	England
209110	1044	Michael Dacosta Gonzalez	Midfield	2005-03-05	Spain
4417	1044	Antoine Semenyo	Offence	2000-01-07	Ghana
7561	1044	Justin Kluivert	Offence	1999-05-05	Netherlands
7878	1044	Dominic Solanke	Offence	1997-09-14	England
22040	1044	Luis Sinisterra	Offence	1999-06-17	Colombia
33132	1044	Enes Ünal	Offence	1997-05-10	Turkey
161088	1044	Alex Scott	Offence	2003-08-21	England
3174	63	Bernd Leno	Goalkeeper	1992-03-04	Germany
6445	63	Marek Rodák	Goalkeeper	1996-12-13	Slovakia
81055	63	Steven Benda	Goalkeeper	1998-10-01	Germany
1836	63	Timothy Castagne	Defence	1995-12-05	Belgium
3927	63	Antonee Robinson	Defence	1997-08-08	USA
3956	63	Tim Ream	Defence	1987-10-05	USA
7880	63	Tosin Adarabioyo	Defence	1997-09-24	England
8296	63	Issa Diop	Defence	1997-01-09	France
8403	63	Fodé Ballo-Touré	Defence	1997-01-03	Senegal
8460	63	Kenny Tete	Defence	1995-10-09	Netherlands
146154	63	Calvin Bassey	Defence	1999-12-31	Nigeria
217596	63	Luc De Fougerolles	Defence	2005-10-12	Canada
227998	63	Devan Tanton	Defence	2004-01-03	Colombia
3230	63	Willian	Midfield	1988-08-09	Brazil
3965	63	Tom Cairney	Midfield	1991-01-20	England
3995	63	Harrison Reed	Midfield	1995-01-27	England
4398	63	Bobby Reid	Midfield	1993-02-02	Jamaica
11777	63	Harry Wilson	Midfield	1997-03-22	Wales
15884	63	João Palhinha	Midfield	1995-07-09	Portugal
32938	63	Saša Lukić	Midfield	1996-08-13	Serbia
33153	63	Andreas Pereira	Midfield	1996-01-01	Brazil
189889	63	Kristian Sekularac	Midfield	2003-12-07	Switzerland
209084	63	Matthew Dibley-Dias	Midfield	2003-10-29	England
246418	63	Joshua King	Midfield	2007-01-03	England
3305	63	Raúl Jiménez	Offence	1991-05-05	Mexico
3392	63	Alex Iwobi	Offence	1996-05-03	Nigeria
4221	63	Adama Traoré	Offence	1996-01-25	Spain
138036	63	Rodrigo Muniz	Offence	2001-05-04	Brazil
143054	63	Armando Broja	Offence	2001-09-10	Albania
4418	76	Daniel Bentley	Goalkeeper	1993-07-13	England
6180	76	Thomas King	Goalkeeper	1995-03-09	Wales
15899	76	José Sá	Goalkeeper	1993-01-17	Portugal
4081	76	Matt Doherty	Defence	1992-01-16	Ireland
8012	76	Craig Dawson	Defence	1990-05-06	England
8642	76	Rayan Aït Nouri	Defence	2001-06-06	Algeria
15862	76	Nélson Semedo	Defence	1993-11-16	Portugal
25376	76	Max Kilman	Defence	1997-05-23	England
32767	76	Santiago Bueno	Defence	1998-11-09	Uruguay
102223	76	Toti Gomes	Defence	1999-01-16	Portugal
157709	76	Hugo Bueno	Defence	2002-09-18	Spain
189479	76	Harvey Griffiths	Defence	2003-09-22	England
244625	76	Matthew Whittingham	Defence	2004-10-24	England
245356	76	Aaron Keto-Diyawa	Defence	2003-09-11	England
249060	76	Wesley Okoduwa	Defence	2008-05-12	England
788	76	Jean-Ricner Bellegarde	Midfield	1998-06-27	France
8097	76	Mario Lemina	Midfield	1993-09-01	Gabon
133553	76	Boubacar Traoré	Midfield	2001-08-20	Mali
135345	76	Tawanda Chirewa	Midfield	2003-10-11	England
138034	76	João Gomes	Midfield	2001-02-12	Brazil
172581	76	Tommy Doyle	Midfield	2001-10-17	England
193014	76	Enso Gonzalez	Midfield	2005-01-20	Paraguay
245046	76	Ty Barnett	Midfield	2005-07-19	England
250791	76	Temple Ojinnaka	Midfield	2005-03-30	England
74	76	Pablo Sarabia	Offence	1992-05-11	Spain
2074	76	Pedro Neto	Offence	2000-03-09	Portugal
3354	76	Hwang Heechan	Offence	1996-01-26	South Korea
30842	76	Matheus Cunha	Offence	1999-05-27	Brazil
189575	76	Nathan Fraser	Offence	2005-02-22	England
217617	76	Noha Lemina	Offence	2005-06-17	France
249354	76	Leon Chiwome	Offence	2006-01-10	England
249571	76	Fletcher Holman	Offence	2004-10-12	England
3309	62	Jordan Pickford	Goalkeeper	1994-03-07	England
4133	62	Andy Lonergan	Goalkeeper	1983-10-19	England
5316	62	Billy Crellin	Goalkeeper	2000-06-30	England
82207	62	João Virgínia	Goalkeeper	1999-10-10	Portugal
3316	62	James Tarkowski	Defence	1992-11-19	England
3317	62	Ashley Young	Defence	1985-07-09	England
5487	62	Ben Godfrey	Defence	1998-01-15	England
7829	62	Michael Keane	Defence	1993-01-11	England
7836	62	Séamus Coleman	Defence	1988-10-11	Ireland
16165	62	Vitalii Mykolenko	Defence	1999-05-29	Ukraine
114120	62	Jarrad Branthwaite	Defence	2002-06-27	England
138174	62	Nathan Patterson	Defence	2001-10-16	Scotland
3251	62	André Gomes	Midfield	1993-07-30	Portugal
3324	62	Dele Alli	Midfield	1996-04-11	England
3627	62	Idrissa Gana Guèye	Midfield	1989-09-26	Senegal
4220	62	Jack Harrison	Midfield	1996-11-20	England
8119	62	Abdoulaye Doucouré	Midfield	1993-01-01	Mali
11623	62	Dwight McNeil	Midfield	1999-11-22	England
101076	62	James Garner	Midfield	2001-03-13	England
114024	62	Amadou Onana	Midfield	2001-08-16	Belgium
157660	62	Tyler Onyango	Midfield	2003-03-04	England
172958	62	Lewis Dobbin	Midfield	2003-01-03	England
177380	62	Lewis Warrington	Midfield	2002-10-10	England
220673	62	Mackenzie Hunt	Midfield	2001-11-14	England
244820	62	Jenson Metcalfe	Midfield	2004-09-06	England
7839	62	Dominic Calvert-Lewin	Offence	1997-03-16	England
9870	62	Arnaut Danjuma	Offence	1997-01-31	Netherlands
125044	62	Beto	Offence	1998-01-31	Portugal
188082	62	Youssef Chermiti	Offence	2004-05-24	Portugal
2050	402	Thomas Strakosha	Goalkeeper	1995-03-19	Albania
4419	402	Ellery Balcombe	Goalkeeper	1999-10-15	England
9923	402	Mark Flekken	Goalkeeper	1993-06-13	Netherlands
144530	402	Hákon Rafn Valdimarsson	Goalkeeper	2001-10-13	Iceland
176806	402	Vincent Angelini	Goalkeeper	2003-09-12	Scotland
4334	402	Ethan Pinnock	Defence	1993-05-29	Jamaica
4426	402	Rico Henry	Defence	1997-07-08	England
15535	402	Mads Roerslev	Defence	1999-06-24	Denmark
16068	402	Kristoffer Ajer	Defence	1998-04-17	Norway
51116	402	Reguilón	Defence	1996-12-16	Spain
101111	402	Aaron Hickey	Defence	2002-01-01	Scotland
115642	402	Nathan Collins	Defence	2001-04-30	Ireland
167115	402	Ben Mee	Defence	1989-09-21	England
179731	402	Zanka	Defence	1990-04-23	Denmark
221783	402	Ji-soo Kim	Defence	2004-12-24	South Korea
245364	402	Benjamin Fredrick	Defence	2005-05-28	Nigeria
249409	402	Benjamin Arthur	Defence	2005-01-01	England
8626	402	Bryan Mbeumo	Midfield	1999-08-07	Cameroon
10000	402	Vitaly Janelt	Midfield	1998-05-10	Germany
10194	402	Mathias Jensen	Midfield	1996-01-01	Denmark
24102	402	Christian Nørgaard	Midfield	1994-03-10	Denmark
24210	402	Frank Onyeka	Midfield	1998-01-01	Nigeria
56666	402	Shandon Baptiste	Midfield	1998-04-08	Grenada
131892	402	Ethan Brierley	Midfield	2003-11-23	England
188818	402	Ryan Trevitt	Midfield	2003-03-12	England
204421	402	Yegor Yarmolyuk	Midfield	2004-03-01	Ukraine
214532	402	Yunus Konak	Midfield	2006-01-10	Turkey
612	402	Yoane Wissa	Offence	1996-09-03	DR Congo
4443	402	Neal Maupay	Offence	1996-08-14	France
5453	402	Ivan Toney	Offence	1996-03-16	England
7796	402	Josh Dasilva	Offence	1998-10-23	England
24238	402	Mikkel Damsgaard	Offence	2000-07-03	Denmark
101910	402	Keane Lewis-Potter	Offence	2001-02-22	England
123286	402	Kevin Schade	Offence	2001-11-27	Germany
179746	402	Saman Ghoddos	Offence	1993-09-06	Iran
229276	402	Valentin Adedokun	Offence	2003-02-14	Ireland
3643	351	Matz Sels	Goalkeeper	1992-02-26	Belgium
8137	351	Wayne Hennessey	Goalkeeper	1987-01-24	Wales
42871	351	Odisseas Vlachodimos	Goalkeeper	1994-04-26	Greece
76936	351	Matt Turner	Goalkeeper	1994-06-24	USA
3386	351	Ola Aina	Defence	1996-10-08	Nigeria
4086	351	Willy Boly	Defence	1991-02-03	Ivory Coast
4376	351	Harry Toffolo	Defence	1995-08-19	England
5435	351	Ryan Yates	Defence	1997-11-21	England
8723	351	Moussa Niakhaté	Defence	1996-03-08	France
11667	351	Gonzalo Montiel	Defence	1997-01-01	Argentina
80459	351	Nuno Tavares	Defence	2000-01-26	Portugal
133765	351	Neco Williams	Defence	2001-04-13	Wales
149920	351	Andrew Omobamidele	Defence	2002-06-23	Ireland
192637	351	Murillo	Defence	2002-07-04	Brazil
204483	351	Zach Abbott	Defence	2006-05-13	England
3618	351	Cheikhou Kouyaté	Midfield	1989-12-21	Senegal
4091	351	Morgan Gibbs-White	Midfield	2000-01-27	England
8244	351	Harry Arter	Midfield	1989-12-28	Ireland
8307	351	Ibrahim Sangaré	Midfield	1997-12-02	Ivory Coast
46346	351	Nicolás Domínguez	Midfield	1998-06-28	Argentina
149704	351	Danilo dos Santos de Oliveira	Midfield	2001-04-29	Brazil
166376	351	Anthony Elanga	Midfield	2002-04-27	Sweden
246096	351	Jamie McDonnell	Midfield	2004-02-16	Northern Ireland
3663	351	Divock Origi	Offence	1995-04-18	Belgium
7816	351	Callum Hudson-Odoi	Offence	2000-11-07	England
8057	351	Chris Wood	Offence	1991-12-07	New Zealand
9218	351	Taiwo Awoniyi	Offence	1997-08-12	Nigeria
136733	351	Gio Reyna	Offence	2002-11-13	USA
156959	351	Luis Felipe Monteiro	Offence	1989-05-16	Brazil
178772	351	Rodrigo Ribeiro	Offence	2005-04-28	Portugal
190928	351	Detlef Osong	Offence	2004-09-21	England
245459	351	Joe Gardner	Offence	2005-06-06	England
4328	389	Jack Walton	Goalkeeper	1998-04-23	England
5597	389	James Shea	Goalkeeper	1991-06-16	England
8258	389	Tim Krul	Goalkeeper	1988-04-03	Netherlands
8991	389	Thomas Kamiński	Goalkeeper	1992-10-23	Belgium
3928	389	Reece Burke	Defence	1996-09-02	England
4842	389	Amari'i Bell	Defence	1994-05-05	Jamaica
5123	389	Tom Lockyer	Defence	1994-12-03	Wales
5600	389	Daniel Potts	Defence	1994-04-13	England
24058	389	Mads Juel Andersen	Defence	1997-12-27	Denmark
46751	389	Gabriel Osho	Defence	1998-08-14	England
48834	389	Daiki Hashioka	Defence	1999-05-17	Japan
80781	389	Alfie Doughty	Defence	1999-12-21	England
123574	389	Issa Kaboré	Defence	2001-05-12	Burkina Faso
136352	389	Teden Mengi	Defence	2002-04-30	England
209101	389	Joseph Johnson	Defence	2001-04-14	England
250390	389	Christian Chigozie	Defence	2007-03-01	England
4378	389	Fred Onyedinma	Midfield	1996-11-24	Nigeria
4440	389	Chiedozie Ogbene	Midfield	1997-05-01	Ireland
5623	389	Luke Berry	Midfield	1992-07-12	England
7817	389	Ross Barkley	Midfield	1993-12-05	England
8157	389	Andros Townsend	Midfield	1991-07-16	England
8862	389	Albert Sambi Lokonga	Midfield	1999-10-22	Belgium
8885	389	Marvelous Nakamba	Midfield	1994-10-19	Zimbabwe
98483	389	Tahith Chong	Midfield	1999-12-04	Netherlands
170448	389	Pelly-Ruddock Mpanzu	Midfield	1994-03-22	DR Congo
177300	389	Elliot Thorpe	Midfield	2000-11-09	Wales
209111	389	Zack Nelson	Midfield	2005-04-21	England
209134	389	Axel Piesold	Midfield	2005-03-31	England
249541	389	Dominic Martins	Midfield	2005-10-13	Portugal
4413	389	Cauley Woodrow	Offence	1994-12-02	England
5483	389	Carlton Morris	Offence	1995-12-16	England
5552	389	Jacob Brown	Offence	1998-04-10	Scotland
6240	389	Jordan Clark	Offence	1993-09-22	England
58085	389	Elijah Adebayo	Offence	1998-01-07	England
220613	389	Taylan Harris	Offence	2005-10-30	England
37144	328	Lawrence Vigouroux	Goalkeeper	1993-11-19	Chile
81179	328	Arijanet Muric	Goalkeeper	1998-11-07	Kosovo
153874	328	James Trafford	Goalkeeper	2002-10-10	England
1239	328	Vitinho	Defence	1999-07-23	Brazil
6678	328	Louis Beyer	Defence	2000-05-19	Germany
8043	328	Charlie Taylor	Defence	1993-09-18	England
8845	328	Hannes Delcroix	Defence	1999-02-28	Belgium
25650	328	Dara O'Shea	Defence	1999-03-04	Ireland
31560	328	Hjalmar Ekdal	Defence	1998-10-21	Sweden
135485	328	Lorenz Assignon	Defence	2000-06-22	France
170857	328	Ameen Al Dakhil	Defence	2002-03-06	Belgium
175784	328	Maxime Estève	Defence	2002-05-26	France
3839	328	Jóhann Berg Guðmundsson	Midfield	1990-10-27	Iceland
4401	328	Josh Brownhill	Midfield	1995-12-19	England
8051	328	Jack Cork	Midfield	1989-06-25	England
8092	328	Nathan Redmond	Midfield	1994-03-06	England
8217	328	Josh Cullen	Midfield	1996-04-07	Ireland
8973	328	Sander Berge	Midfield	1998-02-14	Norway
8976	328	Benson Manuel	Midfield	1997-03-28	Belgium
9405	328	Jacob Bruun Larsen	Midfield	1998-09-19	Denmark
98953	328	Han-Noah Massengo	Midfield	2001-07-07	France
122313	328	Zeki Amdouni	Midfield	2000-12-04	Switzerland
172555	328	Aaron Ramsey	Midfield	2003-01-21	England
184999	328	Wilson Odobert	Midfield	2004-11-28	France
192680	328	Enock Agyei	Midfield	2005-01-13	Belgium
207566	328	Mike Trésor	Midfield	1999-05-28	Belgium
8032	328	Jay Rodriguez	Offence	1989-07-29	England
34760	328	Lyle Foster	Offence	2000-09-04	South Africa
160849	328	David Fofana	Offence	2002-12-22	Ivory Coast
4327	356	Adam Davies	Goalkeeper	1992-07-17	Wales
23699	356	Ivo Grbić	Goalkeeper	1996-01-18	Croatia
34907	356	Wesley Foderingham	Goalkeeper	1991-01-14	England
186507	356	Jordan Amissah	Goalkeeper	2001-08-02	Germany
4013	356	Jack Robinson	Defence	1993-09-01	England
4184	356	Jayden Bogle	Defence	2000-07-27	England
4295	356	Chris Basham	Defence	1988-07-20	England
4305	356	Rhys Norrington-Davies	Defence	1999-04-22	Wales
4313	356	George Baldock	Defence	1993-03-09	Greece
4425	356	John Egan	Defence	1992-10-20	Ireland
5469	356	Max Lowe	Defence	1997-05-11	England
7826	356	Mason Holgate	Defence	1996-10-22	England
25615	356	Anel Ahmedhodzic	Defence	1999-03-26	Bosnia-Herzegovina
77185	356	Auston Trusty	Defence	1998-08-12	USA
133766	356	Yasser Larouci	Defence	2001-01-01	France
184462	356	Sam Curtis	Defence	2005-12-01	Ireland
245341	356	Evan Easton	Defence	2005-01-14	Scotland
248774	356	Dovydas Sasnauskas	Defence	2007-01-01	Lithuania
3972	356	Oliver Norwood	Midfield	1991-04-12	Northern Ireland
7837	356	Tom Davies	Midfield	1998-06-30	England
9623	356	Gustavo Hamer	Midfield	1997-06-24	Netherlands
11296	356	Ben Osborn	Midfield	1994-08-05	England
115078	356	Vinícius Souza	Midfield	1999-06-17	Brazil
141826	356	Anis Ben Slimane	Midfield	2001-03-16	Tunisia
172956	356	James McAtee	Midfield	2002-10-18	England
178019	356	Ollie Arblaster	Midfield	2004-05-05	England
188408	356	Andre Brooks	Midfield	2003-08-20	England
210648	356	Sydie Peck	Midfield	2004-09-13	England
250929	356	Owen Hampson	Midfield	2004-11-17	England
4359	356	Oliver McBurnie	Offence	1996-06-04	Scotland
7877	356	Rhian Brewster	Offence	2000-04-01	England
11300	356	Ben Brereton	Offence	1999-04-18	Chile
128242	356	Cameron Archer	Offence	2001-07-21	England
169191	356	Daniel Jebbison	Offence	2003-07-11	England
169324	356	William Osula	Offence	2003-08-04	England
190938	356	Louie Marsh	Offence	2003-10-16	England
226992	356	Ryan Oné	Offence	2006-06-26	Scotland
247247	356	Billy Blacker	Offence	2006-05-25	England
7015	1	Matthias Köbbing	Goalkeeper	1997-05-28	Germany
9957	1	Marvin Schwäbe	Goalkeeper	1995-04-25	Germany
10016	1	Philipp Pentke	Goalkeeper	1985-05-01	Germany
184977	1	Jonas Nickisch	Goalkeeper	2004-05-21	Germany
186	1	Dominique Heintz	Defence	1993-08-15	Germany
309	1	Timo Hübers	Defence	1996-07-20	Germany
7748	1	Julian Chabot	Defence	1998-02-12	Germany
9539	1	Benno Schmitz	Defence	1994-11-17	Germany
10053	1	Leart Paqarada	Defence	1994-10-08	Kosovo
75707	1	Luca Kilian	Defence	1999-09-01	Germany
114759	1	Rasmus Carstensen	Defence	2000-10-11	Denmark
187998	1	Rijad Smajic	Defence	2004-05-02	Bosnia-Herzegovina
191221	1	Elias Bakatukanda	Defence	2004-04-13	Germany
214538	1	Max Finkgräfe	Defence	2004-03-27	Germany
327	1	Linton Maina	Midfield	1999-06-23	Germany
9453	1	Florian Kainz	Midfield	1992-10-24	Austria
10656	1	Dejan Ljubicic	Midfield	1997-10-08	Austria
58306	1	Florian Dietz	Midfield	1998-08-03	Germany
72537	1	Jacob Christensen	Midfield	2001-06-25	Denmark
150087	1	Denis Huseinbasic	Midfield	2001-07-03	Germany
152726	1	Eric Martel	Midfield	2002-04-29	Germany
319	1	Mark Uth	Offence	1991-08-24	Germany
6537	1	Gian-Luca Waldschmidt	Offence	1996-05-19	Germany
6570	1	Davie Selke	Offence	1995-01-20	Germany
10039	1	Sargis Adamyan	Offence	1993-05-23	Armenia
10561	1	Steffen Tigges	Offence	1998-07-31	Germany
128740	1	Faride Alidou	Offence	2001-07-18	Germany
137031	1	Jan Thielmann	Offence	2002-05-26	Germany
185185	1	Damion Downs	Offence	2004-07-06	Germany
191186	1	Justin Diehl	Offence	2004-11-27	Germany
316	2	Oliver Baumann	Goalkeeper	1990-06-02	Germany
75703	2	Luca Philipp	Goalkeeper	2000-11-28	Germany
169319	2	Nahuel Noll	Goalkeeper	2003-03-17	Germany
315	2	Kevin Akpoguma	Defence	1995-04-19	Nigeria
317	2	Pavel Kadeřábek	Defence	1992-04-25	Czech Republic
9417	2	John Brooks	Defence	1993-01-28	USA
30548	2	Ozan Kabak	Defence	2000-03-25	Turkey
136731	2	Melayro Bogarde	Defence	2002-05-28	Netherlands
146716	2	David Jurásek	Defence	2000-08-07	Czech Republic
150667	2	Marco John	Defence	2002-04-02	Germany
179901	2	Kasim Adams	Defence	1995-06-22	Ghana
203039	2	Stanley N'Soki	Defence	1999-04-09	France
213739	2	Tim Drexler	Defence	2005-03-06	Germany
326	2	Ihlas Bebou	Midfield	1994-04-23	Togo
399	2	Dennis Geiger	Midfield	1998-06-10	Germany
6836	2	Grischa Prömel	Midfield	1995-01-09	Germany
10195	2	Robert Skov	Midfield	1996-05-20	Denmark
65843	2	Anton Stach	Midfield	1998-11-15	Germany
116259	2	Finn Ole Becker	Midfield	2000-06-08	Germany
172574	2	Tom Bischof	Midfield	2005-06-28	Germany
177525	2	Bambase Conte	Midfield	2003-07-07	Germany
318	2	Andrej Kramarić	Offence	1991-06-19	Croatia
404	2	Florian Grillitsch	Offence	1995-08-07	Austria
7697	2	Wout Weghorst	Offence	1992-08-07	Netherlands
10724	2	Mërgim Berisha	Offence	1998-05-11	Germany
65441	2	Marius Bülter	Offence	1993-03-29	Germany
133903	2	Maximilian Beier	Offence	2002-10-17	Germany
248657	2	Max Moerstedt	Offence	2006-01-15	Germany
165	3	Niklas Lomb	Goalkeeper	1993-07-28	Germany
6696	3	Lukáš Hrádecký	Goalkeeper	1989-11-24	Finland
136350	3	Matej Kovar	Goalkeeper	2000-05-17	Czech Republic
149	3	Jonathan Tah	Defence	1996-02-11	Germany
8148	3	Timothy Fosu-Mensah	Defence	1998-01-02	Netherlands
16739	3	Alejandro Grimaldo	Defence	1995-09-20	Spain
64713	3	Edmond Tapsoba	Defence	1999-02-02	Burkina Faso
122188	3	Josip Stanišić	Defence	2000-04-02	Croatia
125674	3	Piero Hincapié	Defence	2002-01-09	Ecuador
182267	328	Luca Koleosho	Midfield	2004-09-15	USA
128954	3	Jeremie Frimpong	Defence	2000-12-10	Netherlands
157596	3	Noah Mbamba	Defence	2005-01-05	Belgium
167098	3	Odilon Kossounou	Defence	2001-01-04	Ivory Coast
178860	3	Arthur Augusto	Defence	2003-03-17	Brazil
215496	3	Reno Münz	Defence	2005-10-02	Germany
3477	3	Granit Xhaka	Midfield	1992-09-27	Switzerland
6681	3	Jonas Hofmann	Midfield	1992-07-14	Germany
11720	3	Exequiel Palacios	Midfield	1998-10-05	Argentina
19334	3	Florian Wirtz	Midfield	2003-05-03	Germany
45611	3	Robert Andrich	Midfield	1994-09-22	Germany
137047	3	Amine Adli	Midfield	2000-05-10	France
185188	3	Ayman Aourir	Midfield	2004-10-06	Germany
191421	3	Gustavo Puerta	Midfield	2003-07-23	Colombia
1826	3	Patrik Schick	Offence	1996-01-24	Czech Republic
32056	3	Borja Iglesias	Offence	1993-01-17	Spain
99042	3	Adam Hložek	Offence	2002-07-25	Czech Republic
130811	3	Victor Boniface	Offence	2000-12-23	Nigeria
144715	3	Nathan Tella	Offence	1999-07-05	England
244862	3	Ken Izekor	Offence	2007-05-24	Germany
245832	3	Francis Onyeka	Offence	2007-04-29	Germany
334	4	Gregor Kobel	Goalkeeper	1997-12-06	Switzerland
9389	4	Alexander Meyer	Goalkeeper	1991-04-13	Germany
151077	4	Marcel Lotka	Goalkeeper	2001-05-25	Poland
176268	4	Silas Ostrzinski	Goalkeeper	2003-11-19	Germany
350	4	Mats Hummels	Defence	1988-12-16	Germany
351	4	Niklas Süle	Defence	1995-09-03	Germany
6714	4	Marius Wolf	Defence	1995-05-27	Germany
8805	4	Ramy Bensebaini	Defence	1995-04-16	Algeria
44030	4	Julian Ryerson	Defence	1997-11-17	Norway
58521	4	Antonios Papadopoulos	Defence	1999-09-10	Germany
75539	4	Nico Schlotterbeck	Defence	1999-12-01	Germany
120984	4	Mateu Morey	Defence	2000-03-02	Spain
131120	4	Ian Maatsen	Defence	2002-03-10	Netherlands
177664	4	Guille Bueno	Defence	2002-09-18	Spain
138	4	Marco Reus	Midfield	1989-05-31	Germany
146	4	Jadon Sancho	Midfield	2000-03-25	England
201	4	Salih Özcan	Midfield	1998-01-11	Turkey
3183	4	Emre Can	Midfield	1994-01-12	Germany
101074	4	Felix Kalu Nmecha	Midfield	2000-10-10	Germany
161415	4	Abdoulaye Kamara	Midfield	2004-11-06	Guinea
179460	4	Jamie Bynoe-Gittens	Midfield	2004-08-08	England
246628	4	Kjell Wätjen	Midfield	2006-02-16	Germany
148	4	Julian Brandt	Offence	1996-05-02	Germany
304	4	Niclas Füllkrug	Offence	1993-02-09	Germany
6721	4	Sébastien Haller	Offence	1994-06-22	Ivory Coast
7457	4	Donyell Malen	Offence	1999-01-19	Netherlands
9551	4	Marcel Sabitzer	Offence	1994-03-17	Austria
82515	4	Karim Adeyemi	Offence	2002-01-18	Germany
142162	4	Ole Pohlmann	Offence	2001-04-05	Germany
150817	4	Youssoufa Moukoko	Offence	2004-11-20	Germany
192607	4	Samuel Bamba	Offence	2004-02-13	Germany
244696	4	Paris Brunner	Offence	2006-02-15	Germany
341	5	Manuel Neuer	Goalkeeper	1986-03-27	Germany
342	5	Sven Ulreich	Goalkeeper	1988-08-03	Germany
113105	5	Daniel Peretz	Goalkeeper	2000-07-10	Israel
202603	5	Tom Hülsmann	Goalkeeper	2004-04-11	Germany
212846	5	Max Schmitt	Goalkeeper	2006-01-18	Germany
359	5	Joshua Kimmich	Defence	1995-02-08	Germany
3246	5	Raphaël Guerreiro	Defence	1993-12-22	Portugal
3314	5	Eric Dier	Defence	1994-01-15	England
7549	5	Matthijs de Ligt	Defence	1999-08-12	Netherlands
7553	5	Noussair Mazraoui	Defence	1997-11-14	Morocco
8353	5	Bouna Sarr	Defence	1992-01-31	Senegal
9541	5	Dayot Upamecano	Defence	1998-10-27	France
21288	5	Alphonso Davies	Defence	2000-11-02	Canada
114915	5	Sacha Boey	Defence	2000-09-13	France
168299	5	Min-Jae Kim	Defence	1996-11-15	South Korea
212013	5	Tarek Buchmann	Defence	2005-02-28	Germany
212842	5	Matteo Vinlöf	Defence	2005-12-18	Sweden
246476	5	Adam Aznou	Defence	2006-06-02	Morocco
311	5	Serge Gnabry	Midfield	1995-07-14	Germany
360	5	Kingsley Coman	Midfield	1996-06-13	France
3181	5	Leon Goretzka	Midfield	1995-02-06	Germany
9549	5	Konrad Laimer	Midfield	1997-05-27	Austria
144393	5	Jamal Musiala	Midfield	2003-02-26	Germany
183635	5	Lovro Zvonarek	Midfield	2005-05-08	Croatia
183731	5	Luca Denk	Midfield	2003-03-02	Germany
202588	5	Noel Aseko Nkili	Midfield	2005-11-22	Germany
202665	5	Aleksandar Pavlović	Midfield	2004-05-03	Germany
202693	5	Max Scholze	Midfield	2005-04-30	Germany
246474	5	Jonathan Asp-Jensen	Midfield	2006-01-14	Denmark
370	5	Thomas Müller	Offence	1989-09-13	Germany
3184	5	Leroy Sané	Offence	1996-01-11	Germany
7963	5	Maxim Choupo-Moting	Offence	1989-03-23	Cameroon
8004	5	Harry Kane	Offence	1993-07-28	England
171977	5	Mathys Tel	Offence	2005-04-27	France
180104	5	Bryan Zaragoza	Offence	2001-04-25	Spain
6491	10	Alexander Nübel	Goalkeeper	1996-09-30	Germany
6603	10	Fabian Bredlow	Goalkeeper	1995-03-02	Germany
150050	10	Florian Schock	Goalkeeper	2001-05-22	Germany
206327	10	Dennis Seimen	Goalkeeper	2005-12-01	Germany
379	10	Waldemar Anton	Defence	1996-07-20	Germany
6483	10	Dan-Axel Zagadou	Defence	1999-06-03	France
6523	10	Josha Vagnoman	Defence	2000-12-11	Germany
6549	10	Maximilian Mittelstädt	Defence	1997-03-18	Germany
9487	10	Pascal Stenzel	Defence	1996-03-20	Germany
48657	10	Hiroki Ito	Defence	1999-05-12	Japan
111071	10	Leonidas Stergiou	Defence	2002-03-03	Switzerland
150751	10	Anthony Rouault	Defence	2001-05-29	France
212232	10	Moussa Cissé	Defence	2003-04-29	France
215574	10	Anrie Chase	Defence	2004-03-24	Japan
158	10	Mahmoud Dahoud	Midfield	1996-01-01	Syria
190	10	Nikolas Nartey	Midfield	2000-02-22	Denmark
206	10	Chris Führich	Midfield	1998-01-09	Germany
3280	10	Genki Haraguchi	Midfield	1991-05-09	Japan
6982	10	Roberto Massimo	Midfield	2000-10-12	Germany
7079	10	Atakan Karazor	Midfield	1996-10-13	Germany
123333	10	Jamie Leweling	Midfield	2001-02-26	Germany
128565	10	Angelo Stiller	Midfield	2001-04-04	Germany
136132	10	Lilian Egloff	Midfield	2002-08-20	Germany
147913	10	Enzo Millot	Midfield	2002-07-17	France
186092	10	Laurin Ulrich	Midfield	2005-01-31	Germany
193091	10	Raul Paula	Midfield	1976-06-26	Germany
213730	10	Samuele di Benedetto	Midfield	2005-07-16	Germany
218454	10	Luca Raimund	Midfield	2005-04-09	Germany
211	10	Sehrou Guirassy	Offence	1996-03-12	Guinea
6928	10	Deniz Undav	Offence	1996-07-19	Germany
72432	10	Jeong Wooyeong	Offence	1999-09-20	South Korea
178640	10	Silas Katompa Mvumpa	Offence	1998-10-06	DR Congo
3642	11	Koen Casteels	Goalkeeper	1992-06-25	Belgium
10700	11	Pavao Pervan	Goalkeeper	1987-11-13	Austria
66421	11	Niklas Klinger	Goalkeeper	1995-10-13	Germany
2188	11	Rogério	Defence	1998-01-13	Brazil
6634	11	Ridle Baku	Defence	1998-04-08	Germany
8847	11	Sebastiaan Bornauw	Defence	1999-03-22	Belgium
8975	11	Joakim Mæhle	Defence	1997-05-20	Denmark
30886	11	Cédric Zesiger	Defence	1998-06-24	Switzerland
82351	11	Maxence Lacroix	Defence	2000-04-06	France
121664	11	Kilian Fischer	Defence	2000-10-12	Germany
153289	11	Moritz Jenz	Defence	1999-04-30	Germany
180431	11	Anders Børset	Defence	2006-02-22	Norway
244694	11	Kofi Amoako	Defence	2005-05-06	Germany
9423	11	Maximilian Arnold	Midfield	1994-05-27	Germany
9426	11	Yannick Gerhardt	Midfield	1994-03-13	Germany
15354	11	Mattias Svanberg	Midfield	1999-01-05	Sweden
23214	11	Lovro Majer	Midfield	1998-01-17	Croatia
122340	11	Aster Vranckx	Midfield	2002-10-04	Belgium
124324	11	Patrick Wimmer	Midfield	2001-05-30	Austria
127401	11	Jakub Kamiński	Midfield	2002-06-05	Poland
140414	11	Kevin Paredes	Midfield	2003-05-07	USA
252858	11	Bennit Bröger	Midfield	2006-07-01	Germany
7005	11	Kevin Behrens	Offence	1991-02-03	Germany
7568	11	Václav Černý	Offence	1997-10-17	Czech Republic
7892	11	Lukas Nmecha	Offence	1998-12-14	Germany
16335	11	Jonas Wind	Offence	1999-02-07	Denmark
124473	11	Amin Sarr	Offence	2001-03-11	Sweden
145057	11	Tiago Tomás	Offence	2002-06-16	Portugal
184970	11	Dzenan Pejcinovic	Offence	2005-02-15	Germany
9438	12	Michael Zetterer	Goalkeeper	1995-07-12	Germany
9441	12	Jiří Pavlenka	Goalkeeper	1992-04-14	Czech Republic
202975	12	Dudu	Goalkeeper	1999-02-10	Germany
226969	12	Spyros Angelidis	Goalkeeper	2005-01-28	Greece
3437	12	Miloš Veljković	Defence	1995-09-26	Serbia
6555	12	Mitchell Weiser	Defence	1994-04-21	Germany
6557	12	Niklas Stark	Defence	1995-04-14	Germany
9447	12	Marco Friedl	Defence	1998-03-16	Austria
10559	12	Felix Agu	Defence	1999-09-27	Germany
24097	12	Anthony Jung	Defence	1991-11-03	Germany
58282	12	Cimo Röcker	Defence	1994-01-21	Germany
66095	12	Amos Pieper	Defence	1998-01-17	Germany
153870	12	Julián Malatini	Defence	2001-05-31	Argentina
199	12	Leonardo Bittencourt	Midfield	1993-12-19	Germany
2263	12	Dawid Kownacki	Midfield	1997-03-14	Poland
9547	12	Naby Keïta	Midfield	1995-02-10	Guinea
9765	12	Senne Lynen	Midfield	1999-02-19	Belgium
10549	12	Christian Groß	Midfield	1989-02-08	Germany
16346	12	Romano Schmid	Midfield	2000-01-27	Austria
23925	12	Jens Stage	Midfield	1996-11-08	Denmark
122949	12	Justin Njinmah	Midfield	2000-11-15	Germany
192455	12	Leon Opitz	Midfield	2005-04-11	Germany
209770	12	Jakob Löpping	Midfield	2003-06-20	Germany
226	12	Marvin Ducksch	Offence	1994-03-07	Germany
93320	12	Olivier Deman	Offence	2000-04-06	Belgium
133547	12	Nick Woltemade	Offence	2002-02-14	Germany
145276	12	Isak Hansen-Aarøen	Offence	2004-08-22	Norway
178648	12	Skelly Alvero	Offence	2002-05-04	France
244925	12	Kein Sato	Offence	2001-07-11	Japan
250347	12	Joel Imasuen	Offence	2004-10-27	USA
6616	15	Robin Zentner	Goalkeeper	1994-10-28	Germany
6985	15	Daniel Batz	Goalkeeper	1991-01-12	Germany
170064	15	Lasse Rieß	Goalkeeper	2001-07-27	Germany
2114	15	Silvan Widmer	Defence	1993-03-05	Switzerland
6576	15	Philipp Mwene	Defence	1994-01-29	Austria
6620	15	Stefan Bell	Defence	1991-08-24	Germany
6707	15	Danny da Costa	Defence	1993-07-13	Germany
7720	15	Sepp van den Berg	Defence	2001-12-20	Netherlands
8220	15	Edimilson Fernandes	Defence	1996-04-15	Switzerland
8785	15	Anthony Caci	Defence	1997-07-01	France
9994	15	Maxim Leitsch	Defence	1998-05-18	Germany
38394	15	Andreas Hanche-Olsen	Defence	1997-01-17	Norway
190422	15	Lasse Wilhelm	Defence	2003-03-20	Germany
248678	15	Maxim Dal	Defence	2006-01-26	Germany
152	15	Dominik Kohr	Midfield	1994-01-31	Germany
320	15	Nadiem Amiri	Midfield	1996-10-27	Germany
9424	15	Josuha Guilavogui	Midfield	1990-09-19	France
82403	15	Leandro Barreiro Martins	Midfield	2000-01-03	Luxembourg
99812	15	Tom Krauß	Midfield	2001-06-22	Germany
122717	15	David Mamutovic	Midfield	2000-12-05	Germany
150688	15	Matondo-Merveille Papela	Midfield	2001-01-18	Germany
177499	15	Eniss Shabani	Midfield	2003-05-29	Germany
179889	15	Jae-sung Lee	Midfield	1992-08-10	South Korea
213879	15	Tim Müller	Midfield	2004-09-23	Germany
723	15	Ludovic Ajorque	Offence	1994-02-25	France
6636	15	Karim Onisiwo	Offence	1992-03-17	Austria
6664	15	Marco Richter	Offence	1997-11-24	Germany
82404	15	Jonathan Burkardt	Offence	2000-07-11	Germany
123049	15	Jessic Ngankam	Offence	2000-07-20	Germany
172187	15	Marcus Muller	Offence	2002-08-20	Germany
184973	15	Nelson Weiper	Offence	2005-03-17	Germany
191102	15	Brajan Gruda	Offence	2004-05-31	Germany
6617	16	Finn Dahmen	Goalkeeper	1998-03-27	Germany
8799	16	Tomáš Koubek	Goalkeeper	1992-08-26	Czech Republic
202638	16	Marcel Lubik	Goalkeeper	2004-05-19	Germany
1566	16	Iago Borduchi	Defence	1997-03-23	Brazil
6643	16	Raphael Framberger	Defence	1995-09-06	Germany
6645	16	Jeffrey Gouweleeuw	Defence	1991-07-10	Netherlands
6677	16	Reece Oxford	Defence	1998-12-16	England
9430	16	Ohis Uduokhai	Defence	1997-09-09	Germany
16268	16	Kevin Mbabu	Defence	1995-04-19	Switzerland
24221	16	Mads Pedersen	Defence	1996-09-01	Denmark
64249	16	Robert Gumny	Defence	1998-06-04	Poland
67398	16	Patric Pfeiffer	Defence	1999-08-20	Germany
72477	16	Maximilian Bauer	Defence	2000-02-09	Germany
362	16	Niklas Dorsch	Midfield	1998-01-15	Germany
6562	16	Arne Maier	Midfield	1999-01-08	Germany
7264	16	Fredrik Jensen	Midfield	1997-09-09	Finland
9432	16	Elvis Rexhbecaj	Midfield	1997-11-01	Germany
23222	16	Kristijan Jakić	Midfield	1997-05-14	Croatia
121525	16	David Deger	Midfield	2000-02-13	Germany
147766	16	Arne Engels	Midfield	2003-09-08	Belgium
153915	16	Tim Breithaupt	Midfield	2002-02-07	Germany
157808	16	Daniel Hausmann	Midfield	2003-02-12	Germany
183682	16	Mahmut Kücüksahin	Midfield	2004-04-07	Germany
192654	16	Mert Kömür	Midfield	2005-07-17	Germany
209567	16	Pep Biel	Midfield	1996-09-05	Spain
31913	16	Ruben Vargas	Offence	1998-08-05	Switzerland
33242	16	Ermedin Demirovic	Offence	1998-03-25	Bosnia-Herzegovina
45590	16	Sven Michel	Offence	1990-07-15	Germany
45593	16	Phillip Tietz	Offence	1997-07-09	Germany
141308	16	Dion Drena Beljo	Offence	2002-03-01	Croatia
6614	17	Florian Müller	Goalkeeper	1997-11-13	Germany
6872	17	Benjamin Uphoff	Goalkeeper	1993-08-08	Germany
123287	17	Noah Atubolu	Goalkeeper	2002-05-25	Germany
171175	17	Niklas Sauter	Goalkeeper	2003-04-06	Germany
181745	17	Jaaso Jantunen	Goalkeeper	2005-01-31	Finland
3176	17	Matthias Ginter	Defence	1994-01-19	Germany
9472	17	Christian Günter	Defence	1993-02-28	Germany
9473	17	Lukas Kübler	Defence	1992-08-30	Germany
9474	17	Manuel Gulde	Defence	1991-02-12	Germany
9477	17	Philipp Lienhart	Defence	1996-07-11	Austria
63207	17	Attila Szalai	Defence	1998-01-20	Hungary
142790	17	Kiliann Sildillia	Defence	2002-05-16	France
171180	17	Kenneth Schmidt	Defence	2002-06-03	Germany
171186	17	Jordy Makengo	Defence	2001-08-03	France
171203	17	Max Rosenfelder	Defence	2003-02-10	Germany
6686	17	Vincenzo Grifo	Midfield	1993-04-07	Italy
6884	17	Florent Muslija	Midfield	1998-07-06	Kosovo
7531	17	Ritsu Doan	Midfield	1998-06-16	Japan
9452	17	Maximilian Eggestein	Midfield	1996-12-08	Germany
9485	17	Nicolas Höfler	Midfield	1990-03-09	Germany
16119	17	Roland Sallai	Midfield	1997-05-22	Hungary
60395	17	Chikwubuike Adamu	Midfield	2001-06-06	Austria
65681	17	Fabian Rüdlin	Midfield	1997-01-13	Germany
66114	17	Daniel-Kofi Kyereh	Midfield	1996-03-08	Ghana
97120	17	Yannik Keitel	Midfield	2000-02-15	Germany
98784	17	Ryan Johansson	Midfield	2001-02-15	Ireland
156552	17	Merlin Röhl	Midfield	2002-07-05	Germany
142	17	Maximilian Philipp	Offence	1994-03-01	Germany
6661	17	Michael Gregoritsch	Offence	1994-04-18	Austria
9501	17	Lucas Höler	Offence	1994-07-10	Germany
10254	17	Maximilian Breunig	Offence	2000-08-14	Germany
150689	17	Noah Weißhaupt	Offence	2001-09-20	Germany
177018	17	Mika Baur	Offence	2004-07-09	Germany
6667	18	Tobias Sippel	Goalkeeper	1988-03-22	Germany
6668	18	Moritz Nicolas	Goalkeeper	1997-10-21	Germany
30774	18	Jonas Omlin	Goalkeeper	1994-01-10	Switzerland
97458	18	Jan Jakob Olschowsky	Goalkeeper	2001-11-18	Germany
812	18	Jordan Siebatcheu	Defence	1996-04-26	USA
3475	18	Nico Elvedi	Defence	1996-09-30	Switzerland
6670	18	Tony Jantschke	Defence	1990-04-07	Germany
6672	18	Mamadou Doucouré	Defence	1998-05-21	France
6825	18	Marvin Friedrich	Defence	1995-12-13	Germany
7562	18	Maximilian Wöber	Defence	1998-02-04	Austria
16338	18	Stefan Lainer	Defence	1992-08-27	Austria
48902	18	Ko Itakura	Defence	1997-01-27	Japan
82442	18	Joseph Scally	Defence	2002-12-31	USA
144361	18	Luca Netz	Defence	2003-05-15	Germany
176307	18	Fabio Chiarodia	Defence	2005-06-05	Italy
187273	18	Lukas Ullrich	Defence	2004-03-16	Germany
191106	18	Simon Walde	Defence	2026-06-30	Germany
212854	18	Ibrahim Digberekou	Defence	2005-02-22	Belgium
144	18	Julian Weigl	Midfield	1995-09-08	Germany
400	18	Robin Hack	Midfield	1998-08-27	Germany
6680	18	Patrick Herrmann	Midfield	1991-02-12	Germany
6682	18	Christoph Kramer	Midfield	1991-02-19	Germany
9522	18	Florian Neuhaus	Midfield	1997-03-16	Germany
102395	18	Kouadio Koné	Midfield	2001-05-17	France
150517	18	Rocco Reitz	Midfield	2002-05-29	Germany
183637	18	Grant-Leon Ranos	Midfield	2003-07-20	Armenia
727	18	Franck Honorat	Offence	1996-08-11	France
4795	18	Jacob Italiano	Offence	2001-07-30	Australia
8443	18	Alassane Pléa	Offence	1993-03-10	France
62913	18	Tomáš Čvančara	Offence	2000-08-13	Czech Republic
98746	18	Nathan N'Goumou	Offence	2000-03-14	France
206426	18	Shio Fukuda	Offence	2004-04-08	Japan
3175	19	Kevin Trapp	Goalkeeper	1990-07-08	Germany
9387	19	Jens Grahl	Goalkeeper	1988-09-22	Germany
189482	19	Kaua	Goalkeeper	2003-04-11	Brazil
191130	19	Simon Simoni	Goalkeeper	2027-06-30	Albania
217389	19	Luke Gauer	Goalkeeper	2005-05-28	Germany
230048	19	Nils Ramming	Goalkeeper	2007-03-28	Sweden
3271	19	Makoto Hasebe	Defence	1984-01-18	Japan
6644	19	Philipp Max	Defence	1993-09-30	Germany
6701	19	Timmy Chandler	Defence	1990-03-29	USA
9181	19	Buta	Defence	1997-02-10	Portugal
9479	19	Robin Koch	Defence	1996-07-17	Germany
99357	19	Tuta	Defence	1999-07-04	Brazil
102967	19	Hrvoje Smolčić	Defence	2000-08-17	Croatia
114102	19	William Pacho	Defence	2001-10-16	Ecuador
116407	19	Eric Junior Dina Ebimbe	Defence	2000-11-21	France
133292	19	Niels Nkounkou	Defence	2000-11-01	France
171714	19	Nnamdi Collins	Defence	2004-01-10	Germany
203036	19	Dario Gebuhr	Defence	2003-05-06	Germany
205610	19	Davis Bautista	Defence	2005-02-16	Ecuador
213880	19	Elias Baum	Defence	2005-10-26	Germany
140	19	Mario Götze	Midfield	1992-06-03	Germany
3608	19	Ellyes Skhiri	Midfield	1995-05-10	Tunisia
6485	19	Sebastian Rode	Midfield	1990-10-11	Germany
7556	19	Donny van de Beek	Midfield	1997-04-18	Netherlands
140191	19	Noel Futkeu	Midfield	2002-12-06	Germany
169198	19	Sidney Raebiger	Midfield	2005-04-17	Germany
180563	19	Hugo Larsson	Midfield	2004-06-27	Sweden
182589	19	Mehdi Loune	Midfield	2004-05-14	Germany
185882	19	Jean Bahoya	Midfield	2005-05-07	France
212850	19	Harpreet Ghotra	Midfield	2003-01-17	Germany
250652	19	Marko Mladenovic	Midfield	2005-01-30	Serbia
10761	19	Saša Kalajdžić	Offence	1997-07-07	Austria
66896	19	Omar Marmoush	Offence	1999-02-07	Egypt
150860	19	Ansgar Knauff	Offence	2002-01-10	Germany
152454	19	Hugo Ekitike	Offence	2002-06-20	France
178658	19	Fares Chaïbi	Offence	2002-11-28	Algeria
189601	19	Nacho Ferri	Offence	2004-10-05	Spain
3450	28	Frederik Rønnow	Goalkeeper	1992-08-04	Denmark
6815	28	Jakob Busk	Goalkeeper	1993-09-12	Denmark
9469	28	Alexander Schwolow	Goalkeeper	1992-06-02	Germany
314	28	Kevin Vogt	Defence	1991-09-23	Germany
6828	28	Christopher Trimmel	Defence	1987-02-24	Austria
8369	28	Jérôme Roussillon	Defence	1993-01-06	France
9412	28	Robin Knoche	Defence	1992-05-22	Germany
9421	28	Paul Jaeckel	Defence	1998-07-22	Germany
23202	28	Josip Juranović	Defence	1995-08-16	Croatia
37796	28	Diogo Leite	Defence	1999-01-23	Portugal
67886	28	Danilho Doekhi	Defence	1998-06-30	Netherlands
240197	28	Oluwaseun Ogbemudia	Defence	2006-07-18	Germany
1847	28	Robin Gosens	Midfield	1994-07-05	Germany
6657	28	Rani Khedira	Midfield	1994-01-27	Germany
8465	28	Lucas Tousart	Midfield	1997-04-29	France
9489	28	Janik Haberer	Midfield	1994-04-02	Germany
62623	28	Alex Král	Midfield	1998-05-19	Czech Republic
72117	28	András Schafer	Midfield	1999-04-13	Hungary
72604	28	Aïssa Laïdouni	Midfield	1996-12-13	Tunisia
113262	28	Brenden Aaronson	Midfield	2000-10-22	USA
246150	28	Noah Engelbreth	Midfield	2005-06-12	Germany
247081	28	Tim Schleinitz	Midfield	2005-06-10	Germany
150	28	Kevin Volland	Offence	1992-07-30	Germany
9275	28	Chris Bédia	Offence	1996-03-05	Ivory Coast
77867	28	Mikkel Kaufmann	Offence	2001-01-03	Denmark
130880	28	Yorbe Vertessen	Offence	2001-01-08	Belgium
150647	28	Benedict Hollerbach	Offence	2001-05-17	Germany
324	36	Michael Esser	Goalkeeper	1987-11-22	Germany
6640	36	Andreas Luthe	Goalkeeper	1987-03-10	Germany
9984	36	Manuel Riemann	Goalkeeper	1988-09-09	Germany
249040	36	Hugo Rölleke	Goalkeeper	2005-05-06	Germany
401	36	Felix Passlack	Defence	1998-05-29	Germany
3513	36	Cristian Gamboa	Defence	1989-10-24	Costa Rica
8874	36	Erhan Mašović	Defence	1998-11-22	Serbia
9540	36	Bernardo	Defence	1995-05-14	Brazil
9897	36	Maximilian Wittek	Defence	1995-08-21	Germany
9990	36	Anthony Losilla	Defence	1986-03-10	France
9996	36	Danilo Soares	Defence	1991-10-29	Brazil
16468	36	Ivan Ordets	Defence	1992-07-08	Ukraine
50135	36	Noah Loosli	Defence	1997-01-23	Switzerland
56858	36	Keven Schlotterbeck	Defence	1997-04-28	Germany
80595	36	Niclas Thiede	Defence	1999-04-14	Germany
99287	36	Moritz Römling	Defence	2001-04-30	Germany
184968	36	Mohammed Tolba	Defence	2004-07-19	Germany
184979	36	Tim Oermann	Defence	2003-10-06	Germany
6807	36	Moritz Broschinski	Midfield	2000-09-23	Germany
9942	36	Lukas Daschner	Midfield	1998-10-01	Germany
9999	36	Kevin Stöger	Midfield	1993-08-27	Austria
10069	36	Philipp Förster	Midfield	1995-02-04	Germany
30302	36	Matúš Bero	Midfield	1995-09-06	Slovakia
45586	36	Christopher Antwi-Adjei	Midfield	1994-02-07	Ghana
120962	36	Patrick Osterhage	Midfield	2000-02-01	Germany
151089	36	Agon Elezi	Midfield	2001-03-01	North Macedonia
6927	36	Philipp Hofmann	Offence	1993-03-30	Germany
9408	36	Takuma Asano	Offence	1994-11-10	Japan
15919	36	Gonçalo Paciência	Offence	1994-08-01	Portugal
66107	36	Moritz-Broni Kwarteng	Offence	1998-04-28	Ghana
7013	44	Kevin Müller	Goalkeeper	1991-03-15	Germany
7014	44	Vitus Eicher	Goalkeeper	1990-11-05	Germany
143050	44	Paul Tschernuth	Goalkeeper	2002-01-20	Austria
179959	44	Frank Feller	Goalkeeper	2004-01-07	Germany
6484	44	Jan-Niklas Beste	Defence	1999-01-04	Germany
6826	44	Lennart Maloney	Defence	1999-10-08	USA
6879	44	Jonas Föhrenbach	Defence	1996-01-26	Germany
7022	44	Marnon-Thomas Busch	Defence	1994-12-08	Germany
7028	44	Norman Theuerkauf	Defence	1987-01-24	Germany
10028	44	Benedikt Gimber	Defence	1997-02-19	Germany
66088	44	Patrick Mainka	Defence	1994-11-06	Germany
67347	44	Haktab Traoré	Defence	1998-02-04	Germany
72462	44	Thomas Keller	Defence	1999-08-05	Germany
114649	44	Tim Siersleben	Defence	2000-03-09	Germany
212813	44	Seedy Jarju	Defence	2004-10-28	Gambia
7036	44	Kevin Sessa	Midfield	2000-07-06	Germany
67489	44	Jan Schöppner	Midfield	1999-06-12	Germany
75675	44	Adrian Beck	Midfield	1997-06-09	Germany
212841	44	Luka Janeš	Midfield	2004-01-19	Germany
7032	44	Nikola Dovedan	Offence	1994-07-06	Austria
7038	44	Denis Thomalla	Offence	1992-08-16	Germany
7106	44	Florian Pick	Offence	1995-09-08	Germany
9499	44	Tim Kleindienst	Offence	1995-08-31	Germany
10369	44	Stefan Schimmer	Offence	1994-04-28	Germany
75545	44	Marvin Pieringer	Offence	1999-10-04	Germany
82499	44	Christian Kühlwetter	Offence	1996-04-21	Germany
150733	44	Eren Dinkci	Offence	2001-12-13	Germany
184540	44	Elidon Qenaj	Offence	2003-05-22	Germany
203165	44	Christopher Negele	Offence	2005-04-11	Germany
7083	55	Alexander Brunst	Goalkeeper	1995-07-07	Germany
10050	55	Marcel Schuhen	Goalkeeper	1993-01-13	Germany
66101	55	Morten Behrens	Goalkeeper	1997-04-01	Germany
3985	55	Christoph Zimmermann	Defence	1993-01-12	Germany
6876	55	Matthias Bader	Defence	1997-06-17	Germany
9958	55	Jannik Müller	Defence	1994-01-18	Germany
10091	55	Fabian Holland	Defence	1990-07-11	Germany
56662	55	Thomas Isherwood	Defence	1998-01-28	Sweden
60239	55	Emir Karic	Defence	1997-06-09	Austria
137712	55	Christoph Klarer	Defence	2000-06-14	Austria
150810	55	Matej Maglica	Defence	1998-09-25	Croatia
170833	55	Clemens Riedel	Defence	2003-07-19	Germany
6630	55	Gerrit Holtmann	Midfield	1995-03-25	Philippines
7846	55	Fraser Hornby	Midfield	1999-09-13	Scotland
9934	55	Fabian Schnellhardt	Midfield	1994-01-12	Germany
10095	55	Tobias Kempe	Midfield	1989-06-27	Germany
10098	55	Marvin Mehlem	Midfield	1997-09-11	Germany
10825	55	Mathias Honsak	Midfield	1996-12-20	Austria
58511	55	Klaus Gjasula	Midfield	1989-12-14	Germany
66288	55	Julian Justvan	Midfield	1998-04-02	Germany
72504	55	Fabian Nürnberger	Midfield	1999-07-28	Germany
122265	55	Bartol Franjić	Midfield	2000-01-14	Croatia
123279	55	Andreas Müller	Midfield	2000-07-20	Germany
127873	55	Oscar Vilhelmsson	Midfield	2003-10-02	Sweden
250932	55	Asaf Arania	Midfield	2005-10-19	Israel
249	55	Aaron Seydel	Offence	1996-02-07	Germany
6842	55	Sebastian Polter	Offence	1991-04-01	Germany
7029	55	Tim Skarke	Offence	1996-09-07	Germany
58329	55	Braydon Manu	Offence	1997-03-28	Ghana
65567	55	Luca Pfeiffer	Offence	1996-08-20	Germany
184554	55	Fabio Torsiello	Offence	2005-02-02	Italy
6931	721	Janis Blaswich	Goalkeeper	1991-05-02	Germany
9533	721	Péter Gulácsi	Goalkeeper	1990-05-06	Hungary
45569	721	Leopold Zingerle	Goalkeeper	1994-04-10	Germany
186082	721	Timo Schlieck	Goalkeeper	2006-03-02	Germany
156	721	Benjamin Henrichs	Defence	1997-02-23	Germany
234	721	Christopher Lenz	Defence	1994-09-22	Germany
9536	721	Lukas Klostermann	Defence	1996-06-03	Germany
9537	721	Willi Orban	Defence	1992-11-03	Hungary
9905	721	David Raum	Defence	1998-04-22	Germany
116196	721	Mohamed Simakan	Defence	2000-05-03	France
170415	721	El Chadaille Bitshiabu	Defence	2005-05-16	France
171405	721	Castello Lukeba	Defence	2002-12-17	France
218429	721	Tim Köhler	Defence	2005-05-02	Germany
252832	721	Jonathan Norbye	Defence	2007-03-26	Norway
9550	721	Kevin Kampl	Midfield	1990-10-09	Slovenia
15704	721	Amadou Haïdara	Midfield	1998-01-31	Mali
16344	721	Xaver Schlager	Midfield	1997-09-28	Austria
23132	721	Dani Olmo	Midfield	1998-05-07	Spain
30629	721	Eljif Elmas	Midfield	1999-09-24	North Macedonia
56829	721	Christoph Baumgartner	Midfield	1999-08-01	Austria
113038	721	Nicolas  Seiwald	Midfield	2001-05-04	Austria
148289	721	Xavi Simons	Midfield	2003-04-21	Netherlands
246426	721	Nuha Jatta	Midfield	2006-03-15	Germany
3466	721	Yussuf Poulsen	Offence	1994-06-16	Denmark
73215	721	Loïs Openda	Offence	2000-02-16	Belgium
124244	721	Benjamin Šeško	Offence	2003-05-31	Slovenia
245825	721	Yannick Eduardo	Offence	2006-01-23	Netherlands
1767	98	Marco Sportiello	Goalkeeper	1992-05-10	Italy
1861	98	Antonio Mirante	Goalkeeper	1983-07-08	Italy
8390	98	Mike Maignan	Goalkeeper	1995-07-03	France
176943	98	Lapo Nava	Goalkeeper	2004-01-22	Italy
185551	98	Noah Raveyre	Goalkeeper	2005-06-22	France
227051	98	Andrea Bartoccioni	Goalkeeper	2004-03-14	Italy
251128	98	Lorenzo Torriani	Goalkeeper	2005-01-31	Italy
56	98	Simon Kjær	Defence	1989-03-26	Denmark
71	98	Theo Hernández	Defence	1997-10-06	France
1738	98	Davide Calabria	Defence	1996-12-06	Italy
1753	98	Matteo Gabbia	Defence	1999-10-21	Italy
1811	98	Alessandro Florenzi	Defence	1991-03-11	Italy
1833	98	Mattia Caldara	Defence	1994-05-05	Italy
11528	98	Fikayo Tomori	Defence	1997-12-19	England
141295	98	Pierre Kalulu	Defence	2000-06-05	France
142732	98	Malick Thiaw	Defence	2001-08-08	Germany
144950	98	Filippo Terracciano	Defence	2003-02-08	Italy
188876	98	Andrei Coubis	Defence	2003-09-29	Romania
215616	98	Davide Bartesaghi	Defence	2005-12-29	Italy
227048	98	Álex Jiménez	Defence	2005-05-08	Spain
229281	98	Jan-Carlo Simić	Defence	2005-05-02	Serbia
244943	98	Clinton Nsiala-Makengo	Defence	2004-01-17	France
145	98	Christian Pulisic	Midfield	1998-09-18	USA
7696	98	Tijjani Reijnders	Midfield	1998-07-29	Netherlands
8159	98	Ruben Loftus-Cheek	Midfield	1996-01-23	England
8489	98	Yacine Adli	Midfield	2000-07-29	France
16058	98	Noah Okafor	Midfield	2000-05-24	Switzerland
33124	98	Samuel Chukwueze	Midfield	1999-05-22	Nigeria
99013	98	Tommaso Pobega	Midfield	1999-07-15	Italy
150669	98	Yunus Musah	Midfield	2002-11-29	USA
215621	98	Kevin Zeroli	Midfield	2005-01-11	Italy
247120	98	Victor Eletu	Midfield	2005-04-01	Nigeria
2505	98	Ismael Bennacer	Offence	1997-12-01	Algeria
3371	98	Olivier Giroud	Offence	1986-09-30	France
6723	98	Luka Jović	Offence	1997-12-23	Serbia
15892	98	Rafael Leão	Offence	1999-06-10	Portugal
242550	98	Francesco Camarda	Offence	2008-03-10	Italy
251141	98	Diego Sia	Offence	2006-03-10	Italy
2476	99	Pietro Terracciano	Goalkeeper	1990-03-08	Italy
24293	99	Oliver Christensen	Goalkeeper	1999-03-22	Denmark
189622	99	Tommaso Martinelli	Goalkeeper	2006-01-06	Italy
192343	99	Tommaso Vannucchi	Goalkeeper	2007-03-05	Italy
1775	99	Nikola Milenković	Defence	1997-10-12	Serbia
1776	99	Cristiano Biraghi	Defence	1992-09-01	Italy
1778	99	Luca Ranieri	Defence	1999-04-23	Italy
2227	99	Davide Faraoni	Defence	1991-10-25	Italy
16474	99	Dodô	Defence	1998-11-17	Brazil
129801	99	Fabiano Parisi	Defence	2000-11-09	Italy
169309	99	Lucas Martínez Quarta	Defence	1996-05-10	Argentina
204348	99	Michael Kayode	Defence	2004-07-10	Italy
217391	99	Pietro Comuzzo	Defence	2005-02-20	Italy
250867	99	Christian Biagetti	Defence	2004-03-10	Italy
1148	99	Arthur	Midfield	1996-08-12	Brazil
1750	99	Giacomo Bonaventura	Midfield	1989-08-22	Italy
2129	99	Antonín Barák	Midfield	1994-12-03	Czech Republic
2194	99	Alfred Duncan	Midfield	1993-03-10	Ghana
2230	99	Rolando Mandragora	Midfield	1997-06-29	Italy
2676	99	Gaetano Castrovilli	Midfield	1997-02-17	Italy
8352	99	Maxime López	Midfield	1997-12-04	France
153979	99	Gino Infantino	Midfield	2003-05-19	Argentina
250893	99	Maat Daniel Caprini	Midfield	2006-02-11	France
251135	99	Niccolò Fortini	Midfield	2006-02-13	Italy
1792	99	Riccardo Sottil	Offence	1999-06-03	Italy
2298	99	Andrea Belotti	Offence	1993-12-20	Italy
2707	99	Christian Kouamé	Offence	1997-12-06	Ivory Coast
8381	99	Jonathan Ikoné	Offence	1998-05-02	France
45680	99	Nicolás González	Offence	1998-04-06	Argentina
98572	99	Lucas Beltrán	Offence	2001-06-23	Argentina
161370	99	M'Bala Nzola	Offence	1996-08-18	Angola
250887	99	Fallou Sene	Offence	2004-08-21	Senegal
3239	100	Rui Patrício	Goalkeeper	1988-02-15	Portugal
16735	100	Mile Svilar	Goalkeeper	1999-08-27	Serbia
150942	100	Pietro Boer	Goalkeeper	2002-05-12	Italy
245387	100	Renato Marin	Goalkeeper	2006-07-10	Brazil
9	100	Diego Llorente	Defence	1993-08-16	Spain
526	100	Evan N'Dicka	Defence	1999-08-20	Ivory Coast
1817	100	Rick Karsdorp	Defence	1995-02-11	Netherlands
1837	100	Gianluca Mancini	Defence	1996-04-17	Italy
1842	100	Leonardo Spinazzola	Defence	1993-03-25	Italy
7554	100	Rasmus Kristensen	Defence	1997-07-11	Denmark
7646	100	Angeliño	Defence	1997-01-04	Spain
7896	100	Chris Smalling	Defence	1989-11-22	England
29622	100	Zeki Çelik	Defence	1997-02-17	Turkey
120076	100	Martin Vetkal	Defence	2004-02-21	Estonia
177081	100	Jan Oliveras	Defence	2004-07-07	Spain
191727	100	Dean Huijsen	Defence	2005-04-14	Spain
244998	100	Matteo Plaia	Defence	2006-03-29	Italy
245043	100	Lovro Golič	Defence	2006-03-05	Slovenia
1819	100	Lorenzo Pellegrini	Midfield	1996-06-19	Italy
1844	100	Bryan Cristante	Midfield	1995-03-03	Italy
3214	100	Leandro Paredes	Midfield	1994-06-29	Argentina
8466	100	Houssem Aouar	Midfield	1998-06-30	Algeria
154031	100	Tommaso Baldanzi	Midfield	2003-03-23	Italy
156762	100	Edoardo Bove	Midfield	2002-05-16	Italy
192382	100	Niccolo Pisilli	Midfield	2004-09-23	Italy
206795	100	Riccardo Pagano	Midfield	2004-11-28	Italy
220608	100	Mattia Mannini	Midfield	2006-07-08	Italy
220609	100	Francesco D'Alessio	Midfield	2004-02-21	Italy
1823	100	Stephan El Shaarawy	Offence	1992-10-27	Italy
2046	100	Paulo Dybala	Offence	1993-11-15	Argentina
3662	100	Romelu Lukaku	Offence	1993-05-13	Belgium
3817	100	Sardar Azmoun	Offence	1995-01-01	Iran
7985	100	Tammy Abraham	Offence	1997-10-02	England
7988	100	Renato Sanches	Offence	1997-08-18	Portugal
152528	100	Nicola Zalewski	Offence	2002-01-23	Poland
177234	100	Filippo Alessio	Offence	2004-12-24	Italy
189399	100	Luigi Cherubini	Offence	2004-01-15	Italy
221388	100	João Costa	Offence	2005-03-28	Portugal
1830	102	Francesco Rossi	Goalkeeper	1991-04-27	Italy
46554	102	Juan Musso	Goalkeeper	1994-05-06	Argentina
102220	102	Marco Carnesecchi	Goalkeeper	2000-07-01	Italy
213170	102	Paolo Vismara	Goalkeeper	2003-03-28	Italy
1832	102	Rafael Tolói	Defence	1990-10-10	Italy
1835	102	Hans Hateboer	Defence	1994-01-09	Netherlands
7555	102	Mitchel Bakker	Defence	2000-06-20	Netherlands
7786	102	Sead Kolašinac	Defence	1993-06-20	Bosnia-Herzegovina
7807	102	Davide Zappacosta	Defence	1992-06-11	Italy
111777	102	Emil Holm	Defence	2000-05-13	Sweden
151241	102	Matteo Ruggeri	Defence	2002-07-11	Italy
153990	102	Giorgio Scalvini	Defence	2003-12-11	Italy
167031	102	Isak Hien	Defence	1999-01-13	Sweden
170381	102	Berat Djimsiti	Defence	2023-06-30	Albania
177598	102	Giovanni Bonfanti	Defence	2003-01-17	Italy
191664	102	Andrea Ceresoli	Defence	2003-03-25	Italy
206136	102	Marco Palestra	Defence	2005-03-03	Italy
207051	102	Tommaso Del Lungo	Defence	2004-04-20	Italy
213178	102	José Palomino	Defence	1990-01-05	Argentina
245244	102	Pietro Comi	Defence	2005-06-11	Italy
1848	102	Marten de Roon	Midfield	1991-03-29	Netherlands
3553	102	Mario Pašalić	Midfield	1995-02-09	Croatia
3681	102	Aleksei Miranchuk	Midfield	1995-10-17	Russia
7693	102	Teun Koopmeiners	Midfield	1998-02-28	Netherlands
81440	102	Éderson	Midfield	1999-07-07	Brazil
129947	102	Charles De Ketelaere	Midfield	2001-03-10	Belgium
157495	102	Alessandro Cortinovis	Midfield	2001-01-25	Italy
185019	102	Michel Adopo	Midfield	2000-07-19	France
202308	102	Leonardo Mendicino	Midfield	2006-06-25	Italy
204339	102	Matteo Colombo	Midfield	2004-03-09	Italy
244756	102	Alberto Manzoni	Midfield	2005-06-25	Italy
244973	102	Andrea Bonanomi	Midfield	2006-01-31	Italy
2681	102	Gianluca Scamacca	Offence	1999-01-01	Italy
9554	102	Ademola Lookman	Offence	1997-10-20	Nigeria
140773	102	El Bilal Touré	Offence	2001-10-03	Mali
177454	102	Tommaso De Nipoti	Offence	2003-07-23	Italy
178139	102	Moustapha Cisse	Offence	2003-09-14	Guinea
218571	102	Siren Diao	Offence	2005-01-21	Spain
1797	103	Łukasz Skorupski	Goalkeeper	1991-05-05	Poland
1862	103	Federico Ravaglia	Goalkeeper	1999-11-11	Italy
175889	103	Nicola Bagnolini	Goalkeeper	2004-03-14	Italy
217546	103	Tito Gasperini	Goalkeeper	2006-03-09	Italy
395	103	Stefan Posch	Defence	1997-05-14	Austria
1905	103	Babis Lykogiannis	Defence	1993-10-22	Greece
2292	103	Lorenzo De Silvestri	Defence	1988-05-23	Italy
8393	103	Adama Soumaoro	Defence	1992-06-18	France
16265	103	Michel Aebischer	Defence	1997-01-06	Switzerland
22113	103	Jhon Lucumí	Defence	1998-06-26	Colombia
53281	103	Sam Beukema	Defence	1998-11-17	Netherlands
133512	103	Riccardo Calafiori	Defence	2002-05-19	Italy
167140	103	Victor Kristiansen	Defence	2002-12-16	Denmark
167734	103	Wisdom Amey	Defence	2005-08-11	Italy
178152	103	Mihajlo Ilic	Defence	2003-06-04	Serbia
214554	103	Tommaso Corazza	Defence	2004-06-29	Italy
1841	103	Remo Freuler	Midfield	1992-04-15	Switzerland
8858	103	Alexis Saelemaekers	Midfield	1999-06-27	Belgium
23135	103	Nikola Moro	Midfield	1998-03-12	Croatia
34638	103	Lewis Ferguson	Midfield	1999-08-24	Scotland
137362	103	Kacper Urbanski	Midfield	2004-09-07	Poland
171123	103	Giovanni Fabbian	Midfield	2003-01-14	Italy
171286	103	Oussama El Azzouzi	Midfield	2001-05-29	Morocco
1886	103	Riccardo Orsolini	Offence	1997-01-24	Italy
2017	103	Jens Odgaard	Offence	1999-03-31	Denmark
31243	103	Jesper Karlsson	Offence	1998-07-25	Sweden
77641	103	Dan Ndoye	Offence	2000-10-25	Switzerland
99731	103	Joshua Zirkzee	Offence	2001-05-22	Netherlands
170891	103	Santiago Castro	Offence	2004-09-18	Argentina
217544	103	Tommaso Ravaglioli	Offence	2006-02-20	Italy
2108	104	Simone Scuffet	Goalkeeper	1996-05-31	Italy
2611	104	Boris Radunović	Goalkeeper	1996-05-26	Serbia
80481	104	Simone Aresti	Goalkeeper	1986-03-15	Italy
202717	104	Velizar Iliev	Goalkeeper	2005-07-20	Bulgaria
2831	104	Tommaso Augello	Defence	1994-08-30	Italy
3728	104	Yerry Mina	Defence	1994-09-23	Colombia
7676	104	Pantelís Chatzidiákos	Defence	1997-01-18	Greece
40265	104	Alberto Dossena	Defence	1998-10-13	Italy
59072	104	Mateusz Wieteska	Defence	1997-02-11	Poland
86122	104	Paulo Dentello	Defence	1994-07-15	Brazil
97787	104	Alessandro Di Pardo	Defence	1999-07-18	Italy
114052	104	Gabriele Zappa	Defence	1999-12-22	Italy
170374	104	Adam Obert	Defence	2002-08-23	Slovakia
1914	104	Alessandro Deiola	Midfield	1995-08-01	Italy
2128	104	Jakub Jankto	Midfield	1996-01-19	Czech Republic
2327	104	Nicolas Viola	Midfield	1989-10-12	Italy
3168	104	Nahitan Nández	Midfield	1995-12-28	Uruguay
42618	104	Marco Mancosu	Midfield	1988-08-22	Italy
76896	104	Antoine Makoumbou	Midfield	1998-07-18	Congo
102211	104	Gianluca Gaetano	Midfield	2000-05-05	Italy
166329	104	Matteo Prati	Midfield	2003-12-28	Italy
171586	104	Gaetano Oristanio	Midfield	2002-09-28	Italy
188791	104	Ibrahim Sulemana	Midfield	2003-05-22	Ghana
1854	104	Andrea Petagna	Offence	1995-06-30	Italy
1925	104	Leonardo Pavoletti	Offence	1988-11-26	Italy
1987	104	Gianluca Lapadula	Offence	1990-02-07	Peru
49307	104	Eldor Shomurodov	Offence	1995-06-29	Uzbekistan
171122	104	Zito Luvumbo	Offence	2002-03-09	Angola
246153	104	Kingstone Mutandwa	Offence	2003-01-05	Zambia
246156	104	Alessandro Vinciguerra	Offence	2005-08-18	Italy
2580	107	Nicola Leali	Goalkeeper	1993-02-17	Italy
75224	107	Daniele Sommariva	Goalkeeper	1997-07-18	Italy
76696	107	Franz Stolz	Goalkeeper	2001-02-14	Austria
101415	107	Josep Martinez	Goalkeeper	1998-05-27	Spain
227020	107	Simone Calvani	Goalkeeper	2005-10-01	Italy
1939	107	Mattia Bani	Defence	1993-12-10	Italy
2443	107	Stefano Sabelli	Defence	1993-01-13	Italy
7466	107	Ridgeciano Haps	Defence	1993-06-12	Suriname
32701	107	Aaron Martín	Defence	1997-04-22	Spain
39330	107	Johan Vásquez	Defence	1998-10-22	Mexico
80775	107	Djed Spence	Defence	2000-08-09	England
81998	107	Alessandro Vogliacco	Defence	1998-09-14	Italy
153556	107	Koni De Winter	Defence	2002-06-12	Belgium
176891	107	Giorgio Cittadini	Defence	2002-04-18	Italy
191042	107	Alan Matturro	Defence	2004-10-11	Uruguay
244673	107	Tommaso Pittino	Defence	2005-01-01	Italy
1779	107	Milan Badelj	Midfield	1989-02-25	Croatia
1812	107	Kevin Strootman	Midfield	1990-02-13	Netherlands
7421	107	Morten Thorsby	Midfield	1996-05-05	Norway
24119	107	Morten Frendrup	Midfield	2001-04-07	Denmark
38409	107	Emil Bohinen	Midfield	1999-03-12	Norway
179561	107	Ruslan Malinovskiy	Midfield	1993-05-04	Ukraine
242561	107	Christos Papadopoulos	Midfield	2004-11-01	Greece
244738	107	Riccardo Arboscello	Midfield	2005-12-10	Italy
3851	107	Albert Guðmundsson	Offence	1997-06-15	Iceland
4165	107	Caleb Ekuban	Offence	1994-03-23	Ghana
11710	107	Mateo Retegui	Offence	1999-04-29	Italy
97869	107	Junior Messias	Offence	1991-05-13	Brazil
178736	107	Vitinha	Offence	2000-03-15	Portugal
212573	107	David Ankeye	Offence	2002-05-22	Nigeria
228745	107	Yoan Bornosuzov	Offence	2004-01-09	Bulgaria
2819	108	Raffaele Di Gennaro	Goalkeeper	1993-10-03	Italy
3087	108	Emil Audero	Goalkeeper	1997-01-18	Italy
3470	108	Yann Sommer	Goalkeeper	1988-12-17	Switzerland
217713	108	Alessandro Calligaris	Goalkeeper	2005-03-07	Italy
193	108	Yann Aurel Bisseck	Defence	2000-11-29	Germany
1834	108	Alessandro Bastoni	Defence	1999-04-13	Italy
2037	108	Juan Cuadrado	Defence	1988-05-26	Colombia
2053	108	Stefan de Vrij	Defence	1992-02-05	Netherlands
2180	108	Francesco Acerbi	Defence	1988-02-10	Italy
3364	108	Benjamin Pavard	Defence	1996-03-28	France
7417	108	Denzel Dumfries	Defence	1996-04-18	Netherlands
7900	108	Matteo Darmian	Defence	1989-12-02	Italy
30821	108	Federico Dimarco	Defence	1997-11-10	Italy
167689	108	Carlos Augusto Lobaton	Defence	1999-01-07	Brazil
217910	108	Giacomo Stabile	Defence	2005-04-12	Italy
245198	108	Matteo Motta	Defence	2005-02-10	Italy
1754	108	Hakan Çalhanoğlu	Midfield	1994-02-08	Turkey
1911	108	Nicolò Barella	Midfield	1997-02-07	Italy
2197	108	Stefano Sensi	Midfield	1995-08-05	Italy
2200	108	Davide Frattesi	Midfield	1999-09-22	Italy
7795	108	Henrikh Mkhitaryan	Midfield	1989-01-21	Armenia
7841	108	Davy Klaassen	Midfield	1993-02-21	Netherlands
188920	108	Aleksandar Stankovic	Midfield	2005-08-03	Serbia
190998	108	Issiaka Kamate	Midfield	2004-08-02	France
206715	108	Ebenezer Akinsanmiro	Midfield	2004-11-25	Nigeria
3220	108	Lautaro Martínez	Offence	1997-08-22	Argentina
7911	108	Alexis Sánchez	Offence	1988-12-19	Chile
8223	108	Marko Arnautovic	Offence	1989-04-19	Austria
8685	108	Marcus Thuram-Ulien	Offence	1997-08-06	France
113175	108	Tajon Buchanan	Offence	1999-02-08	Canada
154733	108	Kristjan Asllani	Offence	2002-03-09	Albania
217581	108	Amadou Sarr	Offence	2004-06-28	Italy
1959	109	Mattia Perin	Goalkeeper	1992-11-10	Italy
2022	109	Wojciech Szczęsny	Goalkeeper	1990-04-18	Poland
2023	109	Carlo Pinsoglio	Goalkeeper	1990-03-16	Italy
156656	109	Giovanni Garofani	Goalkeeper	2002-10-20	Italy
189897	109	Simone Scaglia	Goalkeeper	2004-07-12	Italy
191638	109	Giovanni Daffara	Goalkeeper	2004-12-05	Italy
1106	109	Bremer	Defence	1997-03-18	Brazil
2027	109	Daniele Rugani	Defence	1994-07-29	Italy
2028	109	Alex Sandro	Defence	1991-01-26	Brazil
2030	109	Mattia De Sciglio	Defence	1992-10-20	Italy
7881	109	Danilo	Defence	1991-07-15	Brazil
37134	109	Tiago Djaló	Defence	2000-04-09	Portugal
124865	109	Andrea Cambiaso	Defence	2000-02-20	Italy
140269	109	Carlos Alcaraz	Defence	2002-11-30	Argentina
153130	109	Federico Gatti	Defence	1998-06-24	Italy
189153	109	Tarik Muharemović	Defence	2003-02-28	Bosnia-Herzegovina
246656	109	Pedro Felipe	Defence	2004-05-23	Brazil
1751	109	Manuel Locatelli	Midfield	1998-01-08	Italy
1780	109	Federico Chiesa	Midfield	1997-10-25	Italy
3366	109	Paul Pogba	Midfield	1993-03-15	France
3368	109	Adrien Rabiot	Midfield	1995-04-03	France
3446	109	Filip Kostić	Midfield	1992-11-01	Serbia
6507	109	Weston McKennie	Midfield	1998-08-28	USA
97879	109	Nicolò Fagioli	Midfield	2001-02-12	Italy
158893	109	Nikola Sekulov	Midfield	2002-02-18	Italy
161142	109	Fabio Miretti	Midfield	2003-08-03	Italy
191712	109	Kenan Yıldız	Midfield	2005-05-04	Turkey
202420	109	Joseph Boende	Midfield	2005-05-15	Belgium
217676	109	Luis Hasa	Midfield	2004-01-06	Italy
2105	109	Arkadiusz Milik	Offence	1994-02-28	Poland
2171	109	Moise Kean	Offence	2000-02-28	Italy
8492	109	Tim Weah	Offence	2000-02-22	USA
82002	109	Dušan Vlahović	Offence	2000-01-28	Serbia
97894	109	Hans Nicolussi Caviglia	Offence	2000-06-18	Italy
151247	109	Tommaso Mancini	Offence	2004-07-23	Italy
158895	109	Leonardo Cerri	Offence	2003-03-04	Italy
2083	110	Luigi Sepe	Goalkeeper	1991-05-08	Italy
2475	110	Ivan Provedel	Goalkeeper	1994-03-17	Italy
43190	110	Christos Mandas	Goalkeeper	2001-09-17	Greece
187110	110	Federico Magro	Goalkeeper	2005-01-10	Italy
192109	110	Davide Renzetti	Goalkeeper	2006-06-09	Italy
1740	110	Alessio Romagnoli	Defence	1995-01-12	Italy
1803	110	Luca Pellegrini	Defence	1999-03-07	Italy
2065	110	Patric	Defence	1993-04-17	Spain
2069	110	Adam Marušić	Defence	1992-10-17	Montenegro
2088	110	Elseid Hysaj	Defence	1994-02-02	Albania
2358	110	Manuel Lazzari	Defence	1993-11-29	Italy
56645	110	Nicolò Casale	Defence	1998-02-14	Italy
180139	110	Gila	Defence	2000-08-29	Spain
192110	110	Fabio Ruggeri	Defence	2004-12-13	Italy
600	110	Mattéo Guendouzi	Midfield	1999-04-14	France
2009	110	Matías Vecino	Midfield	1991-08-24	Uruguay
2060	110	Felipe Anderson	Midfield	1993-04-15	Brazil
2158	110	Mattia Zaccagni	Midfield	1995-06-16	Italy
2329	110	Danilo Cataldi	Midfield	1994-08-06	Italy
2331	110	Cristiano Lombardi	Midfield	1995-08-19	Italy
6716	110	Daichi Kamada	Midfield	1996-08-05	Japan
81941	110	Anderson Lima	Midfield	1999-09-23	Italy
111220	110	Nicolò Rovella	Midfield	2001-12-04	Italy
191417	110	Diego González	Midfield	2003-01-07	Paraguay
244837	110	Matteo Duțu	Midfield	2005-11-23	Romania
247079	110	Luca Napolitano	Midfield	2004-01-10	Italy
248090	110	Larsson Coulibaly	Midfield	2003-04-17	Ivory Coast
2076	110	Ciro Immobile	Offence	1990-02-20	Italy
2077	110	Luis Alberto	Offence	1992-11-28	Spain
7818	110	Pedro	Offence	1987-07-28	Spain
28416	110	Valentín Castellanos	Offence	1998-10-03	Argentina
128007	110	Gustav Isaksen	Offence	2001-04-19	Denmark
217916	110	Saná Fernandes	Offence	2006-03-10	Portugal
1829	113	Pierluigi Gollini	Goalkeeper	1995-03-18	Italy
2344	113	Alex Meret	Goalkeeper	1997-03-22	Italy
74378	113	Nikita Contini Baranovsky	Goalkeeper	1996-05-21	Italy
137818	113	Hubert Idasiak	Goalkeeper	2002-02-03	Poland
2090	113	Mário Rui	Defence	1991-05-27	Portugal
2386	113	Pasquale Mazzocchi	Defence	1995-07-27	Italy
2487	113	Giovanni Di Lorenzo	Defence	1993-08-04	Italy
23127	113	Amir Rrahmani	Defence	1994-02-24	Kosovo
32754	113	Mathías Olivera	Defence	1997-10-31	Uruguay
44032	113	Leo Østigård	Defence	1999-11-28	Norway
138031	113	Natan	Defence	2001-02-06	Brazil
161310	113	Juan Jesus	Defence	1991-06-10	Brazil
221253	113	Luigi D'Avino	Defence	2005-12-08	Italy
2097	113	Piotr Zieliński	Midfield	1994-05-20	Poland
2193	113	Matteo Politano	Midfield	1993-08-03	Italy
2499	113	Hamed Traoré	Midfield	2000-02-16	Ivory Coast
3659	113	Leander Dendoncker	Midfield	1995-04-15	Belgium
8354	113	André Zambo Anguissa	Midfield	1995-11-16	Cameroon
9544	113	Diego Demme	Midfield	1991-11-21	Germany
31676	113	Jens Cajuste	Midfield	1999-08-10	Sweden
33628	113	Stanislav Lobotka	Midfield	1994-11-25	Slovakia
81973	113	Jesper Lindstrøm	Midfield	2000-02-29	Denmark
217548	113	Lorenzo Russo	Midfield	2005-04-19	Italy
246104	113	Francesco Gioielli	Midfield	2004-02-26	Italy
1789	113	Giovanni Simeone	Offence	1995-07-05	Argentina
9434	113	Victor Osimhen	Offence	1998-12-29	Nigeria
99859	113	Cyril Ngonge	Offence	2000-05-26	Belgium
113285	113	Khvicha Kvaratskhelia	Offence	2001-02-12	Georgia
114117	113	Giacomo Raspadori	Offence	2000-02-18	Italy
1993	115	Daniele Padelli	Goalkeeper	1985-10-25	Italy
2143	115	Marco Silvestri	Goalkeeper	1991-03-02	Italy
65480	115	Maduka Okoye	Goalkeeper	1999-08-28	Nigeria
215584	115	Joel Malusà	Goalkeeper	2007-03-28	Italy
221765	115	Federico Mosca	Goalkeeper	2005-08-08	Italy
777	115	Enzo Ebosse	Defence	1999-03-11	Cameroon
822	115	Hassane Kamara	Defence	1994-03-05	Ivory Coast
7710	115	Kingsley Ehizibue	Defence	1995-05-25	Netherlands
8111	115	Christian Kabasele	Defence	1991-02-24	Belgium
45671	115	Nehuén Pérez	Defence	2000-06-24	Argentina
74688	115	Jaka Bijol	Defence	1999-02-05	Slovenia
99311	115	Jordan Zemura	Defence	1999-11-14	Zimbabwe
125700	115	João Ferreira	Defence	2001-03-22	Portugal
151299	115	Thomas Kristensen	Defence	2002-01-17	Denmark
157330	115	Festy Ebosele	Defence	2002-08-02	Ireland
169269	115	Lautaro Giannetti	Defence	1993-11-13	Argentina
175822	115	Antonio Tikvic	Defence	2004-04-21	Croatia
187208	115	James Abankwah	Defence	2004-01-16	Ireland
215582	115	Samuel John Nwachukwu	Defence	2005-11-04	Italy
252872	115	Matteo Palma	Defence	2008-03-13	Germany
6532	115	Walace	Midfield	1995-04-04	Brazil
8120	115	Roberto Pereyra	Midfield	1991-01-07	Argentina
10887	115	Sandi Lovric	Midfield	1998-03-28	Slovenia
45711	115	Martín Payero	Midfield	1998-09-11	Argentina
130420	115	Lazar Samardzic	Midfield	2002-02-24	Serbia
150522	115	Oier Zarraga	Midfield	1999-01-04	Spain
215588	115	David Pejičić	Midfield	2007-06-14	Slovenia
217576	115	Bor Žunec	Midfield	2005-06-30	Slovenia
1360	115	Brenner	Offence	2000-01-16	Brazil
3370	115	Florian Thauvin	Offence	1993-01-26	France
3896	115	Keinan Davis	Offence	1998-02-13	England
8135	115	Gerard Deulofeu	Offence	1994-03-13	Spain
11633	115	Isaac Success	Offence	1996-01-07	Nigeria
40305	115	Lorenzo Lucca	Offence	2000-09-10	Italy
1828	445	Etrit Berisha	Goalkeeper	1989-03-10	Albania
40648	445	Samuele Perisan	Goalkeeper	1997-08-21	Italy
82004	445	Elia Caprile	Goalkeeper	2001-08-25	Italy
204342	445	Jacopo Seghetti	Goalkeeper	2005-02-17	Italy
247357	445	Filippo Vertua	Goalkeeper	2006-01-01	Italy
2120	445	Giuseppe Pezzella	Defence	1997-11-29	Italy
2249	445	Bartosz Bereszyński	Defence	1992-07-12	Poland
2483	445	Sebastiano Luperto	Defence	1996-09-06	Italy
3385	445	Tyronne Ebuehi	Defence	1995-12-16	Nigeria
4690	445	Liberato Cacace	Defence	2000-09-27	New Zealand
23287	445	Ardian Ismajli	Defence	1996-09-30	Albania
41093	445	Simone Bastoni	Defence	1996-11-05	Italy
105441	445	Sebastian Walukiewicz	Defence	2000-04-05	Poland
186532	445	Gabriele Indragoli	Defence	2004-02-20	Italy
215525	445	Saba Goglichidze	Defence	2004-06-25	Georgia
2362	445	Alberto Grassi	Midfield	1995-03-07	Italy
9237	445	Răzvan Marin	Midfield	1996-05-23	Romania
10202	445	Szymon Zurkowski	Midfield	1997-09-25	Poland
16480	445	Viktor Kovalenko	Midfield	1996-02-14	Ukraine
57805	445	Youssef Maleh	Midfield	1998-08-22	Morocco
102363	445	Luca Belardinelli	Midfield	2001-03-14	Italy
177054	445	Jacopo Fazzini	Midfield	2003-03-16	Italy
245852	445	Andrea Sodero	Midfield	2004-08-07	Italy
1888	445	Mattia Destro	Offence	1991-03-20	Italy
2506	445	Francesco Caputo	Offence	1987-08-06	Italy
2606	445	Alberto Cerri	Offence	1996-04-16	Italy
117606	445	Nicolò Cambiaghi	Offence	2000-12-28	Italy
152787	445	Matteo Cancellieri	Offence	2002-02-12	Italy
171360	445	Herculano Nabian	Offence	2004-01-25	Portugal
179540	445	Emmanuel Gyasi	Offence	1994-01-11	Ghana
179624	445	M’Baye Niang	Offence	1994-12-19	Senegal
188633	445	Stiven Shpendi	Offence	2003-05-19	Albania
211542	445	Giacomo Corona	Offence	2004-02-24	Italy
2439	450	Alessandro Berardi	Goalkeeper	1991-01-16	Italy
2891	450	Lorenzo Montipò	Goalkeeper	1996-02-20	Italy
42319	450	Simone Perilli	Goalkeeper	1995-01-07	Italy
92090	450	Mattia Chiesa	Goalkeeper	2000-07-16	Italy
176869	450	Giacomo Toniolo	Goalkeeper	2004-04-01	Italy
724	450	Fabien Centonze	Defence	1996-01-16	France
2592	450	Giangiacomo Magnani	Defence	1995-10-04	Italy
4089	450	Ruben Vinagre	Defence	1999-04-09	Portugal
121860	450	Juan Cabal	Defence	2001-01-08	Colombia
176720	450	Diego Coppola	Defence	2003-12-28	Italy
189152	450	Christian Corradi	Defence	2005-02-21	Italy
213188	450	Paweł Dawidowicz	Defence	1995-05-20	Poland
1974	450	Darko Lazović	Midfield	1990-09-15	Serbia
6560	450	Ondrej Duda	Midfield	1994-12-15	Slovakia
6629	450	Suat Serdar	Midfield	1997-04-11	Germany
42760	450	Michael Folorunsho	Midfield	1998-02-07	Italy
137978	450	Tomáš Suslov	Midfield	2002-06-07	Slovakia
171370	450	Daniel Silva	Midfield	2000-04-11	Portugal
171448	450	Tijjani Noslin	Midfield	1999-07-07	Netherlands
187476	450	Reda Belahyane	Midfield	2004-06-01	France
204335	450	Joselito	Midfield	2004-02-09	Spain
215513	450	Nicola Patanè	Midfield	2004-03-23	Italy
221866	450	Nicolò Calabrese	Midfield	2004-11-16	Italy
2373	450	Federico Bonazzoli	Offence	1997-05-21	Italy
64267	450	Karol Świderski	Offence	1997-01-23	Poland
77237	450	Thomas Henry	Offence	1994-09-20	France
99512	450	Elayis Tavsan	Offence	2001-04-30	Netherlands
136910	450	Stefan Mitrović	Offence	2002-08-15	Serbia
140261	450	Juan Cruz	Offence	1999-07-19	Argentina
171027	450	Jackson Tchatchoua	Offence	2002-06-22	Cameroon
192142	450	Alphadjo Cisse	Offence	2006-10-22	Italy
203887	450	Charlys	Offence	2004-02-19	Brazil
252918	450	Junior Ajayi	Offence	2004-10-11	Ivory Coast
2856	455	Vincenzo Fiorillo	Goalkeeper	1990-01-13	Italy
8494	455	Benoît Costil	Goalkeeper	1987-07-03	France
181386	455	Francisco Ochoa	Goalkeeper	1985-07-14	Mexico
217716	455	Pasquale Allocca	Goalkeeper	2005-05-09	Italy
240201	455	Gregorio Salvati	Goalkeeper	2005-02-07	Italy
347	455	Jérôme Boateng	Defence	1988-09-03	Germany
1798	455	Kostas Manolas	Defence	1991-06-14	Greece
1800	455	Federico Fazio	Defence	1987-03-17	Argentina
2449	455	Norbert Gyömbér	Defence	1992-07-03	Slovakia
2996	455	Alessandro Zanoli	Defence	2000-10-03	Italy
8382	455	Junior Sambia	Defence	1996-09-07	France
25504	455	Domagoj Bradarić	Defence	1999-12-10	Croatia
43259	455	Triantafyllos Pasalidis	Defence	1996-07-19	Greece
137678	455	Lorenzo Pirola	Defence	2002-02-20	Italy
196495	455	Marco Pellegrino	Defence	2002-07-18	Argentina
215581	455	Emanuele Elia	Defence	2004-12-19	Italy
249028	455	Tommaso Ferrari	Defence	2005-04-30	Italy
251306	455	Niccolò Guccione	Defence	2006-03-04	Italy
2005	455	Antonio Candreva	Midfield	1987-02-28	Italy
2834	455	Giulio Maggiore	Midfield	1998-03-12	Italy
8658	455	Lassana Coulibaly	Midfield	1996-04-10	Mali
23703	455	Toma Bašić	Midfield	1996-11-25	Croatia
98299	455	Boulaye Dia	Midfield	1996-11-16	Senegal
114136	455	Iron Gomis	Midfield	1999-11-08	France
169011	455	Agustin Martegani	Midfield	2000-03-20	Argentina
170394	455	Loum Tchaouna	Midfield	2003-09-08	France
206172	455	Andres Sfait	Midfield	2004-12-09	Romania
209139	455	Mateusz Łęgowski	Midfield	2003-01-29	Poland
213184	455	Niccolò Pierozzi	Midfield	2001-09-12	Italy
245692	455	Ciro Borrelli	Midfield	2006-01-09	Italy
251261	455	Rocco Di Vico	Midfield	2007-01-01	Italy
1955	455	Emanuel Vignato	Offence	2000-04-28	Italy
2236	455	Simeon Nwankwo	Offence	1992-05-07	Nigeria
9306	455	Grigoris Kastanos	Offence	1998-01-30	Cyprus
41152	455	Shon Weissman	Offence	1996-02-14	Israel
128579	455	Mikael	Offence	1999-05-28	Brazil
212433	455	Chukwubuikem Ikwuemesi	Offence	2001-08-05	Nigeria
251310	455	Gerardo Fusco	Offence	2005-05-18	Italy
252916	455	Luca Boncori	Offence	2006-02-21	Italy
1768	470	Michele Cerofolini	Goalkeeper	1999-01-04	Italy
2374	470	Pierluigi Frattali	Goalkeeper	1985-12-01	Italy
41384	470	Stefano Turati	Goalkeeper	2001-09-05	Italy
172293	470	Lorenzo Palmisani	Goalkeeper	2004-01-01	Italy
1877	470	Simone Romagnoli	Defence	1990-02-09	Italy
2185	470	Pol Mikel Lirola	Defence	1997-08-13	Spain
2282	470	Kevin Bonifazi	Defence	1996-05-19	Italy
2795	470	Riccardo Marchizza	Defence	1998-03-26	Italy
42613	470	Emanuele Valeri	Defence	1998-12-07	Italy
101439	470	Caleb Okoli	Defence	2001-07-13	Italy
102973	470	Sergio Kalaj	Defence	2000-01-28	Albania
127143	470	Nadir Zortea	Defence	1999-06-19	Italy
136640	470	Ilario Monterisi	Defence	2001-12-19	Italy
148672	470	Anthony Oyono	Defence	2001-04-12	Gabon
203839	470	Mateus Lusuardi	Defence	2004-01-08	Brazil
214551	470	Daniel Macej	Defence	2004-04-29	Czech Republic
215511	470	Matjaž Kamenšek Pahič	Defence	2004-07-04	Slovenia
2196	470	Luca Mazzitelli	Midfield	1995-11-15	Italy
2803	470	Soufiane Bidaoui	Midfield	1990-04-20	Morocco
7763	470	Abdou Harroui	Midfield	1998-01-13	Morocco
40471	470	Francesco Gelli	Midfield	1996-10-15	Italy
99858	470	Marco Brescianini	Midfield	2000-01-20	Italy
123350	470	Reinier	Midfield	2002-01-19	Brazil
158894	470	Enzo Barrenechea	Midfield	2001-05-22	Argentina
176899	470	Arijon Ibrahimovic	Midfield	2005-12-11	Germany
188117	470	Isak Vural	Midfield	2006-05-28	Turkey
2883	470	Jaime Báez	Offence	1995-04-25	Uruguay
3014	470	Luca Garritano	Offence	1994-02-11	Italy
91310	470	Kaio Jorge	Offence	2002-01-24	Brazil
97309	470	Giuseppe Caso	Offence	1998-12-09	Italy
129808	470	Walid Cheddira	Offence	1998-01-22	Morocco
146269	470	Marvin Cuni	Offence	2001-07-10	Albania
151961	470	Demba Seck	Offence	2001-02-10	Senegal
171121	470	Matias Soule	Offence	2003-04-15	Argentina
211564	470	Giorgi Kvernadze	Offence	2003-02-07	Georgia
245324	470	Farés Ghedjemis	Offence	2002-09-06	France
1895	471	Alessio Cragno	Goalkeeper	1994-06-28	Italy
2175	471	Gianluca Pegolo	Goalkeeper	1981-03-25	Italy
2176	471	Andrea Consigli	Goalkeeper	1987-01-27	Italy
185073	471	Daniel Theiner	Goalkeeper	2004-02-25	Italy
218415	471	Alessandro Scacchetti	Goalkeeper	2005-02-22	Italy
162	471	Jeremy Toljan	Defence	1994-08-08	Germany
2151	471	Marash Kumbulla	Defence	2000-02-08	Albania
38548	471	Marcus Pedersen	Defence	2000-07-16	Norway
74268	471	Martin Erlic	Defence	1998-01-24	Croatia
122407	471	Josh Doig	Defence	2002-01-01	Scotland
131258	471	Ruan	Defence	1999-06-07	Brazil
136628	471	Mattia Viti	Defence	2002-01-24	Italy
175837	471	Filippo Missori	Defence	2004-03-24	Italy
179539	471	Gianmarco Ferrari	Defence	1992-02-15	Italy
206128	471	Matteo Falasca	Defence	2004-04-27	Italy
244896	471	Seb Loeffen	Defence	2004-01-18	Netherlands
1153	471	Matheus Henrique	Midfield	1997-12-19	Brazil
2847	471	Samuele Mulattieri	Midfield	2000-10-07	Italy
8210	471	Pedro Obiang	Midfield	1992-03-27	Equatorial Guinea
30889	471	Nedim Bajrami	Midfield	1999-02-28	Albania
44033	471	Kristian Thorstvedt	Midfield	1999-03-13	Norway
147020	471	Daniel Boloca	Midfield	1998-12-22	Italy
175891	471	Cristian Volpato	Midfield	2003-11-15	Italy
176880	471	Salim Abubakar	Midfield	2003-04-06	Ghana
176917	471	Justin Kumi	Midfield	2004-07-16	Italy
189844	471	Luca Lipani	Midfield	2005-05-18	Italy
1824	471	Gregoire Defrel	Offence	1991-06-17	Martinique
2016	471	Andrea Pinamonti	Offence	1999-05-19	Italy
2202	471	Domenico Berardi	Offence	1994-08-01	Italy
8822	471	Armand Lauriente	Offence	1998-12-04	France
16208	471	Emil Ceide	Offence	2001-09-03	Norway
33126	471	Samu Castillejo	Offence	1995-01-18	Spain
67704	471	Uroš Račić	Offence	1998-03-17	Serbia
2275	586	Vanja Milinković-Savić	Goalkeeper	1997-02-20	Serbia
101392	586	Luca Gemello	Goalkeeper	2000-07-03	Italy
140195	586	Pietro Passador	Goalkeeper	2003-02-26	Italy
169137	586	Mihai Popa	Goalkeeper	2000-10-12	Romania
220114	586	Matteo Brezzo	Goalkeeper	2005-06-13	Italy
207094	81	Pau Prim	Midfield	2006-02-22	Spain
1745	586	Ricardo Rodriguez	Defence	1992-08-25	Switzerland
1748	586	Raoul Bellanova	Defence	2000-05-17	Italy
1865	586	Adam Masina	Defence	1994-01-02	Morocco
2280	586	Alessandro Buongiorno	Defence	1999-06-06	Italy
6563	586	Valentino Lazaro	Defence	1996-03-24	Austria
8689	586	Koffi Djidji	Defence	1992-11-30	Ivory Coast
9204	586	Mërgim Vojvoda	Defence	1995-02-01	Kosovo
53469	586	Perr Schuurs	Defence	1999-11-26	Netherlands
118152	586	Matteo Lovato	Defence	2000-02-14	Italy
161083	586	Saba Sazonov	Defence	2002-02-01	Georgia
218559	586	Alessandro Dellavalle	Defence	2004-05-11	Italy
246081	586	Vimoj Muntu Wa Mungu	Defence	2004-10-15	France
2258	586	Karol Linetty	Midfield	1995-02-02	Poland
7843	586	Nikola Vlašić	Midfield	1997-10-04	Croatia
8438	586	Adrien Tameze	Midfield	1994-02-04	Cameroon
67697	586	Ivan Ilić	Midfield	2001-03-17	Serbia
115245	586	Samuele Ricci	Midfield	2001-08-21	Italy
190831	586	Gvidas Gineitis	Midfield	2004-04-15	Lithuania
191428	586	Aaron Ciammaglichella	Midfield	2005-01-26	Italy
220113	586	Jacopo Antolini	Midfield	2004-01-10	Italy
244639	586	Jonathan Silva	Midfield	2004-04-24	Brazil
246638	586	Comè Bianay Balcot	Midfield	2005-05-13	France
14	586	Antonio Sanabria	Offence	1996-03-04	Paraguay
2271	586	Duván Zapata	Offence	1991-04-01	Colombia
8768	586	Pietro Pellegri	Offence	2001-03-17	Italy
42179	586	David Okereke	Offence	1997-08-29	Nigeria
217926	586	Uroš Kabić	Offence	2004-01-01	Serbia
226987	586	Zannetos Savva	Offence	2005-11-26	Cyprus
246508	586	Alieu Njie	Offence	2005-05-14	Sweden
1769	5890	Federico Brancolini	Goalkeeper	2001-07-14	Italy
56649	5890	Wladimiro Falcone	Goalkeeper	1995-04-12	Italy
133202	5890	Jasper Samooja	Goalkeeper	2003-07-21	Finland
157189	5890	Alexandru Borbei	Goalkeeper	2003-06-27	Romania
2310	5890	Lorenzo Venuti	Defence	1995-04-12	Italy
8872	5890	Ahmed Touba	Defence	1999-03-13	Algeria
15110	5890	Marin Pongračić	Defence	1997-09-11	Croatia
42152	5890	Kastriot Dermaku	Defence	1992-01-15	Albania
77469	5890	Antonino Gallo	Defence	2000-01-05	Italy
86045	5890	Federico Baschirotto	Defence	1996-09-20	Italy
121279	5890	Valentin Gendrey	Defence	2000-06-21	France
171573	5890	Daniel Samek	Defence	2004-02-19	Czech Republic
192420	5890	Sebastian Esposito	Defence	2003-07-21	Australia
211559	5890	Patrick Dorgu	Defence	2004-10-26	Denmark
818	5890	Rémi Oudin	Midfield	1996-11-18	France
8302	5890	Alexis Blin	Midfield	1996-09-16	France
70286	5890	Ylber Ramadani	Midfield	1996-04-12	Albania
116223	5890	Santiago Pierotti	Midfield	2001-04-03	Argentina
129319	5890	Hamza Rafia	Midfield	1999-04-02	Tunisia
170915	5890	Mohamed Kaba	Midfield	2001-10-27	France
175932	5890	Joan Gonzalez	Midfield	2002-02-01	Spain
184743	5890	Jeppe Corfitzen	Midfield	2004-12-29	Denmark
188103	5890	Medon Berisha	Midfield	2003-10-21	Albania
31881	5890	Pontus Almqvist	Offence	1999-07-10	Sweden
33129	5890	Nicola Sansone	Offence	1991-09-10	Italy
102591	5890	Roberto Piccoli	Offence	2001-01-27	Italy
120679	5890	Nikola Krstović	Offence	2000-04-05	Montenegro
121808	5890	Lameck Banda	Offence	2001-01-29	Zambia
172414	5890	Rares Burnete	Offence	2004-01-31	Romania
41381	5911	Michele Di Gregorio	Goalkeeper	1997-07-27	Italy
41729	5911	Stefano Gori	Goalkeeper	1996-03-09	Italy
127147	5911	Alessandro Sorrentino	Goalkeeper	2002-04-03	Italy
165301	5911	Andrea Mazza	Goalkeeper	2004-01-01	Italy
1962	5911	Armando Izzo	Defence	1992-03-02	Italy
1971	5911	Pedro Pereira	Defence	1998-01-22	Portugal
1995	5911	Danilo D'Ambrosio	Defence	1988-09-09	Italy
6622	5911	Giulio Donati	Defence	1990-02-05	Italy
7647	5911	Pablo Marí	Defence	1993-08-31	Spain
9443	5911	Luca Caldirola	Defence	1991-02-01	Italy
40611	5911	Samuele Birindelli	Defence	1999-07-19	Italy
81468	5911	Davide Bettella	Defence	2000-04-07	Italy
137506	5911	Andrea Carboni	Defence	2001-02-04	Italy
179577	5911	Giorgos Kyriakopoulos	Defence	1996-02-05	Greece
1852	5911	Andrea Colpani	Midfield	1999-05-11	Italy
2006	5911	Roberto Gagliardini	Midfield	1994-04-07	Italy
2836	5911	Matteo Pessina	Midfield	1997-04-21	Italy
29230	5911	Pepinho	Midfield	1996-08-14	Equatorial Guinea
136113	5911	Daniel Maldini	Midfield	2001-10-11	Italy
156527	5911	Warren Bondo	Midfield	2003-09-15	France
180333	5911	Samuele Vignato	Midfield	2004-02-24	Italy
187371	5911	Valentín Carboni	Midfield	2005-03-05	Italy
189196	5911	Leonardo Colombo	Midfield	2005-06-04	Italy
189203	5911	Andrea Ferraris	Midfield	2003-02-22	Italy
213187	5911	Jean-Daniel Akpa-Akpro	Midfield	1992-10-11	Ivory Coast
213276	5911	Papu Gómez	Midfield	1988-02-15	Argentina
246552	5911	Matija Popović	Midfield	2006-01-08	Serbia
250187	5911	Alessandro Berretta	Midfield	2006-01-01	Italy
2107	5911	Alessio Zerbin	Offence	1999-03-03	Italy
2270	5911	Gianluca Caprari	Offence	1993-07-30	Italy
3040	5911	Dany Mota Carvalho	Offence	1998-05-02	Portugal
4409	5911	Milan Đurić	Offence	1990-05-22	Bosnia-Herzegovina
42347	5911	Patrick Ciurria	Offence	1995-02-09	Italy
144566	5911	Lorenzo Colombo	Offence	2002-03-08	Italy
32570	77	Unai Simón	Goalkeeper	1997-06-11	Spain
172017	77	Julen Agirrezabala	Goalkeeper	2000-12-26	Spain
203459	77	Álex Padilla	Goalkeeper	2003-09-01	Spain
8479	77	Yuri Berchiche	Defence	1990-02-10	Spain
32579	77	Yeray Álvarez	Defence	1995-01-24	Spain
32581	77	Iñigo Lekue	Defence	1993-05-04	Spain
32599	77	De Marcos	Defence	1989-04-14	Spain
32618	77	Daniel Vivian	Defence	1999-07-05	Spain
151439	77	Aitor Paredes Casamichana	Defence	2000-04-29	Spain
172029	77	Imanol Garcia de Albeniz	Defence	2000-06-08	Spain
217432	77	Unai Eguíluz	Defence	2002-03-19	Spain
229042	77	Hugo Rincón	Defence	2003-01-27	Spain
2294	77	Álex Berenguer	Midfield	1995-07-04	Spain
7904	77	Ander Herrera	Midfield	1989-08-14	Spain
32481	77	Ruiz de Galarreta	Midfield	1993-08-06	Spain
32604	77	Raúl García	Midfield	1986-07-11	Spain
33343	77	Dani García	Midfield	1990-05-24	Spain
96868	77	Mikel Vesga	Midfield	1993-04-08	Spain
126878	77	Oihan Sancet	Midfield	2000-04-25	Spain
168663	77	Benat Prados	Midfield	2001-02-08	Spain
202335	77	Unai Gomez	Midfield	2003-05-25	Spain
244599	77	Mikel Jauregizar	Midfield	2003-11-13	Spain
32623	77	Muniain	Offence	1992-12-19	Spain
32629	77	Iñaki Williams	Offence	1994-06-15	Ghana
33777	77	Asier Villalibre	Offence	1997-09-30	Spain
81565	77	Gorka Guruzeta	Offence	1996-09-12	Spain
157135	77	Nico Williams	Offence	2002-07-12	Spain
186718	77	Malcom Ares	Offence	2001-10-12	Spain
244642	77	Aingeru Olabarrieta	Offence	2005-11-14	Spain
246633	77	Adama Boiro	Offence	2002-06-22	Spain
120	78	Jan Oblak	Goalkeeper	1993-01-07	Slovenia
122005	78	Horaţiu Moldovan	Goalkeeper	1998-01-20	Romania
180049	78	Gomis	Goalkeeper	2003-05-20	Spain
188407	78	Sergio Mestre	Goalkeeper	2005-02-13	Spain
3191	78	Azpilicueta	Defence	1989-08-28	Spain
3656	78	Axel Witsel	Defence	1989-01-12	Belgium
15845	78	Stefan Savić	Defence	1991-01-08	Montenegro
32703	78	Mario Hermoso	Defence	1995-06-18	Spain
33145	78	Gabriel Paulista	Defence	1990-11-26	Brazil
37094	78	Reinildo	Defence	1994-01-21	Mozambique
46452	78	Nahuel Molina	Defence	1998-04-06	Argentina
128731	78	Rodrigo Riquelme	Defence	2000-04-02	Spain
159408	78	Adrián Corral	Defence	2003-01-05	Spain
180077	78	Marco Moreno	Defence	2001-02-20	Spain
206337	78	Ilias Kostis	Defence	2003-02-27	Cyprus
213277	78	José Giménez	Defence	1995-01-20	Uruguay
221562	78	Javier Boñar	Defence	2005-06-03	Spain
70	78	Marcos Llorente	Midfield	1995-01-30	Spain
112	78	Koke	Midfield	1992-01-08	Spain
118	78	Saúl	Midfield	1994-11-21	Spain
126	78	Vitolo	Midfield	1989-11-02	Spain
2127	78	Rodrigo de Paul	Midfield	1994-05-24	Argentina
166652	78	Mini	Midfield	1999-04-10	Spain
177509	78	Pablo Barrios	Midfield	2003-06-15	Spain
190835	78	Aitor Gismera	Midfield	2004-02-21	Spain
220538	78	Álex Calatrava	Midfield	2000-06-22	Spain
244719	78	Rayane Belaid	Midfield	2005-11-02	Algeria
114	78	Antoine Griezmann	Offence	1991-03-21	France
125	78	Ángel Correa	Offence	1995-03-09	Argentina
3369	78	Thomas Lemar	Offence	1995-11-12	France
7819	78	Álvaro Morata	Offence	1992-10-23	Spain
8472	78	Memphis Depay	Offence	1994-02-13	Netherlands
98578	78	Marcos Paulo	Offence	2001-02-01	Brazil
178710	78	Samuel Lino	Offence	1999-12-23	Brazil
207012	78	Abdellah Raihani	Offence	2004-02-03	Spain
207104	78	El Jebari	Offence	2004-02-05	Spain
221308	78	Adrián	Offence	2004-06-19	Spain
31968	79	Sergio Herrera	Goalkeeper	1993-06-05	Spain
32391	79	Aitor Fernández	Goalkeeper	1991-05-03	Spain
191209	79	Pablo Valencia	Goalkeeper	2001-03-16	Spain
217550	79	Dimitrios Stamatakis	Goalkeeper	2003-04-23	Greece
3724	79	Johan Mojica	Defence	1992-08-21	Colombia
31979	79	Unai García	Defence	1992-09-03	Spain
32146	79	David García	Defence	1994-02-14	Spain
33346	79	Rubén Peña	Defence	1991-07-18	Spain
50890	79	Catena	Defence	1994-10-28	Spain
81183	79	Juan Cruz	Defence	1992-07-28	Spain
136000	79	Jesús Areso	Defence	1999-07-02	Spain
159409	79	Jorge Herrando	Defence	2001-02-28	Spain
171996	79	Jorge Moreno	Defence	2001-07-25	Spain
15869	79	José Arnáiz	Midfield	1995-04-15	Spain
32002	79	Lucas Torró	Midfield	1994-07-19	Spain
32212	79	Rubén García	Midfield	1993-07-14	Spain
32217	79	Moi Gómez	Midfield	1994-06-23	Spain
111674	79	Jon Moncayola	Midfield	1998-05-13	Spain
119093	79	Aimar Oroz	Midfield	2001-11-27	Spain
191925	79	Iker Munoz	Midfield	2002-11-05	Spain
249577	79	Asier Osambela	Midfield	2004-02-08	Spain
251133	79	Xabi Huarte	Midfield	2001-02-25	Spain
2237	79	Ante Budimir	Offence	1991-07-22	Croatia
32004	79	Kike Barja	Offence	1997-04-04	Spain
130324	79	Raúl	Offence	2000-11-03	Spain
154532	79	Max Svensson	Offence	2001-11-08	Spain
227689	79	Sola	Offence	1999-06-09	Spain
248752	79	Iñigo Arguibide	Offence	2005-04-19	Spain
3173	81	Marc-André ter Stegen	Goalkeeper	1992-04-30	Germany
180898	81	Iñaki Peña	Goalkeeper	1999-03-02	Spain
185095	81	Marc Vidal	Goalkeeper	2000-02-14	Spain
191325	81	Ander Astralaga	Goalkeeper	2004-03-03	Spain
217424	81	Diego Kochen	Goalkeeper	2006-03-19	USA
242551	81	Áron Yaakobishvili	Goalkeeper	2006-03-06	Hungary
2000	81	João Cancelo	Defence	1994-05-27	Portugal
3195	81	Marcos Alonso	Defence	1990-12-28	Spain
3455	81	Andreas Christensen	Defence	1996-04-10	Denmark
8499	81	Jules Koundé	Defence	1998-11-12	France
15865	81	Sergi Roberto	Defence	1992-02-07	Spain
28292	81	Ronald Araújo	Defence	1999-03-07	Uruguay
32588	81	Íñigo Martínez	Defence	1991-05-17	Spain
37428	81	Raphinha	Defence	1996-12-14	Brazil
172761	81	Álex Balde	Defence	2003-10-18	Spain
217540	81	Pau Cubarsí	Defence	2007-01-22	Spain
227023	81	Héctor Fort	Defence	2006-08-02	Spain
249351	81	Mikayil Faye	Defence	2004-07-14	Senegal
3182	81	Ilkay Gündogan	Midfield	1990-10-24	Germany
7559	81	Frenkie de Jong	Midfield	1997-05-12	Netherlands
8091	81	Oriol Romeu	Midfield	1991-09-24	Spain
171992	81	Pablo Gavira	Midfield	2004-08-05	Spain
176866	81	Unai Hernandez	Midfield	2004-12-14	Spain
188817	81	Marc Casado	Midfield	2003-09-14	Spain
192888	81	Aleix Garrido	Midfield	2004-02-22	Spain
184146	78	Arthur Vermeeren	Midfield	2005-02-07	Belgium
371	81	Robert Lewandowski	Offence	1988-08-21	Poland
33154	81	Ferrán Torres	Offence	2000-02-29	Spain
39265	81	João Félix	Offence	1999-11-10	Portugal
133860	81	Pedri	Offence	2002-11-25	Spain
144579	81	Pau Victor Delgado	Offence	2001-11-26	Spain
181439	81	Vítor Roque	Offence	2005-02-28	Brazil
191058	81	Angel Alarcon	Offence	2004-05-15	Spain
202283	81	Lamine Yamal	Offence	2007-07-13	Spain
207109	81	Marc Guiu	Offence	2006-01-04	Spain
214533	81	Fermín López	Offence	2003-05-11	Spain
78	82	David Soria	Goalkeeper	1993-04-04	Spain
1169	82	Daniel Fuzato	Goalkeeper	1997-07-04	Brazil
214562	82	Jorge Benito	Goalkeeper	2006-01-01	Spain
246276	82	Djordjije Medenica	Goalkeeper	2006-11-17	Czech Republic
277	82	Diego Rico	Defence	1993-02-23	Spain
3125	82	Dakonam Djené	Defence	1991-12-31	Togo
45472	82	Domingos Duarte	Defence	1995-03-10	Portugal
46376	82	Fabrizio Angileri	Defence	1994-03-15	Argentina
46491	82	Omar Alderete	Defence	1996-12-26	Paraguay
83351	82	Juan Iglesias	Defence	1998-07-03	Spain
115668	82	Gastón Álvarez	Defence	2000-03-24	Uruguay
171984	82	Jose Angel Carmona	Defence	2002-01-29	Spain
186707	82	Gorka Rivera	Defence	2004-08-01	Spain
226985	82	Nabil Aberdín	Defence	2002-08-23	France
247170	82	Alejandro Herranz	Defence	2004-11-26	Spain
249064	82	Sergio Gimeno	Defence	2001-05-25	Spain
3441	82	Nemanja Maksimović	Midfield	1995-01-26	Serbia
3877	82	Óscar	Midfield	1998-06-28	Spain
32449	82	Luis Milla	Midfield	1994-10-07	Spain
32758	82	Mauro Arambarri	Midfield	1995-09-30	Uruguay
156702	82	John Patrick	Midfield	2003-09-24	Ireland
157368	82	Ilaix Moriba	Midfield	2003-01-19	Guinea
172841	82	Diego Lopez	Midfield	2001-10-21	Spain
180125	82	Santi García	Midfield	2001-08-29	Spain
203446	82	Yellu	Midfield	2004-05-25	Spain
213262	82	Carles Aleñá	Midfield	1998-01-05	Spain
226204	82	Jeremy Jiménez	Midfield	2003-02-09	Spain
226986	82	Facu Esnáider	Midfield	2001-11-09	Spain
227974	82	Jordi	Midfield	2001-01-05	Spain
250399	82	Alberto Risco	Midfield	2005-08-30	Spain
69	82	Borja Mayoral	Offence	1997-04-05	Spain
32381	82	Mata	Offence	1988-10-24	Spain
101075	82	Mason Greenwood	Offence	2001-10-01	England
180071	82	Latasa	Offence	2001-03-23	Spain
250899	82	Yassin Tallal	Offence	2005-03-03	Morocco
32911	83	Raúl Fernández	Goalkeeper	1988-03-13	Spain
33578	83	Marc Martínez	Goalkeeper	1990-04-04	Spain
46245	83	Augusto Batalla	Goalkeeper	1996-04-30	Argentina
191423	83	Adri López	Goalkeeper	1999-01-09	Spain
244761	83	Pol Tristán	Goalkeeper	2002-03-18	Spain
244895	83	Fran Árbol	Goalkeeper	2006-06-30	Spain
46	83	Jesús Vallejo	Defence	1997-01-05	Spain
8807	83	Faitout Maouassa	Defence	1998-07-06	France
28755	83	Bruno Méndez	Defence	1999-09-10	Uruguay
32034	83	Víctor Díaz	Defence	1988-06-12	Spain
32769	83	Martin Hongla	Defence	1998-03-16	Cameroon
100094	83	Carlos Neva	Defence	1996-06-12	Spain
127425	83	Kamil Piątkowski	Defence	2000-06-21	Poland
141472	83	Ricard Sánchez	Defence	2000-02-22	Spain
154076	83	Raúl Torrente	Defence	2001-09-11	Spain
180164	83	Miguel Rubio	Defence	1998-03-11	Spain
188785	83	Miki Bosch	Defence	2001-06-09	Spain
213258	83	Ignasi Miquel	Defence	1992-09-28	Spain
32714	83	Óscar Melendo	Midfield	1997-08-23	Spain
33150	83	Gonzalo Villar	Midfield	1998-03-23	Spain
33711	83	Gerard Gumbau	Midfield	1994-12-18	Spain
51004	83	Sergio Ruiz	Midfield	1994-12-16	Spain
157116	83	Theo Corbeanu	Midfield	2002-05-17	Canada
160893	83	Adam Griger	Midfield	2004-03-16	Slovakia
176751	83	Lassina Sangare	Midfield	2001-11-20	Ivory Coast
203567	83	Mario González	Midfield	2004-02-05	Spain
252819	83	Sergio Rodelas	Midfield	2004-12-01	Spain
2104	83	José Callejón	Offence	1987-02-11	Spain
11113	83	Lucas Boyé	Offence	1996-02-28	Argentina
32049	83	Antonio Puertas	Offence	1992-02-21	Spain
64233	83	Kamil Jóźwiak	Offence	1998-04-22	Poland
83795	83	Myrto Uzuni	Offence	1995-05-31	Albania
122506	83	Facundo Pellistri	Offence	2001-12-20	Uruguay
177308	83	Matías Arezo	Offence	2002-11-21	Uruguay
246328	83	Pablo Sáenz	Offence	2001-05-22	Spain
246361	83	Eghosa	Offence	2004-03-17	Benin
3189	86	Kepa Arrizabalaga	Goalkeeper	1994-10-03	Spain
3641	86	Thibaut Courtois	Goalkeeper	1992-05-11	Belgium
28995	86	Andriy Lunin	Goalkeeper	1999-02-11	Ukraine
152461	86	Lucas Cañizars	Goalkeeper	2002-05-10	Spain
176768	86	Diego Pineiro	Goalkeeper	2004-02-13	Spain
203506	86	Mario de Luis	Goalkeeper	2002-05-06	Spain
206826	86	Fran Gonzalez	Goalkeeper	2005-06-24	Spain
45	86	Lucas Vázquez	Defence	1991-07-01	Spain
50	86	Nacho	Defence	1990-01-18	Spain
349	86	David Alaba	Defence	1992-06-24	Austria
1337	86	Éder Militão	Defence	1998-01-18	Brazil
3177	86	Antonio Rüdiger	Defence	1993-03-03	Germany
3194	86	Dani Carvajal	Defence	1992-01-11	Spain
8458	86	Ferland Mendy	Defence	1995-06-08	France
178049	86	Vinicius Tobias	Defence	2004-02-23	Brazil
213266	86	Fran García	Defence	1999-08-14	Spain
221329	86	Álvaro Carrillo	Defence	2002-04-06	Spain
230367	86	Edgar Pujol	Defence	2004-08-07	Spain
247056	86	Jacobo Ramón	Defence	2005-06-06	Spain
43	86	Luka Modrić	Midfield	1985-09-09	Croatia
47	86	Toni Kroos	Midfield	1990-01-04	Germany
68	86	Dani Ceballos	Midfield	1996-08-07	Spain
96	86	Federico Valverde	Midfield	1998-07-22	Uruguay
7887	86	Brahim Diaz	Midfield	1999-08-03	Morocco
8514	86	Aurélien Tchouameni	Midfield	2000-01-27	France
102343	86	Eduardo Camavinga	Midfield	2002-11-10	France
125010	86	Jude Bellingham	Midfield	2003-06-29	England
169162	86	Arda Guler	Midfield	2005-02-25	Turkey
191064	86	Mario Martin	Midfield	2004-03-05	Spain
203511	86	Nico Paz	Midfield	2004-09-08	Spain
217658	86	Gonzalo García	Midfield	2004-03-24	Spain
243978	86	Theo Zidane	Midfield	2002-05-18	France
1324	86	Rodrygo	Offence	2001-01-09	Brazil
1556	86	Vinicius Junior	Offence	2000-07-12	Brazil
7938	86	Joselu	Offence	1990-03-27	Spain
189369	86	Alvaro Rodriguez	Offence	2004-07-14	Spain
33781	87	Stole Dimitrievski	Goalkeeper	1993-12-25	North Macedonia
133288	87	Dani Cárdenas	Goalkeeper	1997-03-28	Spain
7925	87	Florian Lejeune	Defence	1991-05-20	France
8716	87	Iván Balliu	Defence	1992-01-01	Albania
25641	87	Abdul Mumin	Defence	1998-06-06	Ghana
28384	87	Alfonso Espino	Defence	1992-01-05	Uruguay
31988	87	Aridane Hernández	Defence	1989-03-23	Spain
99923	87	Martín Pascual	Defence	1999-08-04	Spain
114955	87	Andrei Rațiu	Defence	1998-06-20	Romania
151251	87	Pep Chavarría	Defence	1998-04-10	Spain
187031	87	Diego Mendez	Defence	2003-08-29	Spain
32109	87	Óscar Valentín	Midfield	1994-08-20	Spain
32115	87	Kike Pérez	Midfield	1997-02-14	Spain
32116	87	Óscar Trejo	Midfield	1988-04-26	Argentina
32312	87	Álvaro García	Midfield	1992-10-27	Spain
33496	87	Isi Palazón	Midfield	1994-12-27	Spain
37649	87	Pathé Ciss	Midfield	1994-03-16	Senegal
98032	87	Randy Ntekja	Midfield	1997-12-06	France
171313	87	Miguel Crespo	Midfield	1996-09-11	Portugal
3739	87	Radamel Falcao	Offence	1986-02-10	Colombia
32124	87	Unai López	Offence	1995-10-30	Spain
32127	87	Raúl de Tomás	Offence	1994-10-17	Spain
32128	87	Bebé	Offence	1990-07-12	Cape Verde Islands
32650	87	José Pozo	Offence	1996-03-15	Spain
115175	87	Sergio Camello	Offence	2001-02-10	Spain
133276	87	Jorge de Frutos	Offence	1997-02-20	Spain
274	89	Cuéllar	Goalkeeper	1984-05-25	Spain
3429	89	Predrag Rajković	Goalkeeper	1995-10-31	Serbia
79776	89	Dominik Greif	Goalkeeper	1997-04-06	Slovakia
245756	89	Alex Quevedo	Goalkeeper	2004-04-28	Spain
2777	89	Martin Valjent	Defence	1995-12-11	Slovakia
3433	89	Matija Nastasić	Defence	1993-03-28	Serbia
9097	89	Siebe Van der Heyden	Defence	1998-05-30	Belgium
28585	89	Giovanni González	Defence	1994-09-20	Uruguay
32984	89	Antonio Raíllo	Defence	1991-10-08	Spain
33104	89	Jaume Costa	Defence	1988-03-18	Spain
33138	89	Toni Lato	Defence	1997-11-21	Spain
33142	89	Nacho Vidal	Defence	1995-01-24	Spain
33513	89	Pablo Maffeo	Defence	1997-07-12	Spain
172108	89	Copete	Defence	1999-10-10	Spain
203438	89	Marcos Fernández	Defence	2003-07-17	Spain
227058	89	Yuzún Ley	Defence	2004-01-01	Spain
244594	89	Carles Sogorb	Defence	2005-02-23	Spain
6713	89	Omar Mascarell	Midfield	1993-02-02	Spain
32282	89	Dani Rodríguez	Midfield	1988-06-06	Spain
32717	89	Sergi Darder	Midfield	1993-12-22	Spain
33120	89	Manu Morlanes	Midfield	1999-01-12	Spain
33681	89	Abdón Prats	Midfield	1992-12-07	Spain
140814	89	Samuel Almeida Costa	Midfield	2000-11-27	Portugal
176236	89	Javier Llabres	Midfield	2002-09-11	Spain
177172	89	Miguelito	Midfield	2001-01-01	Spain
180040	89	Antonio Sánchez	Midfield	1997-04-22	Spain
207144	89	Quintanilla	Midfield	2002-04-03	Spain
10190	89	Nemanja Radonjić	Offence	1996-02-15	Serbia
15958	89	Cyle Larin	Offence	1995-04-17	Canada
30059	89	Vedat Muriqi	Offence	1994-04-24	Kosovo
229044	89	Pau Mascaró	Offence	2004-10-20	Spain
7879	90	Claudio Bravo	Goalkeeper	1983-04-13	Chile
32014	90	Rui Silva	Goalkeeper	1994-02-07	Portugal
180215	90	Fran Vieites	Goalkeeper	1999-05-07	Spain
203476	90	Germán García	Goalkeeper	2004-02-01	Spain
217557	90	Guilherme Fernandes	Goalkeeper	2001-03-28	Portugal
137	90	Sokratis Papastathopoulos	Defence	1988-06-09	Greece
1772	90	Germán Pezzella	Defence	1991-06-27	Argentina
3624	90	Youssouf Sabaly	Defence	1993-03-05	Senegal
7783	90	Héctor Bellerín	Defence	1995-03-19	Spain
32491	90	Juan Miranda	Defence	2000-01-19	Spain
33038	90	Bartra	Defence	1991-01-15	Spain
33045	90	Aitor Ruibal	Defence	1996-03-22	Spain
146101	90	Ricardo Visus	Defence	2001-04-24	Spain
150948	90	Chadi Riad	Defence	2003-06-17	Spain
178964	90	Abner Vinicius	Defence	2000-05-27	Brazil
190558	90	Nobel Mendy	Defence	2004-08-16	France
218485	90	Pablo Busto	Defence	2005-09-15	Spain
245708	90	Xavi Pleguezuelo	Defence	2003-01-14	Spain
66	90	Isco	Midfield	1992-04-21	Spain
3250	90	William Carvalho	Midfield	1992-04-07	Portugal
8464	90	Nabil Fekir	Midfield	1993-07-18	France
32710	90	Marc Roca	Midfield	1996-11-26	Spain
33117	90	Pablo Fornals	Midfield	1996-02-22	Spain
39104	90	Guido Rodríguez	Midfield	1994-04-12	Argentina
189393	90	Quique Fernandez	Midfield	2003-09-16	Spain
189529	90	Dani Perez	Midfield	2005-07-26	Spain
212861	90	Sergi Altimira	Midfield	2001-08-25	Spain
218474	90	Assane Diao	Midfield	2005-09-07	Spain
8	90	Willian José	Offence	1991-11-23	Brazil
7936	90	Ayoze Pérez	Offence	1993-07-29	Spain
21583	90	Cédric Bakambu	Offence	1991-04-11	DR Congo
123265	90	Johnny	Offence	2001-09-20	USA
142393	90	Rodri Sanchez	Offence	2000-02-16	Spain
175941	90	Abdessamad Ezzalzouli	Offence	2001-12-17	Morocco
213268	90	Ezequiel Ávila	Offence	1994-02-06	Argentina
227955	90	Ginés Sorroche	Offence	2004-03-24	Spain
32413	92	Álex Remiro	Goalkeeper	1995-03-24	Spain
152786	92	Gaizka Ayesa	Goalkeeper	2001-04-02	Spain
157040	92	Unai Marrero	Goalkeeper	2001-10-09	Spain
215503	92	Aitor Fraga	Goalkeeper	2003-03-09	Spain
11	92	Álvaro Odriozola	Defence	1995-12-14	Spain
27	92	Aritz Elustondo	Defence	1994-03-28	Spain
29	92	Igor Zubeldía	Defence	1997-03-30	Spain
8808	92	Hamari Traoré	Defence	1992-01-27	Mali
15615	92	Kieran Tierney	Defence	1997-06-05	Scotland
99791	92	Robin Le Normand	Defence	1996-11-11	Spain
100129	92	Aihen Muñoz	Defence	1997-08-16	Spain
141571	92	Jon Aramburu	Defence	2002-07-23	Venezuela
144615	92	Jon Pacheco	Defence	2001-01-08	Spain
151031	92	Urko González	Defence	2001-03-20	Spain
213260	92	Javi Galán	Defence	1994-11-19	Spain
245442	92	Jon Martín	Defence	2006-04-23	Spain
246275	92	Iñaki Rupérez	Defence	2003-01-07	Spain
7935	92	Mikel Merino	Midfield	1996-06-22	Spain
115035	92	Martín Zubimendi	Midfield	1999-02-02	Spain
156615	92	Beñat Turrientes	Midfield	2002-01-31	Spain
161293	92	Jon Olasagasti	Midfield	2000-08-16	Spain
170540	92	Arsen Zakharyan	Midfield	2003-05-26	Russia
171887	92	Jon Magunazelaia	Midfield	2001-07-13	Spain
172786	92	Pablo Marin	Midfield	2003-07-03	Spain
176828	92	Alberto Dadie	Midfield	2002-07-20	Spain
1760	92	André Silva	Offence	1995-11-06	Portugal
7633	92	Sheraldo Becker	Offence	1995-02-09	Suriname
7672	92	Umar Sadiq	Offence	1997-02-02	Nigeria
15931	92	Carlos Fernández	Offence	1996-05-22	Spain
33615	92	Brais Méndez	Offence	1997-01-07	Spain
48555	92	Takefusa Kubo	Offence	2001-06-04	Japan
82364	92	Martín Merquelanz	Offence	1995-06-12	Spain
101182	92	Ander Barrenetxea	Offence	2001-12-27	Spain
112066	92	Bryan Fiabema	Offence	2003-02-16	Norway
180137	92	Mikel Oyarzabal	Offence	1997-04-21	Spain
2082	94	Pepe Reina	Goalkeeper	1982-08-31	Spain
149840	94	Iker Álvarez	Goalkeeper	2001-07-25	Andorra
153828	94	Filip Jörgensen	Goalkeeper	2002-04-16	Denmark
19	94	Aïssa Mandi	Defence	1991-10-22	Algeria
267	94	Alfonso Pedraza	Defence	1996-04-09	Spain
7860	94	Alberto Moreno	Defence	1992-07-05	Spain
7901	94	Eric Bailly	Defence	1994-04-12	Ivory Coast
7996	94	Juan Foyth	Defence	1998-01-12	Argentina
98750	94	Jorge Cuenca	Defence	1999-11-17	Spain
153570	94	Yerson Mosquera	Defence	2001-05-02	Colombia
185093	94	Adrià Altimira	Defence	2001-03-28	Spain
186561	94	Abraham Rando	Defence	2001-07-05	Spain
186564	94	Carlos Romero	Defence	2001-10-29	Spain
187322	94	Stefan Lekovic	Defence	2004-01-09	Serbia
211848	94	Antonio Espigares	Defence	2004-09-05	Spain
213265	94	Raúl Albiol	Defence	1985-09-04	Spain
213274	94	Kiko Femenía	Defence	1991-02-02	Spain
249095	94	Dani Budesca	Defence	2006-10-11	Spain
3198	94	Dani Parejo	Midfield	1989-04-16	Spain
8118	94	Étienne Capoue	Midfield	1988-07-11	France
11572	94	Francis Coquelin	Midfield	1991-05-13	France
15868	94	Denís Suárez	Midfield	1994-01-06	Spain
33115	94	Trigueros	Midfield	1991-10-17	Spain
154000	94	RamónTerrats Espacio	Midfield	2000-10-18	Spain
185087	94	Diego Collado	Midfield	2001-01-09	Spain
206721	94	Dani Requena	Midfield	2004-02-12	Spain
213263	94	Santi Comesaña	Midfield	1996-10-05	Spain
3259	94	Gonçalo Guedes	Offence	1996-11-29	Portugal
8167	94	Alexander Sørloth	Offence	1995-12-05	Norway
8467	94	Bertrand Traoré	Offence	1995-09-06	Burkina Faso
32719	94	Gerard Moreno	Offence	1992-04-07	Spain
176202	94	Ilias Akhomach	Offence	2004-04-16	Spain
180081	94	Yeremy	Offence	2002-10-20	Spain
185104	94	Alex Forés	Offence	2001-04-12	Spain
192121	94	Jorge Pascual	Offence	2003-04-09	Spain
213275	94	José Morales	Offence	1987-07-23	Spain
213278	94	Álex Baena	Offence	2001-07-20	Spain
33136	95	Jaume Doménech	Goalkeeper	1990-11-05	Spain
33137	95	Cristian	Goalkeeper	1998-03-21	Spain
84506	95	Giorgi Mamardashvili	Goalkeeper	2000-09-29	Georgia
251106	95	Vicent Abril	Goalkeeper	2005-02-15	Spain
8456	95	Mouctar Diakhaby	Defence	1996-12-19	France
8780	95	Dimitri Foulquier	Defence	1993-03-23	Guadeloupe
33146	95	Gaya	Defence	1995-05-25	Spain
98674	95	Hugo Guillamón	Defence	2000-01-31	Spain
99811	95	Thierry Correia	Defence	1999-03-09	Portugal
127140	95	Cenk Özkacar	Defence	2000-10-06	Turkey
157190	95	Jesus Vazquez Alcalde	Defence	2003-01-02	Spain
172839	95	Cristhian Mosquera	Defence	2004-06-27	Spain
176602	95	Ruben Iranzo	Defence	2003-03-14	Spain
221412	95	Yarek Gasiorowski	Defence	2005-01-12	Spain
9208	95	Selim Amallah	Midfield	1996-11-15	Morocco
33270	95	Pepelu	Midfield	1998-08-11	Spain
37539	95	André Almeida	Midfield	2000-05-30	Portugal
144919	95	Marco Camús	Midfield	2001-11-16	Spain
176733	95	Peter Gonzalez	Midfield	2002-07-25	Spain
177180	95	Javier Guerra	Midfield	2003-05-13	Spain
187117	95	Fran Perez	Midfield	2002-09-09	Spain
192159	95	Alberto Mari	Midfield	2001-07-11	Spain
214182	95	Martin Tejón	Midfield	2004-04-12	Spain
229065	95	Javier Navarro	Midfield	2004-02-24	Spain
244650	95	Ali Fadal	Midfield	2004-01-14	Ghana
4442	95	Sergi Canós	Offence	1997-02-02	Spain
8922	95	Roman Yaremchuk	Offence	1995-11-27	Ukraine
32762	95	Hugo Duro	Offence	1999-11-10	Spain
136929	95	Pablo Gozalbez	Offence	2001-04-30	Spain
175892	95	Hugo Gonzalez	Offence	2003-02-07	Spain
180061	95	Diego López	Offence	2002-05-13	Spain
181914	95	Mario Dominguez	Offence	2004-02-10	Spain
229070	95	Joselu Pérez	Offence	2004-03-12	Spain
244743	95	David Otorbi	Offence	2007-10-16	Spain
283	263	Sivera	Goalkeeper	1996-08-11	Spain
123682	263	Jesús Owono	Goalkeeper	2001-03-01	Equatorial Guinea
142453	263	Adrian Rodriguez	Goalkeeper	2000-12-12	Argentina
217578	263	Gaizka García	Goalkeeper	2005-02-17	Spain
33091	263	Andoni Gorosabel	Defence	1996-08-04	Spain
33237	263	Rubén Duarte	Defence	1995-10-18	Spain
46123	263	Nahuel Tenaglia	Defence	1996-02-21	Argentina
64424	263	Aleksandar Sedlar	Defence	1991-12-13	Serbia
81187	263	Abdelkabir Abqar	Defence	1999-03-10	Morocco
111570	263	Alex Sola	Defence	1999-06-09	Spain
119282	263	Victor Parada	Defence	2002-04-04	Spain
168657	263	Eneko Ortiz	Defence	2003-05-26	Spain
176758	263	Rafa Marin	Defence	2002-05-19	Spain
177503	263	Joseda Alvarez	Defence	2001-01-22	Spain
180060	263	Javi López	Defence	2002-03-25	Spain
244942	263	Egoitz Muñoz	Defence	2005-01-01	Spain
10995	263	Ianis Hagi	Midfield	1998-10-22	Romania
28663	263	Carlos Benavidez	Midfield	1998-03-30	Uruguay
33092	263	Jon Guridi	Midfield	1995-02-28	Spain
33093	263	Ander Guevara	Midfield	1997-07-07	Spain
157626	263	Antonio Blanco	Midfield	2000-07-23	Spain
171862	263	Xeber Alkain	Midfield	1997-06-26	Spain
171964	263	Giuliano Simeone	Midfield	2002-12-18	Italy
176854	263	Tomas Mendes	Midfield	2004-11-21	Spain
184988	263	Abde Rebbach	Midfield	1998-08-11	Algeria
203546	263	José de León	Midfield	2004-03-02	Dominican Republic
213404	263	Carlos Vicente	Midfield	1999-04-23	Spain
215414	263	Selu Diallo	Midfield	2003-10-01	Spain
215614	263	Ander Sánchez	Midfield	2004-01-24	Spain
250990	263	Álvaro García	Midfield	2005-09-15	Spain
33358	263	Kike García	Offence	1989-11-25	Spain
50907	263	Luis Rioja	Offence	1993-10-16	Spain
203561	263	Joaquín Panichelli	Offence	2002-10-07	Argentina
215434	263	Samu Omorodion	Offence	2004-05-05	Nigeria
32345	264	David Gil	Goalkeeper	1994-01-11	Spain
45996	264	Jeremías Ledesma	Goalkeeper	1993-02-13	Argentina
177418	264	Victor Aznar	Goalkeeper	2002-10-17	Brazil
206275	264	Nando Almodovar	Goalkeeper	2003-11-03	Spain
189	264	Jorge Meré	Defence	1997-04-17	Spain
270	264	Joseba Zaldúa	Defence	1992-06-24	Spain
32485	264	Fali Jiménez	Defence	1993-08-12	Spain
32808	264	Luis Hernández	Defence	1989-04-14	Spain
115278	264	Aiham Ousou	Defence	2000-01-09	Syria
151557	264	Víctor Chust	Defence	2000-03-05	Spain
177627	264	Lucas Pires	Defence	2001-03-24	Brazil
180054	264	Iza	Defence	1993-04-23	Spain
180173	264	Javi Hernández	Defence	1998-05-02	Spain
186081	264	Momo Mbaye	Defence	1998-06-28	Senegal
186567	264	Kikin	Defence	2003-01-20	Spain
227059	264	Álex García	Defence	2006-07-06	Spain
228741	264	Adri Salguero	Defence	2003-05-20	Spain
228743	264	Miranda	Defence	2003-04-26	Spain
228744	264	Julio Cabrera	Defence	2003-08-14	Spain
10964	264	Youba Diarra	Midfield	1998-03-24	Mali
15103	264	Diadié Samassékou	Midfield	1996-01-11	Mali
32130	264	Fede San Emeterio	Midfield	1997-03-16	Spain
32316	264	José Mari	Midfield	1987-12-06	Spain
32338	264	Álex	Midfield	1992-10-15	Spain
32643	264	Rubén Alcaraz	Midfield	1991-05-01	Spain
33344	264	Gonzalo Escalante	Midfield	1993-03-27	Argentina
33351	264	Iván Alejo Peralta	Midfield	1995-02-10	Spain
72752	264	Brian Ocampo	Midfield	1999-06-25	Uruguay
101870	264	Roberto Navarro	Midfield	2002-04-12	Spain
203439	264	Karl Etta Eyong	Midfield	2003-10-14	Cameroon
203453	264	Moussa Diakité	Midfield	2003-11-04	Mali
2	264	Juanmi	Offence	1993-05-20	Spain
258	264	Rubén Sobrino	Offence	1992-06-01	Spain
8415	264	Rominigue Kouamé	Offence	1996-12-17	Mali
32063	264	Darwin Machís	Offence	1993-02-07	Venezuela
32310	264	Sergi Guardiola	Offence	1991-05-29	Spain
32947	264	Roger Martí	Offence	1991-01-03	Spain
172113	264	Chris Ramos	Offence	1997-01-18	Spain
180079	264	Maximiliano Gómez	Offence	1996-08-14	Uruguay
227976	264	Njalla	Offence	2003-04-13	Cameroon
253004	264	Borja Vázquez	Offence	2005-01-18	Spain
32187	267	Diego Mariño	Goalkeeper	1990-05-09	Spain
32586	267	Fernando Martínez	Goalkeeper	1990-06-10	Spain
39348	267	Luís Maximiano	Goalkeeper	1999-01-05	Portugal
217422	267	Bruno Iribarne	Goalkeeper	2004-08-18	Spain
15928	267	Alejandro Pozo	Defence	1999-02-22	Spain
39246	267	César Montes	Defence	1997-02-24	Mexico
58580	267	Édgar González	Defence	1997-04-01	Spain
74676	267	Aleksandar Radovanović	Defence	1993-11-11	Serbia
81437	267	Álex Centelles	Defence	1999-08-30	Spain
125171	267	Bruno Langa	Defence	1997-10-31	Mozambique
172111	267	Chumi	Defence	1999-03-02	Spain
176745	267	Marc Pubill	Defence	2003-06-20	Spain
206289	267	Marcos Pena	Defence	2005-01-22	Spain
221356	267	Paco Sanz	Defence	2004-11-15	Spain
228406	267	Carlos Ballestero	Defence	2004-04-24	Spain
32108	267	Adri Embarba	Midfield	1992-05-07	Spain
46344	267	Lucas Robertone	Midfield	1997-03-18	Argentina
81393	267	Iddrisu Baba	Midfield	1996-01-22	Ghana
126427	267	Dion Lopy	Midfield	2002-02-02	Senegal
144668	267	Luka Romero	Midfield	2004-11-18	Argentina
151029	267	Sergio Arribas	Midfield	2001-09-30	Spain
168431	267	Jonathan Viera	Midfield	1989-10-21	Spain
170057	267	Gonzalo Melero	Midfield	1994-01-02	Spain
207131	267	Marcos Peña	Midfield	2005-01-22	Spain
32386	267	Luis Suárez	Offence	1997-12-02	Colombia
32483	267	Anthony Lozano	Offence	1993-04-25	Honduras
32721	267	Léo Baptistão	Offence	1992-08-26	Brazil
37968	267	Ibrahima Koné	Offence	1999-06-16	Mali
136349	267	Largie Ramazani	Offence	2001-02-27	Belgium
172231	267	Marko Milovanovic	Offence	2003-08-04	Serbia
230356	267	Rachad Fettal	Offence	2005-01-16	Spain
32016	275	Aarón	Goalkeeper	1995-09-27	Spain
100130	275	Álvaro Vallés Rosa	Goalkeeper	1997-07-25	Spain
203599	275	Álex González	Goalkeeper	2002-08-08	Spain
247055	275	Álvaro Killane	Goalkeeper	2004-12-14	Argentina
7558	275	Daley Sinkgraven	Defence	1995-07-04	Netherlands
32883	275	Álvaro Lemos	Defence	1993-03-30	Spain
74575	275	Omenuke Mfulu	Defence	1994-03-20	DR Congo
182277	263	Giorgi Gagua	Offence	2001-10-10	Georgia
102043	275	Eric Curbelo	Defence	1994-01-14	Spain
113335	275	Julian Araujo	Defence	2001-08-13	Mexico
123689	275	Saúl Coco	Defence	1999-02-09	Equatorial Guinea
130273	275	Álex Suárez	Defence	1993-03-18	Spain
176832	275	Mika Marmol	Defence	2001-07-01	Spain
180289	275	Sergi Cardona	Defence	1999-07-08	Spain
214421	275	Juanma	Defence	2004-05-13	Spain
8571	275	Enzo Loiodice	Midfield	2000-11-27	France
31969	275	Javi Muñoz	Midfield	1995-02-28	Spain
33080	275	Pejiño	Midfield	1996-07-29	Spain
33323	275	Benito Ramírez	Midfield	1995-07-11	Spain
33324	275	Fabio González	Midfield	1997-02-12	Spain
119386	275	Kirian Rodríguez	Midfield	1996-03-05	Spain
151030	275	Marvin Olawale Akinlabi Park	Midfield	2000-07-03	Spain
170055	275	José Campaña	Midfield	1993-05-31	Spain
179159	275	Maximo Perrone	Midfield	2003-01-07	Argentina
217447	275	Iñaki González	Midfield	2004-07-27	Spain
228739	275	Gabriel Felipe	Midfield	2002-01-15	Spain
228742	275	Yadam Santana	Midfield	2002-03-14	Spain
245397	275	Aboubacar Bassinga	Midfield	2005-07-13	Ivory Coast
11589	275	Sandro	Offence	1995-07-09	Spain
15872	275	Marc Cardona	Offence	1995-07-08	Spain
32889	275	Cristian Herrera	Offence	1991-03-13	Spain
33243	275	Munir El Haddadi	Offence	1995-09-01	Morocco
33465	275	Sory Kaba	Offence	1995-07-28	Guinea
150533	275	Alberto Moleiro	Offence	2003-09-30	Spain
228740	275	Pau Ferrer	Offence	2003-10-17	Spain
244666	275	Déogracias Bassinga	Offence	2005-08-11	Congo
7993	298	Paulo Gazzaniga	Goalkeeper	1992-01-02	Argentina
32854	298	Juan Carlos	Goalkeeper	1988-01-20	Spain
171863	298	Toni Fuidias	Goalkeeper	2001-04-15	Spain
7899	298	Daley Blind	Defence	1990-03-09	Netherlands
32712	298	David López	Defence	1989-10-09	Spain
33511	298	Juanpe	Defence	1991-04-30	Spain
101345	298	Eric García	Defence	2001-01-09	Spain
102497	298	Iván Martín	Defence	1999-02-14	Spain
144283	298	Yan Couto	Defence	2002-06-03	Brazil
144953	298	Miguel Gutiérrez	Defence	2001-07-27	Spain
151744	298	Arnau Martinez	Defence	2003-04-25	Spain
228420	298	Antal Yaakobishvili	Defence	2004-07-12	Hungary
16173	298	Viktor Tsyhankov	Midfield	1997-11-15	Ukraine
33522	298	Borja García	Midfield	1990-11-02	Spain
33524	298	Aleix García	Midfield	1997-06-28	Spain
77734	298	Yangel Herrera	Midfield	1998-01-07	Venezuela
98753	298	Valery	Midfield	1999-11-23	Spain
159520	298	Pablo Torre	Midfield	2003-04-03	Spain
178361	298	Jhon Solis	Midfield	2004-03-10	Colombia
180175	298	Ricard Artero	Midfield	2003-02-05	Spain
214404	298	Iker Almena	Midfield	2004-05-04	Spain
214406	298	Silvi	Midfield	2005-01-29	Spain
3171	298	Cristhian Stuani	Offence	1986-10-12	Uruguay
24217	298	Artem Dovbyk	Offence	1997-06-21	Ukraine
32375	298	Toni Villa	Offence	1995-01-07	Spain
33523	298	Portu	Offence	1992-05-21	Spain
146352	298	Sávio	Offence	2004-04-10	Brazil
220122	298	Jastin García	Offence	2004-01-15	Spain
244589	298	Juan Arango	Offence	2006-06-27	Venezuela
244681	298	Álex Almansa	Offence	2003-11-08	Spain
250803	298	Carles Garrido	Offence	2004-10-04	Spain
3121	558	Vicente Guaita	Goalkeeper	1987-01-10	Spain
32918	558	Iván Villar	Goalkeeper	1997-07-09	Spain
175870	558	Coke Carrillo	Goalkeeper	2002-01-07	Spain
178053	558	Cesar Fernandez	Goalkeeper	2004-01-28	Spain
192818	558	Raul Garcia	Goalkeeper	2000-01-27	Spain
7928	558	Javier Manquillo	Defence	1994-05-05	Spain
8968	558	Joseph Aidoo	Defence	1995-09-29	Ghana
31019	558	Carl Starfelt	Defence	1995-06-01	Sweden
32584	558	Unai Núñez	Defence	1997-01-30	Spain
57610	558	Mihajlo Ristić	Defence	1995-10-31	Serbia
97146	558	Kevin Vázquez	Defence	1993-03-23	Spain
118715	558	Manuel Sánchez	Defence	2000-08-24	Spain
146986	558	Óscar Mingueza	Defence	1999-05-13	Spain
159446	558	Carlos Dominguez	Defence	2001-01-01	Spain
166375	558	Joel López	Defence	2002-03-31	Spain
189528	558	Martin Conde	Defence	2003-03-25	Spain
192197	558	Javi Dominguez	Defence	2001-03-26	Spain
229003	558	Javi Rodríguez	Defence	2003-06-26	Spain
253001	558	Javi Rueda	Defence	2002-05-08	Spain
1137	558	Jailson	Midfield	1995-09-07	Brazil
3782	558	Renato Tapia	Midfield	1995-07-28	Peru
3968	558	Luca de la Torre	Midfield	1998-05-23	USA
16747	558	Franco Cervi	Midfield	1994-05-26	Argentina
32111	558	Fran Beltrán	Midfield	1999-02-03	Spain
168650	558	Hugo Sotelo	Midfield	2003-12-19	Spain
170438	558	Williot Swedberg	Midfield	2004-02-01	Sweden
175869	558	Hugo Alvarez	Midfield	2003-07-02	Spain
189380	558	Carlos Dotor	Midfield	2001-03-15	Spain
252993	558	Yoel Lago	Midfield	2004-03-25	Spain
3201	558	Iago Aspas	Offence	1987-08-01	Spain
8547	558	Jonathan Bamba	Offence	1996-03-26	Ivory Coast
32324	558	Alfonso González	Offence	1999-05-04	Spain
32510	558	Carles Pérez	Offence	1998-02-16	Spain
43285	558	Anastasios Douvikas	Offence	1999-08-02	Greece
150525	558	Miguel Rodríguez	Offence	2003-04-29	Spain
166029	558	Tadeo Allende	Offence	1999-02-20	Argentina
213269	558	Jørgen Strand Larsen	Offence	2000-02-06	Norway
3430	559	Marko Dmitrović	Goalkeeper	1992-01-24	Serbia
6843	559	Ørjan Nyland	Goalkeeper	1990-09-10	Norway
161304	559	Rafa Romero	Goalkeeper	2003-08-07	Spain
177573	559	Alberto Flores	Goalkeeper	2003-11-10	Spain
191198	559	Matias Arbol	Goalkeeper	2002-09-12	Spain
54	559	Jesús Navas	Defence	1985-11-21	Spain
3192	559	Sergio Ramos	Defence	1986-03-30	Spain
3212	559	Marcos Acuña	Defence	1991-10-28	Argentina
21410	559	Nemanja Gudelj	Defence	1991-11-16	Serbia
45449	559	Marcão	Defence	1996-06-05	Brazil
127127	559	Nianzou Kouassi	Defence	2002-06-07	France
136039	559	Loïc Bade	Defence	2000-04-11	France
178107	559	Kike Salas	Defence	2002-04-23	Spain
180038	559	Juanlu	Defence	2003-08-15	Spain
190843	559	Diego Hormigo	Defence	2003-04-16	Spain
213280	559	Adrià Pedrosa	Defence	1998-05-13	Spain
228998	559	Darío Benavides	Defence	2003-01-12	Spain
1752	559	Suso	Midfield	1993-11-19	Spain
8005	559	Erik Lamela	Midfield	1992-03-04	Argentina
8128	559	Dodi Lukebakio	Midfield	1997-09-24	Belgium
8406	559	Boubakary Soumaré	Midfield	1999-02-27	France
10210	559	Adnan Januzaj	Midfield	1995-02-05	Belgium
15911	559	Óliver Torres	Midfield	1994-11-10	Spain
16275	559	Djibril Sow	Midfield	1997-02-06	Switzerland
98223	559	Lucien Agoume	Midfield	2002-02-09	France
169325	559	Hannibal Mejbri	Midfield	2003-01-21	Tunisia
192043	559	Lulo Dasilva	Midfield	2002-10-04	Spain
213257	559	Joan Jordán	Midfield	1994-07-06	Spain
213279	559	Manuel Bueno	Midfield	2004-07-27	Spain
229008	559	Isra Domínguez	Midfield	2003-05-07	Spain
244911	559	Alberto Collado	Midfield	2005-04-16	Spain
244952	559	Miguel Capitas	Midfield	2001-03-06	Spain
4098	559	Rafael Mir	Offence	1997-06-18	Spain
8358	559	Lucas Ocampos	Offence	1994-07-11	Argentina
8474	559	Mariano Díaz	Offence	1993-08-01	Dominican Republic
32836	559	Youssef En-Nesyri	Offence	1997-06-01	Morocco
170962	559	Alejo Veliz	Offence	2003-09-19	Argentina
213043	559	Isaac	Offence	2000-05-18	Spain
221295	559	Stanis Idumbo-Muzambo	Offence	2005-06-29	Belgium
244598	559	Ibrahima Sow	Offence	2007-01-26	Senegal
244751	559	Oso	Offence	2003-07-09	Spain
173617	79	Pablo Ibáñez Tébar	Midfield	1998-09-20	Spain
182245	2	Umut Tohumcu	Midfield	2004-08-11	Germany
182270	263	Unai Ropero	Midfield	2001-11-20	Spain
204759	559	Xavi Sintes	Midfield	2001-08-05	Spain
181901	66	Alejandro Garnacho	Offence	2004-07-01	Argentina
182274	109	Samuel Iling-Junior	Offence	2003-10-04	England
182280	4	Julien Duranville	Offence	2006-05-05	Belgium
181936	83	Miguel Angel Brau	Defence	2001-12-27	Spain
182269	558	Damian Rodriguez	Defence	2003-03-17	Spain
187401	354	Kaden Rodney	Defence	2004-10-07	England
98754	511	Álex Domínguez	Goalkeeper	1998-07-30	Spain
161354	511	Thomas Himeur	Goalkeeper	2001-01-17	France
178669	511	Guillaume Restes	Goalkeeper	2005-03-11	France
212867	511	Justin Lacombe	Goalkeeper	2003-04-09	France
814	511	Logan Costa	Defence	2001-04-01	Cape Verde Islands
21385	511	Gabriel Suazo	Defence	1997-08-09	Chile
24190	511	Rasmus Nicolaisen	Defence	1997-03-16	Denmark
24302	511	Mikkel Desler	Defence	1995-02-19	Denmark
119064	511	Moussa Diarra	Defence	2000-11-10	Mali
160414	511	Kévin Keben Biakolo	Defence	2004-01-26	Cameroon
180519	511	Warren Kamanzi	Defence	2000-11-11	Norway
188481	511	Christian Mawissa	Defence	2005-04-18	France
204253	511	Ilyes Aradj	Defence	2005-06-05	France
246113	511	Nicolas Wasbauer	Defence	2004-07-04	France
4621	511	Denis Genreau	Midfield	1999-05-21	Australia
7758	511	Stijn Spierings	Midfield	1996-03-12	Netherlands
9455	511	Niklas Schmidt	Midfield	1998-03-01	Germany
9490	511	Vincent Sierro	Midfield	1995-10-08	Switzerland
59126	511	Naatan Skyttä	Midfield	2002-05-07	Finland
171438	511	Ibrahim Cissoko	Midfield	2003-03-26	Netherlands
172082	511	Cesar Gelabert Pina	Midfield	2000-10-31	Spain
190875	511	Edhy Zuliani	Midfield	2004-08-11	Algeria
192688	511	Aron Dönnum	Midfield	1998-04-20	Norway
212934	511	Noah Lahmadi	Midfield	2005-01-05	France
250994	511	Rafik Messali	Midfield	2003-04-28	Algeria
9848	511	Thijs Dallinga	Offence	2000-08-03	Netherlands
80175	511	Yann Gboho	Offence	2001-01-14	France
81085	511	Zakaria Aboukhlal	Offence	2000-02-18	Morocco
81229	511	Cristian Cásseres Jr.	Offence	2000-01-20	Venezuela
176747	511	Frank Magri	Offence	1999-09-04	France
206334	511	Bonota Traore	Offence	2003-06-30	France
212589	511	Shavy Warren Babicka	Offence	2000-06-01	Gabon
212975	511	Noah Edjouma	Offence	2005-10-04	France
731	512	Grégoire Coudert	Goalkeeper	1999-04-03	France
7675	512	Marco Bizot	Goalkeeper	1991-03-10	Netherlands
221769	512	Yann Marillat	Goalkeeper	1994-08-12	France
441	512	Brendan Chardonnet	Defence	1994-12-22	France
8350	512	Jordan Amavi	Defence	1994-03-09	France
8778	512	Kenny Lala	Defence	1991-10-03	France
119418	512	Julien Le Cardinal	Defence	1997-08-03	France
123200	512	Lilian Brassier	Defence	1999-11-02	France
171659	512	Bradley Locko	Defence	2002-05-06	France
221341	512	Antonin Cartillier	Defence	2004-06-23	France
227982	512	Luc Zogbe	Defence	2005-03-24	Ivory Coast
248746	512	Tommy Le Verge	Defence	2005-10-28	France
722	512	Mathias Pereira Lage	Midfield	1996-11-30	Portugal
856	512	Romain Del Castillo	Midfield	1996-03-29	France
8439	512	Pierre Lees Melou	Midfield	1993-05-25	France
8542	512	Mahdi Camara	Midfield	1998-06-30	France
8788	512	Jonas Martin	Midfield	1990-04-09	France
76145	512	Hugo Magnetti	Midfield	1998-05-30	France
122510	512	Adrien Lebeau	Midfield	1998-01-26	France
172283	512	Axel Camblan	Midfield	2003-06-18	France
175942	512	Kamory Doumbia	Midfield	2003-02-18	Mali
8193	512	Steve Mounié	Offence	1994-09-29	Benin
134582	512	Jérémy Le Douaron	Offence	1998-04-21	France
152458	512	Martin Satriano	Offence	2001-02-20	Uruguay
217659	512	Djibril Konté	Offence	2002-11-04	France
32695	516	Pau López	Goalkeeper	1994-12-13	Spain
33614	516	Rubén Blanco	Goalkeeper	1995-07-25	Spain
137322	516	Simon Ngapandouetnbu	Goalkeeper	2003-12-04	Cameroon
178114	516	Jelle Van Neck	Goalkeeper	2004-03-07	Belgium
238	516	Ulisses Garcia	Defence	1996-01-11	Switzerland
1023	516	Jonathan Clauss	Defence	1992-09-25	France
7918	516	Chancel Mbemba	Defence	1994-08-08	DR Congo
181927	512	Bilal Brahimi	Offence	2000-03-14	Algeria
8912	516	Samuel Gigot	Defence	1993-10-12	France
45512	516	Stéphane Sparagna	Defence	1995-02-17	France
82020	516	Leonardo Balerdi	Defence	1999-01-26	Argentina
160410	516	Quentin Merlin	Defence	2002-05-16	France
171044	516	Roggerio Nyakossi	Defence	2004-01-13	Switzerland
179436	516	Yakine Said M'Madi	Defence	2004-03-11	Comoros
179596	516	Bamo Meité	Defence	2001-06-20	Ivory Coast
188908	516	Michael Murillo	Defence	1996-02-11	Panama
221805	516	Léo Jousselin	Defence	2002-01-02	France
249616	516	Brice Negouai	Defence	2002-02-17	France
633	516	Pape Gueye	Midfield	1999-01-24	Senegal
1783	516	Jordan Veretout	Midfield	1993-03-01	France
3714	516	Amine Harit	Midfield	1997-06-18	Morocco
8695	516	Valentin Rongier	Midfield	1994-12-07	France
33149	516	Geoffrey Kondogbia	Midfield	1993-02-15	Central African Republic
82081	516	Sofiane Sidi Ali	Midfield	1995-07-14	France
94091	516	Iliman Ndiaye	Midfield	1999-07-22	Senegal
113434	516	Jean Onana	Midfield	2000-01-08	Cameroon
122511	516	Azzedine Ounahi	Midfield	2000-04-19	Morocco
169192	516	Paolo Sciortino	Midfield	2003-11-05	France
170409	516	Bilal Nadir	Midfield	2003-11-28	France
204245	516	Emran Soglo	Midfield	2005-07-11	England
204251	516	Raimane Daou	Midfield	2004-11-20	Comoros
221340	516	Noam Mayoka-Tika	Midfield	2003-11-02	Belgium
221826	516	Alexandre Tunkadi	Midfield	2005-10-20	France
250853	516	Gaël Lafont	Midfield	2006-06-07	France
77	516	Joaquín Correa	Offence	1994-08-13	Argentina
3638	516	Ismaïla Sarr	Offence	1998-02-25	Senegal
7801	516	Pierre-Emerick Aubameyang	Offence	1989-06-18	Gabon
115074	516	Luis Henrique	Offence	2001-12-14	Brazil
144651	516	Faris Moumbagna	Offence	2000-07-01	Cameroon
246025	516	Iuri Moreira	Offence	2004-03-24	Portugal
250795	516	Keyliane Abdallah	Offence	2006-04-05	France
250948	516	Darryl Bakola	Offence	2007-11-30	France
8365	518	Dimitry Bertaud	Goalkeeper	1998-06-06	France
8366	518	Benjamin Lecomte	Goalkeeper	1991-04-26	France
212855	518	Belmin Dizdarevic	Goalkeeper	2001-08-09	Bosnia-Herzegovina
800	518	Modibo Sagnan	Defence	1999-04-14	France
847	518	Théo Sainte-Luce	Defence	1998-10-20	France
8297	518	Christopher Jullien	Defence	1993-03-22	France
8298	518	Issiaga Sylla	Defence	1994-01-01	Guinea
31252	518	Silvan Hefti	Defence	1997-10-25	Switzerland
37107	518	Boubacar Kouyaté	Defence	1997-04-15	Mali
37446	518	Falaye Sacko	Defence	1995-05-01	Mali
96992	518	Becir Omeragic	Defence	2002-01-20	Switzerland
177393	518	Enzo Tchato	Defence	2002-11-23	Cameroon
187450	518	Teo Allix	Defence	2004-07-05	France
214511	518	Lucas Mincarelli	Defence	2004-06-24	France
575	518	Arnaud Nordin	Midfield	1998-06-17	France
852	518	Téji Savanier	Midfield	1991-12-22	France
8463	518	Jordan Ferri	Midfield	1992-03-12	France
98763	518	Musa Al Taamari	Midfield	1997-06-10	Jordan
111539	518	Léo Leroy	Midfield	2000-02-14	France
123108	518	Tanguy Coulibaly	Midfield	2001-02-18	France
125677	518	Joris Chotard	Midfield	2001-09-24	France
169344	518	Sacha Delaye	Midfield	2002-04-23	France
185003	518	Khalil Fayad	Midfield	2004-06-09	France
245467	518	Théo Chennahi	Midfield	2005-02-06	France
2018	518	Yann Karamoh	Offence	1998-07-08	Ivory Coast
3598	518	Wahbi Khazri	Offence	1991-02-08	Tunisia
82132	518	Akor Adams	Offence	2000-01-29	Nigeria
188039	518	Axel Gueguin	Offence	2005-03-24	France
221367	518	Yanis Issoufou	Offence	2006-10-28	France
230209	518	Othmane Maamma	Offence	2005-10-06	Morocco
246658	518	Junior Ndiaye	Offence	2005-03-29	France
4259	521	Vito Mannone	Goalkeeper	1988-03-02	Italy
8392	521	Adam Jakubech	Goalkeeper	1997-01-02	Slovakia
147896	521	Lucas Chevalier	Goalkeeper	2001-11-06	France
204236	521	Tom Negrel	Goalkeeper	2003-04-13	France
212871	521	Lisandru Olmeta	Goalkeeper	2005-07-21	France
227766	521	Mohamed-Amine Ezzarhouni	Goalkeeper	2006-03-29	France
3226	521	Ismaily	Defence	1990-01-11	Brazil
3361	521	Samuel Umtiti	Defence	1993-11-14	France
31531	521	Gabriel Gudmundsson	Defence	1999-04-29	Sweden
98745	521	Bafodé Diakité	Defence	2001-01-06	France
181933	521	Leny Yoro	Defence	2005-11-13	France
185196	521	Alexsandro Ribeiro	Defence	1999-08-09	Brazil
186692	521	Rafael Fernandes	Defence	2002-06-28	Portugal
188087	521	Tiago Santos	Defence	2002-07-23	Portugal
216223	521	Ousmane Touré	Defence	2005-02-18	France
250942	521	Vincent Burlet	Defence	2005-09-23	Belgium
2100	521	Adam Ounas	Midfield	1996-11-11	Algeria
6503	521	Nabil Bentaleb	Midfield	1994-11-24	Algeria
7910	521	Angel Gomes	Midfield	2000-08-31	England
8541	521	Rémy Cabella	Midfield	1990-03-08	France
8811	521	Benjamin André	Midfield	1990-08-03	France
30299	521	Yusuf Yazıcı	Midfield	1997-01-29	Turkey
154584	521	Ignacio Miramon	Midfield	2003-06-12	Argentina
190846	521	Ichem Ferrah	Midfield	2005-09-23	France
212857	521	Aaron Malouda	Midfield	2005-11-30	France
213221	521	Hákon Haraldsson	Midfield	2003-04-10	Iceland
220585	521	Adame Faiz	Midfield	2005-06-10	France
221819	521	Ayyoub Bouaddi	Midfield	2007-10-02	France
227765	521	Lilian Baret	Midfield	2006-05-25	France
4095	521	Ivan Cavaleiro	Offence	1993-10-18	Portugal
8924	521	Jonathan David	Offence	2000-01-14	Canada
8990	521	Edon Zhegrova	Offence	1999-03-31	Kosovo
150925	521	Tiago Fonseca Morais	Offence	2003-09-03	Portugal
248780	521	Trévis Dago	Offence	2005-01-21	France
8686	522	Maxime Dupé	Goalkeeper	1993-03-04	France
147975	522	Teddy Boulhendi	Goalkeeper	2001-04-09	France
167416	522	Marcin Bulka	Goalkeeper	1999-10-04	Poland
8425	522	Dante	Defence	1983-10-18	Brazil
8435	522	Romain Perraud	Defence	1997-09-22	France
8559	522	Valentin Rosier	Defence	1996-08-19	France
182886	521	Andrej Ilic	Offence	2000-04-03	Serbia
16276	522	Jordan Lotomba	Defence	1998-09-29	Switzerland
79903	522	Jean-Clair Todibo	Defence	1999-12-30	France
133188	522	Alexis Beka Beka	Defence	2001-03-29	France
136721	522	Melvin Bard	Defence	2000-11-06	France
168667	522	Antoine Mendy	Defence	2004-05-27	France
172057	522	Youssouf Ndayishimiye	Defence	1998-10-27	Burundi
181923	522	Yannis Nahounou	Defence	2004-05-16	France
220121	522	Amidou Doumbouya	Defence	2007-08-05	France
4121	522	Jérémie Boga	Midfield	1997-01-03	Ivory Coast
7448	522	Pablo Rosario	Midfield	1997-01-07	Netherlands
8355	522	Morgan Sanson	Midfield	1994-08-18	France
76723	522	Sofiane Diop	Midfield	2000-06-09	France
99251	522	Khéphren Thuram-Ulie	Midfield	2001-03-26	France
123508	522	Hicham Boudaoui	Midfield	1999-09-23	Algeria
204237	522	Tom Louchet	Midfield	2003-05-04	France
204254	522	Daouda Traoré	Midfield	2006-07-22	France
245465	522	Sami Wattel	Midfield	2006-01-15	France
608	522	Alexis Claude Maurice	Offence	1998-06-06	France
8517	522	Gaëtan Laborde	Offence	1994-05-03	France
113427	522	Terem Moffi	Offence	1999-05-25	Nigeria
128710	522	Evann Guessand	Offence	2001-07-01	France
167685	522	Aliou Balde	Offence	2002-12-12	Senegal
213270	522	Mohamed Cho	Offence	2004-01-19	France
1331	523	Lucas Perri	Goalkeeper	1997-12-10	Brazil
3240	523	Anthony Lopes	Goalkeeper	1990-10-01	Portugal
244704	523	Justin Jose Bengui Joao	Goalkeeper	2005-07-09	France
1409	523	Adryelson	Defence	1998-03-23	Brazil
1464	523	Henrique	Defence	1994-04-25	Brazil
3208	523	Nicolás Tagliafico	Defence	1992-08-31	Argentina
7859	523	Dejan Lovren	Defence	1989-07-05	Croatia
8977	523	Clinton Mata	Defence	1992-11-07	Angola
10206	523	Duje Ćaleta-Car	Defence	1996-09-17	Croatia
131569	523	Jake O'Brien	Defence	2001-05-15	Ireland
141637	523	Sinaly Diomandé	Defence	2001-04-09	Ivory Coast
176942	523	Sael Kumbedi	Defence	2005-03-26	France
366	523	Corentin Tolisso	Midfield	1994-08-03	France
3438	523	Nemanja Matić	Midfield	1988-08-01	Serbia
7792	523	Ainsley Maitland-Niles	Midfield	1997-08-29	England
9398	523	Orel Mangala	Midfield	1998-03-18	Belgium
43707	523	Mama Baldé	Midfield	1995-11-06	Guinea-Bissau
81737	523	Paul Akouokou	Midfield	1997-12-20	Ivory Coast
101350	523	Maxence Caqueret	Midfield	2000-02-15	France
133242	523	Rayan Cherki	Midfield	2003-08-17	France
149044	523	Johann Lepenant	Midfield	2002-10-22	France
179598	523	Mohamed Elarouch	Midfield	2004-04-06	France
184726	523	Ernest Nuamah	Midfield	2003-11-01	Ghana
187065	523	Malick Fofana	Midfield	2005-03-31	Belgium
189683	523	Chaïm El Djebali	Midfield	2004-02-07	Tunisia
699	523	Saïd Benrahma	Offence	1995-08-10	Algeria
7797	523	Alexandre Lacazette	Offence	1991-05-28	France
191892	523	Gift Orban	Offence	2002-07-17	Nigeria
221812	523	Mahamadou Diawara	Offence	2005-02-17	France
51	524	Keylor Navas	Goalkeeper	1986-12-15	Costa Rica
55	524	Sergio Rico	Goalkeeper	1993-09-01	Spain
1731	524	Gianluigi Donnarumma	Goalkeeper	1999-02-25	Italy
16261	524	Alexandre Letellier	Goalkeeper	1990-12-11	France
146023	524	Arnau Tenas	Goalkeeper	2001-05-30	Spain
212856	524	Louis Mouquet	Goalkeeper	2004-07-21	Portugal
53	524	Achraf Hakimi	Defence	1998-11-04	Morocco
2007	524	Milan Škriniar	Defence	1995-02-11	Slovakia
3225	524	Marquinhos	Defence	1994-05-14	Brazil
3363	524	Presnel Kimpembe	Defence	1995-08-13	France
3365	524	Lucas Hernández	Defence	1996-02-14	France
8371	524	Nordi Mukiele	Defence	1997-11-01	France
8478	524	Layvin Kurzawa	Defence	1992-09-04	France
144570	524	Nuno Mendes	Defence	2002-06-19	Portugal
169204	524	Lucas Beraldo	Defence	2003-11-24	Brazil
204247	524	Serif Nhaga	Defence	2005-09-01	Portugal
246542	524	Kouakou Gadou	Defence	2007-01-17	France
246711	524	Yoram Zague	Defence	2006-05-15	France
22	524	Fabián Ruiz	Midfield	1996-04-03	Spain
52	524	Marco Asensio	Midfield	1996-01-21	Spain
15909	524	Danilo Pereira	Midfield	1991-09-09	Portugal
28549	524	Manuel Ugarte	Midfield	2001-04-11	Uruguay
33148	524	Carlos Soler	Midfield	1997-01-02	Spain
172762	524	Bradley Barcola	Midfield	2002-09-02	France
178722	524	Vitinha	Midfield	2000-02-13	Portugal
186089	524	Warren Zaïre-Emery	Midfield	2006-03-08	France
213217	524	Kang-in Lee	Midfield	2001-02-19	South Korea
218468	524	Ethan Mbappé	Midfield	2006-12-29	France
246066	524	Senny Mayulu	Midfield	2006-05-17	France
3373	524	Ousmane Dembélé	Offence	1997-05-15	France
3374	524	Kylian Mbappé	Offence	1998-12-20	France
8708	524	Randal Kolo Muani	Offence	1998-12-05	France
101431	524	Gonçalo Ramos	Offence	2001-06-20	Portugal
2345	525	Alfred Gomis	Goalkeeper	1993-09-05	Senegal
9534	525	Yvon Mvogo	Goalkeeper	1994-06-06	Switzerland
123203	525	Dominique Youfeigane	Goalkeeper	2000-02-07	Central African Republic
566	525	Laurent Abergel	Defence	1993-02-01	France
713	525	Julien Laporte	Defence	1993-11-04	France
7882	525	Benjamin Mendy	Defence	1994-07-17	France
82600	525	Gédéon Kalulu	Defence	1997-08-29	DR Congo
131179	525	Darlin Yongwa	Defence	2000-09-21	Cameroon
149069	525	Souleymane Isaak Toure	Defence	2003-03-28	France
156630	525	Formose Mendy	Defence	2001-01-02	Senegal
157041	525	Loris Mouyokolo	Defence	2001-05-22	France
171397	525	Igor Silva	Defence	1996-08-21	Brazil
172520	525	Theo Le Bris	Defence	2002-10-01	France
177695	525	Montassar Talbi	Defence	1998-05-26	Tunisia
187473	525	Nathaniel Adjei	Defence	2002-08-21	Ghana
188658	525	Panos Katseris	Defence	2001-07-05	Greece
193599	525	Aurelien Pelon	Defence	2004-05-06	France
7812	525	Tiemoué Bakayoko	Midfield	1994-08-17	France
8303	525	Quentin Boisgard	Midfield	1997-03-17	France
8437	525	Jean-Victor Makengo	Midfield	1998-06-12	France
16100	525	Bonke Innocent	Midfield	1996-01-20	Nigeria
72551	525	Aiyegun Tosin	Midfield	1998-06-26	Benin
79889	525	Julien Ponceau	Midfield	2000-11-28	France
99830	525	Imran Louza	Midfield	1999-05-01	Morocco
185007	525	Badredine Bouanani	Midfield	2004-12-08	Algeria
186083	525	Ayman Kari	Midfield	2004-11-19	France
204241	525	Eli Kroupi	Midfield	2006-06-23	France
245416	525	Arthur Avon Ebong	Midfield	2004-12-15	Cameroon
245424	525	Gino Caoki	Midfield	2004-07-17	France
246114	525	Carmel Mabanza	Midfield	2003-08-13	DR Congo
166640	525	Ahmadou Bamba Dieng	Offence	2000-03-23	Senegal
213749	525	Mohamed Bamba	Offence	2001-12-10	Ivory Coast
245400	525	Royce Openda	Offence	2002-04-21	Gabon
899	529	Gauthier Gallon	Goalkeeper	1993-04-23	France
3356	529	Steve Mandanda	Goalkeeper	1985-03-28	France
108717	529	Geoffrey Lembet	Goalkeeper	1988-09-23	Central African Republic
230054	529	Yann Batola	Goalkeeper	2004-01-26	France
99691	529	Christopher Wooh	Defence	2001-09-18	Cameroon
135467	529	Warmed Omari	Defence	2000-04-23	France
135473	529	Guela Doué	Defence	2002-10-17	France
135482	529	Adrien Truffert	Defence	2001-11-20	France
145893	529	Arthur Theate	Defence	2000-05-25	Belgium
147893	529	Alidu Seidu	Defence	2000-06-04	Ghana
152692	529	Fabian Rieder	Defence	2002-02-16	Switzerland
177037	529	Jeanuel Belocian	Defence	2005-02-17	France
227004	529	Mahamadou Nagida	Defence	2005-06-28	Cameroon
250296	529	Rayan Bamba	Defence	2004-05-14	France
7566	529	Azor Matusiwa	Midfield	1998-04-28	Netherlands
8646	529	Baptiste Santamaria	Midfield	1995-03-09	France
8818	529	Benjamin Bourigeaud	Midfield	1994-01-14	France
48595	529	Keito Nakamura	Midfield	2000-07-28	Japan
96869	529	Ludovic Blas	Midfield	1997-12-31	France
99664	529	Enzo Le Fée	Midfield	2000-02-03	France
177522	529	Desire Doue	Midfield	2005-06-03	France
246322	529	Djaoui Cissé	Midfield	2004-01-31	France
8476	529	Amine Gouiri	Offence	2000-02-16	France
8797	529	Martin Terrier	Offence	1997-03-04	France
130668	529	Arnaud Kalimuendo	Offence	2002-01-20	France
171851	529	Bertug Yildirim	Offence	2002-07-12	Turkey
187098	529	Ibrahim Salah	Offence	2001-08-30	Morocco
217541	529	Mathis Lambourde	Offence	2006-01-09	France
870	533	Arthur Desmas	Goalkeeper	1994-04-07	France
8449	533	Mathieu Gorgelin	Goalkeeper	1990-08-05	France
248779	533	Paul Argney	Goalkeeper	2006-05-23	France
700	533	Christopher Operi	Defence	1997-04-29	France
1004	533	Gautier Lloris	Defence	1995-07-18	France
3700	533	Oualid El Hajjam	Defence	1991-02-19	Morocco
8775	533	Yoann Salmier	Defence	1992-11-21	French Guiana
63096	533	Loïc Nego	Defence	1991-01-15	Hungary
157842	533	Arouna Sangante	Defence	2002-04-12	Senegal
191246	533	Etienne Youte Kinkoue	Defence	2002-01-14	France
204280	533	Yoni Gomis	Defence	2005-09-23	France
214568	533	Cheick Doumbia	Defence	2004-10-18	France
221361	533	Aliou Thiare	Defence	2003-12-20	Senegal
3687	533	Daler Kuzyaev	Midfield	1993-01-15	Russia
8697	533	Abdoulaye Touré	Midfield	1994-03-03	France
157781	533	Oussama Targhalline	Midfield	2002-05-20	Morocco
169172	533	Yassine Kechta	Midfield	2002-02-25	Morocco
178663	533	Rassoul N'Diaye	Midfield	2001-12-11	France
191017	533	Antoine Joujou	Midfield	2003-03-12	France
204279	533	Simon Ebonog	Midfield	2004-08-16	France
206360	533	Makrane Bentoumi	Midfield	2005-11-16	France
728	533	Mohamed Bayo	Offence	1993-09-15	Guinea
7990	533	André Ayew	Offence	1989-12-17	Ghana
8627	533	Samuel Grandsir	Offence	1996-08-14	France
24260	533	Emmanuel Sabbi	Offence	1997-12-24	USA
152737	533	Josué Casimir	Offence	2001-09-24	Guadeloupe
187976	533	Alois Confais	Offence	1996-09-07	France
204321	533	Steve Ngoura	Offence	2005-02-22	France
204322	533	Andy Logbo	Offence	2004-05-06	France
20931	541	Mory Diaw	Goalkeeper	1993-06-22	France
171710	541	Massamba Ndiaye	Goalkeeper	2001-10-08	Senegal
186090	541	Théo Borne	Goalkeeper	2002-07-15	France
246305	541	Théo Ramousse	Goalkeeper	2005-02-06	France
499	541	Florent Ogier	Defence	1989-03-21	France
8325	541	Yoël Armougom	Defence	1998-06-05	France
8429	541	Andy Pelmard	Defence	2000-03-12	France
8803	541	Mehdi Zeffane	Defence	1992-05-19	France
9124	541	Maximiliano Caufriez	Defence	1997-02-16	Belgium
30972	541	Neto Borges	Defence	1996-09-13	Brazil
147912	541	Chrislain Matsima	Defence	2002-05-15	France
191921	541	Cheick Oumar Konate	Defence	2004-04-02	Mali
206127	541	Jeremy Jacquet	Defence	2005-07-13	France
244582	541	Mohamed Sylla	Defence	2004-01-30	France
250181	541	Ivan M'Bahia	Defence	2004-04-19	Ivory Coast
452	541	Johan Gastien	Midfield	1988-01-25	France
1816	541	Maxime Gonalons	Midfield	1989-03-10	France
74683	541	Yohann Magnin	Midfield	1997-06-21	France
185000	541	Muhammed Cham	Midfield	2000-09-26	Austria
192383	541	Stan Berkani	Midfield	2003-08-13	Algeria
832	541	Grejohn Kyei	Offence	1995-08-12	France
15674	541	Elbasan Rashani	Offence	1993-05-09	Kosovo
24336	541	Komnen Andrić	Offence	1995-07-01	Serbia
32155	541	Bilal Boutobba	Offence	1998-08-29	France
32315	541	Jérémie Bela	Offence	1993-04-08	Angola
84562	541	Shamar Nicholson	Offence	1997-03-16	Jamaica
101297	541	Jim Allevinah	Offence	1995-02-27	Gabon
150934	541	Alan Virginius	Offence	2003-01-03	France
166373	541	Habib Keita	Offence	2002-02-05	Mali
9535	548	Philipp Köhn	Goalkeeper	1998-04-02	Switzerland
63855	548	Radosław Majecki	Goalkeeper	1999-11-16	Poland
172431	548	Yann Lienard	Goalkeeper	2003-03-16	France
194	548	Ismail Jakobs	Defence	1999-08-17	Senegal
1612	548	Caio Henrique	Defence	1997-07-31	Brazil
6493	548	Thilo Kehrer	Defence	1996-09-21	Germany
81039	548	Mohammed Salisu	Defence	1999-04-17	Ghana
113375	548	Wilfried Singo	Defence	2000-12-25	Ivory Coast
154607	548	Vanderson	Defence	2001-06-21	Brazil
179599	548	Aurélien Platret	Defence	2003-02-20	France
179625	548	Soungoutou Magassa	Defence	2003-10-08	France
185069	548	Kassoum Ouattara	Defence	2004-10-14	France
188857	548	Nazim Babai	Defence	2003-01-14	Algeria
227011	548	Ritchy Valme	Defence	2005-02-03	Haiti
3683	548	Aleksandr Golovin	Midfield	1996-05-30	Russia
6687	548	Denis Zakaria	Midfield	1996-11-20	Switzerland
60424	548	Mohamed Camara	Midfield	2000-01-06	Mali
81299	548	Youssouf Fofana	Midfield	1999-01-10	France
175701	548	Maghnes Akliouche	Midfield	2002-02-25	Algeria
189287	548	Eliesse Ben Seghir	Midfield	2005-02-16	France
204238	548	Edan Diop	Midfield	2004-08-28	France
244898	548	Mamadou Coulibaly	Midfield	2004-04-21	France
245015	548	Saïmon Bouabré	Midfield	2006-06-01	France
248778	548	Mayssam Benama	Midfield	2005-03-09	France
73	548	Wissam Ben Yedder	Offence	1990-08-12	France
3483	548	Breel Embolo	Offence	1997-02-14	Switzerland
8887	548	Krépin Diatta	Offence	1999-02-25	Senegal
15100	548	Takumi Minamino	Offence	1995-01-16	Japan
246674	548	Lucas Michal	Offence	2005-06-22	France
733	543	Rémy Descamps	Goalkeeper	1996-06-25	France
8292	543	Alban Lafont	Goalkeeper	1999-01-23	France
8662	543	Denis Petrić	Goalkeeper	1988-05-24	Serbia
170640	543	Hugo Barbet	Goalkeeper	2001-11-22	France
444	543	Jean-Charles Castelletto	Defence	1995-01-26	Cameroon
776	543	Jean-Kevin Duverne	Defence	1997-08-12	France
8295	543	Kelvin Amian Adou	Defence	1998-02-08	France
8373	543	Nicolas Cozza	Defence	1999-01-08	France
8693	543	Nicolas Pallois	Defence	1987-09-19	France
30823	543	Eray Cömert	Defence	1998-02-04	Switzerland
170395	543	Yannis M'Bemba	Defence	2001-07-01	France
182059	543	Robin Voisine	Defence	2002-04-07	France
204248	543	Nathan Zézé	Defence	2005-06-18	France
214507	543	Bastien Meupiyou Menadjou	Defence	2006-03-19	France
245399	543	Hugo Boutsingkham	Defence	2003-01-20	France
246272	543	Enzo Mongo	Defence	2005-04-08	France
1076	543	Douglas Augusto	Midfield	1997-01-13	Brazil
7397	543	Pedro Chirivella	Midfield	1997-05-23	Spain
8001	543	Moussa Sissoko	Midfield	1989-08-16	France
8674	543	Marcus Coco	Midfield	1996-06-24	France
8701	543	Samuel Moutoussamy	Midfield	1996-08-12	DR Congo
31071	543	Tinotenda Kadewere	Midfield	1996-01-05	Zimbabwe
176999	543	Mohamed Achi Bouakline	Midfield	2002-01-16	France
180640	543	Bénie Traoré	Midfield	2002-11-30	Ivory Coast
192454	543	Stredair Appuah	Midfield	2004-06-27	France
251129	543	Mathis Oger	Midfield	2003-05-02	France
3398	543	Moses Simon	Offence	1995-07-12	Nigeria
8447	543	Ignatius Ganago	Offence	1999-02-16	Cameroon
8741	543	Florent Mollet	Offence	1991-11-19	France
114672	543	Mostafa Mohamed	Offence	1997-11-28	Egypt
170412	543	Matthis Abline	Offence	2003-03-28	France
178664	543	Abdoul Bamba	Offence	1994-05-25	France
185006	543	Joe-Loic Affamah	Offence	2002-06-29	France
245828	543	Adel Mahamoud	Offence	2003-02-04	Comoros
246193	543	Dehmaine Assoumani	Offence	2005-04-17	France
8661	545	Marc-Aurèle Caillard	Goalkeeper	1994-05-12	France
8769	545	Alexandre Oukidja	Goalkeeper	1988-07-19	Algeria
99584	545	Guillaume Dietsch	Goalkeeper	2001-04-17	France
4114	545	Maxime Colin	Defence	1991-11-15	France
8613	545	Christophe Hérelle	Defence	1992-08-22	France
8638	545	Ismaël Traoré	Defence	1986-08-18	Ivory Coast
8717	545	Matthieu Udol	Defence	1996-03-20	France
8752	545	Kévin N'Doram	Defence	1996-01-22	France
45199	545	Koffi Franck Kouao	Defence	1998-05-20	Ivory Coast
78634	545	Kévin Van Den Kerkhof	Defence	1996-03-14	Algeria
117370	545	Fali Candé	Defence	1998-01-24	Portugal
157855	545	Albin Demouchy	Defence	2002-05-31	France
185037	545	Ababacar Lô	Defence	2000-01-02	Senegal
212866	545	Sadibou Sané	Defence	2004-06-10	Senegal
8732	545	Ablie Jallow	Midfield	1998-11-14	Gambia
177049	545	Danley Jean Jacques	Midfield	2000-05-20	Haiti
185032	545	Maïdine Douane	Midfield	2002-08-23	France
190552	545	Arthur Atta	Midfield	2003-01-14	France
204269	545	Lamine Camara	Midfield	2004-01-01	Senegal
204325	545	Joseph N'Duquidi	Midfield	2004-10-31	France
206125	545	Pape Diallo	Midfield	2004-06-25	Senegal
894	545	Didier Lamkel Zé	Offence	1996-09-17	Cameroon
4071	545	Joel Asoro	Offence	1999-04-27	Sweden
56614	545	Benjamin Tetteh	Offence	1997-07-10	Ghana
74681	545	Warren Tchimbembé	Offence	1998-04-21	Congo
136646	545	Georges Mikautadze	Offence	2000-10-31	Georgia
206116	545	Malick Mbaye	Offence	2004-04-06	Senegal
212864	545	Ibou Sané	Offence	2005-03-28	Senegal
213218	545	Cheikh Sabaly	Offence	1999-03-04	Senegal
409	546	Jean-Louis Leca	Goalkeeper	1985-09-21	France
8316	546	Brice Samba	Goalkeeper	1994-04-25	France
167805	546	Yannick Pandor	Goalkeeper	2001-05-01	Comoros
592	546	Jimmy Cabot	Defence	1994-04-18	France
735	546	Jonathan Gradit	Defence	1992-11-24	France
6655	546	Kevin Danso	Defence	1998-09-19	Austria
7916	546	Massadio Haïdara	Defence	1992-12-02	France
8372	546	Ruben Aguilar	Defence	1993-04-26	France
46125	546	Facundo Medina	Defence	1999-05-28	Argentina
169041	546	Jhoanner Chavez	Defence	2002-04-25	Ecuador
212868	546	Abdukodir Khusanov	Defence	2004-02-29	Uzbekistan
221816	546	Keny M'Bala	Defence	2004-06-02	France
3540	546	Przemysław Frankowski	Midfield	1995-04-12	Poland
8441	546	Nampalys Mendy	Midfield	1992-06-23	Senegal
8648	546	Angelo Fulgini	Midfield	1996-08-20	France
123206	546	Salis Abdul Samed	Midfield	2000-03-26	Ghana
127639	546	Adam Abeddou	Midfield	1996-08-17	France
143101	546	David Pereira da Costa	Midfield	2001-01-05	Portugal
168656	546	Andy Diouf	Midfield	2003-05-17	France
170647	546	Neil El Aynaoui	Midfield	2001-07-02	France
131040	548	Folarin Balogun	Offence	2001-07-03	USA
204260	546	Fodé Sylla	Midfield	2006-04-16	France
212872	546	Ayanda Sishuba	Midfield	2005-02-02	Belgium
229868	546	Tom Pouilly	Midfield	2003-06-18	France
8575	546	Wesley Saïd	Offence	1995-04-19	France
8706	546	Adrien Thomasson	Offence	1993-12-10	France
64837	546	Florian Sotoca	Offence	1990-10-25	France
109649	546	Morgan Guilavogui	Offence	1998-03-10	France
156808	546	Sepe Elye Wahi	Offence	2003-01-02	France
170398	546	Ibrahima Baldé	Offence	2003-01-17	France
246160	546	Anthony Bermont	Offence	2005-02-10	France
873	547	Alexandre Olliero	Goalkeeper	1996-02-15	France
8608	547	Yehvann Diouf	Goalkeeper	1999-11-16	France
8635	547	Ludovic Butelle	Goalkeeper	1983-04-03	France
810	547	Yunis Abdelhamid	Defence	1987-09-28	Morocco
8900	547	Thibault De Smet	Defence	1998-06-05	Belgium
8908	547	Thomas Foket	Defence	1994-09-25	Belgium
32099	547	Sergio Akieme	Defence	1997-12-16	Equatorial Guinea
34313	547	Joseph Okumu	Defence	1997-05-26	Kenya
75743	547	Maxime Busi	Defence	1999-10-14	Belgium
149731	547	Emmanuel Agbadou	Defence	1997-06-17	Ivory Coast
192373	547	Therence Koudou	Defence	2004-12-13	France
206122	547	Fallou Fall	Defence	2004-04-15	Senegal
242560	547	Killian Prouchet	Defence	2005-01-23	France
245428	547	Arthur Tchaptchet	Defence	2006-05-10	France
245430	547	Nhoa Sangui	Defence	2006-02-27	France
251244	547	Abdoul Koné	Defence	2005-04-22	Ivory Coast
6502	547	Benjamin Stambouli	Midfield	1990-08-13	France
34754	547	Marshall Munetsi	Midfield	1996-06-22	Zimbabwe
8315	576	Matthieu Dreyer	Goalkeeper	1989-03-20	France
154781	576	Alexandre Pierre	Goalkeeper	2001-02-25	Haiti
172575	576	Alaa Bellaarouch	Goalkeeper	2002-02-01	Morocco
935	576	Thomas Delaine	Defence	1992-03-24	France
8324	576	Frédéric Guilbert	Defence	1994-12-24	France
64371	576	Karol Fila	Defence	1998-06-13	Poland
119063	576	Lucas Perrin	Defence	1998-11-19	France
147878	576	Ismaël Doukouré	Defence	2003-07-24	France
149127	576	Saïdou Sow	Defence	2002-07-04	Guinea
153924	576	Marvin Senaya	Defence	2001-01-28	France
182091	576	Junior Mwanga	Defence	2003-05-11	France
182297	576	Abakar Sylla	Defence	2002-12-25	Ivory Coast
212863	576	Steven Baseya	Defence	2005-01-14	France
246700	576	Elies Araar Fernandez	Defence	2006-10-07	France
451	576	Ibrahima Sissoko	Midfield	1997-10-27	France
8333	576	Jessy Deminguet	Midfield	1998-01-07	France
8786	576	Jean-Eudes Aholou	Midfield	1994-03-20	Ivory Coast
166366	576	Andrey Santos	Midfield	2004-05-03	Brazil
171876	576	Habib Diarra	Midfield	2004-01-03	France
244929	576	Samir El Mourabet	Midfield	2005-10-06	France
246704	576	Rabby Nzingoula	Midfield	2005-11-25	France
127	576	Kevin Gameiro	Offence	1987-05-09	France
1043	576	Lebo Mothiba	Offence	1996-01-28	South Africa
150599	576	Emanuel Emegha	Offence	2003-02-03	Netherlands
151295	576	Dilane Bakwa	Offence	2002-08-26	France
152783	576	Ângelo Borges	Offence	2004-12-21	Brazil
166244	576	Dion Moise Sahi	Offence	2001-12-20	Ivory Coast
190794	576	Tom Saettel	Offence	2005-06-19	France
229415	576	Jérémy Sebas	Offence	2003-04-14	Martinique
245388	576	Mohamed Bechikh	Offence	2005-07-13	France
249100	576	Aboubacar Ali	Offence	2006-04-02	France
252843	576	Vignon Ouotro	Offence	2005-09-13	Ivory Coast
252873	576	Tidiane Diallo	Offence	2006-05-28	France
280	548	Guillermo Maripán	Defence	1994-05-06	Chile
8913	546	Deiver Machado	Defence	1993-09-02	Colombia
182199	521	Joffrey Bazie	Offence	2003-10-27	Burkina Faso
\.


--
-- TOC entry 3468 (class 0 OID 122902)
-- Dependencies: 235
-- Data for Name: referees; Type: TABLE DATA; Schema: public; Owner: sports_league_owner
--

COPY public.referees (referee_id, name, nationality) FROM stdin;
11585	Craig Pawson	England
11605	Michael Oliver	England
11309	Peter Bankes	England
11556	David Coote	England
11494	Stuart Attwell	England
11327	John Brooks	England
11423	Andy Madley	England
11446	Robert Jones	England
11580	Anthony Taylor	England
11430	Simon Hooper	England
11317	Darren Bond	England
11620	Thomas Bramall	England
11396	Tim Robinson	England
11520	Paul Tierney	England
23568	Jarred Gillett	Australia
11405	Michael Salisbury	England
193220	Bobby Madley	England
11469	Darren England	England
213800	Josh Smith	England
11378	Tony Harrington	England
11443	Chris Kavanagh	England
11503	Graham Scott	England
213813	Sam Barrott	England
80758	Rebecca Welch	England
11635	Samuel Allison	England
81840	Lewis Smith	England
150766	Sunny Gill	England
11626	Matt Donohue	England
57836	Luca Massimi	Italy
57868	Matteo Marcenaro	Italy
57842	Giovanni Ayroldi	Italy
57878	Andrea Colombo	Italy
57882	Ermanno Feliciani	Italy
57762	Matteo Marchetti	Italy
57837	Federico Dionisi	Italy
11018	Antonio Rapuano	Italy
215611	Francesco Cosso	Italy
11002	Luca Pairetto	Italy
206189	Juan Luca Sacchi	Italy
11068	Gianluca Aureliano	Italy
11065	Daniele Doveri	Italy
11043	Maurizio Mariani	Italy
212567	Maria Caputi	Italy
11060	Marco Di Bello	Italy
11119	Livio Marinelli	Italy
11280	Antonio Giua	Italy
11029	Davide Massa	Italy
10985	Michael Fabbri	Italy
11039	Marco Piccinini	Italy
11116	Daniele Orsato	Italy
11079	Marco Guida	Italy
11053	Daniele Chiffi	Italy
10977	Fabio Maresca	Italy
57826	Simone Sozza	Italy
57794	Alessandro Prontera	Italy
10980	Federico La Penna	Italy
11006	Rosario Abisso	Italy
11072	Gianluca Manganiello	Italy
11129	Francesco Fourneau	Italy
207664	Ivano Pezzuto	Italy
57764	Luca Zufferli	Italy
97887	Paride Tremolada	Italy
97848	Giuseppe Collu	Italy
11084	Davide Ghersini	Italy
145272	Davide Di Marco	Italy
11087	Alberto Santoro	Italy
80747	Javier Alberola Rojas	NULL
207080	José Sánchez Martínez	Spain
214213	Francisco Hernández Maeso	Spain
56995	Víctor García Verdura	Spain
206211	Jesús Gil Manzano	Spain
206206	Pablo González Fuertes	Spain
207048	Miguel Ortiz Arias	Spain
207113	César Soto Grado	Spain
57930	Isidro Díaz de Mera	Spain
207133	Juan Pulido Santana	Spain
215462	Javier Iglesias Villanueva	Spain
206223	José Munuera Montero	Spain
215559	Jorge Figueroa Vázquez	Spain
215569	Alejandro Muñiz Ruiz	Spain
15628	Ricardo de Burgos	Spain
206215	Guillermo Cuadra Fernández	Spain
206208	Alejandro Hernández Hernández	Spain
206203	Juan Martínez Munuera	Spain
207105	Mario Melero López	Spain
217698	Mateo Busquets Ferrer	Spain
43878	Felix Zwayer	Germany
43875	Felix Brych	Germany
57518	Florian Badstübner	Germany
15824	Sven Jablonski	Germany
57517	Daniel Schlager	Germany
15408	Daniel Siebert	Germany
8825	Deniz Aytekin	Germany
43943	Tobias Stieler	Germany
253	Harm Osmers	Germany
57532	Frank Willenborg	Germany
43922	Benjamin Brand	Germany
56230	Matthias Jöllenbeck	Germany
57519	Robert Schröder	Germany
57504	Robert Hartmann	Germany
337	Patrick Ittrich	Germany
57526	Christian Dingert	Germany
15746	Bastian Dankert	Germany
57512	Tobias Reichel	Germany
15825	Martin Petersen	Germany
9567	Sascha Stegemann	Germany
57527	Timo Gerach	Germany
15821	Marco Fritz	Germany
57515	Sören Storks	Germany
57539	Tobias Welz	Germany
58466	Florian Exner	Germany
43926	Benoît Bastien	France
57092	Eric Wattellier	France
57088	Bastien Dechepy	France
57073	Jérémie Pignard	France
43918	François Letexier	France
57042	Willy Delajod	France
9374	Clément Turpin	France
1049	Jeremy Stinat	France
15548	Jérôme Brisard	France
57054	Mathieu Vernice	France
57039	Thomas Léonard	France
57065	Pierre Gaillouste	France
57068	Florent Batta	France
57063	Hakim Ben El Hadj Salem	France
57087	Romain Lissorgue	France
43886	Ruddy Buquet	France
15545	Benoît Millot	France
64829	Gaël Angoula	France
64781	Marc Bollengier	France
25786	Stéphanie Frappart	France
40158	Miguel Nogueira	Portugal
\.


--
-- TOC entry 3473 (class 0 OID 139265)
-- Dependencies: 240
-- Data for Name: scorers; Type: TABLE DATA; Schema: public; Owner: sports_league_owner
--

COPY public.scorers (scorer_id, player_id, season_id, league_id, goals, assists, penalties) FROM stdin;
1	3220	2	2	24	5	2
2	82002	2	2	16	3	2
3	9434	2	2	15	4	3
4	3371	2	2	15	7	4
5	3851	2	2	14	5	4
6	2271	2	2	13	5	0
7	8685	2	2	13	8	0
8	1754	2	2	13	3	10
9	2046	2	2	13	8	7
10	3662	2	2	13	3	0
11	45680	2	2	12	2	1
12	145	2	2	12	6	0
13	99731	2	2	12	6	2
14	2681	2	2	12	6	0
15	7693	2	2	12	5	2
16	2016	2	2	11	1	2
17	9554	2	2	11	7	0
18	113285	2	2	11	5	0
19	171121	2	2	11	3	5
20	129947	2	2	10	8	1
21	38101	1	1	27	6	7
22	144892	1	1	22	12	9
23	6486	1	1	21	2	5
24	7878	1	1	19	3	2
25	7888	1	1	19	8	0
26	4444	1	1	19	13	0
27	3754	1	1	18	11	5
28	170281	1	1	17	10	2
29	99813	1	1	16	9	6
30	11414	1	1	16	6	0
31	641	1	1	16	5	2
32	8057	1	1	14	1	0
33	152515	1	1	14	5	0
34	171	1	1	13	8	1
35	612	1	1	12	3	0
36	3354	1	1	12	3	1
37	30842	1	1	12	7	1
38	5483	1	1	11	4	5
39	98571	1	1	11	8	2
40	7848	1	1	11	9	1
41	24217	3	3	24	8	7
42	8167	3	3	23	6	0
43	125010	3	3	19	6	1
44	371	3	3	19	8	4
45	2237	3	3	17	2	3
46	32836	3	3	16	2	1
47	114	3	3	16	6	4
48	7819	3	3	15	2	0
49	1556	3	3	15	6	1
50	69	3	3	15	1	4
51	81565	3	3	14	5	0
52	32762	3	3	13	2	0
53	213269	3	3	13	3	0
54	32629	3	3	12	4	0
55	83795	3	3	11	1	4
56	1324	3	3	10	5	0
57	8	3	3	10	4	0
58	32719	3	3	10	7	2
59	7938	3	3	10	2	0
60	7936	3	3	9	2	0
61	8004	4	4	36	8	5
62	211	4	4	28	4	4
63	73215	4	4	24	8	2
64	6928	4	4	18	10	0
65	133903	4	4	16	3	0
66	318	4	4	15	6	5
67	33242	4	4	15	10	3
68	130811	4	4	14	9	4
69	124244	4	4	14	2	0
70	7457	4	4	13	3	0
71	66896	4	4	12	8	2
72	9499	4	4	12	4	2
73	226	4	4	12	9	5
74	304	4	4	12	8	3
75	19334	4	4	11	11	1
76	16335	4	4	11	7	0
77	150733	4	4	10	4	0
78	16739	4	4	10	14	0
79	144393	4	4	10	6	0
80	400	4	4	10	3	0
81	3374	5	5	27	7	6
82	7797	5	5	19	2	2
83	8924	5	5	19	6	2
84	7801	5	5	17	7	4
86	73	5	5	16	2	1
87	9848	5	5	14	2	1
89	136646	5	5	13	4	3
90	113427	5	5	11	3	3
91	101431	5	5	11	0	1
92	130668	5	5	10	2	2
93	15100	5	5	9	6	0
94	8818	5	5	9	5	7
95	156808	5	5	9	1	1
96	852	5	5	9	6	7
97	856	5	5	8	8	3
98	185000	5	5	8	4	4
99	114672	5	5	8	2	3
100	82132	5	5	8	0	0
102	9848	5	5	14	2	1
103	73	5	5	16	2	1
\.


--
-- TOC entry 3471 (class 0 OID 131073)
-- Dependencies: 238
-- Data for Name: scores; Type: TABLE DATA; Schema: public; Owner: sports_league_owner
--

COPY public.scores (score_id, match_id, full_time_home, full_time_away, half_time_home, half_time_away) FROM stdin;
1	435943	0	3	0	2
2	435944	2	1	2	0
3	435945	1	1	0	0
4	435946	4	1	1	0
5	435947	0	1	0	0
6	435948	0	1	0	0
7	435949	5	1	2	1
8	435950	2	2	2	2
9	435951	1	1	1	1
10	435952	1	0	0	0
11	435959	2	1	1	0
12	435955	0	3	0	1
13	435956	3	1	2	1
14	435962	1	4	0	1
15	435960	2	0	0	0
16	435958	1	0	1	0
17	435953	4	0	2	0
18	435961	3	1	1	1
19	435954	0	1	0	0
20	435968	3	0	1	0
21	435963	0	2	0	1
22	435969	0	1	0	0
23	435970	3	2	1	2
24	435964	2	2	0	1
25	435965	1	1	1	0
26	435966	1	3	0	1
27	435972	1	2	0	0
28	435967	1	3	0	2
29	435971	1	2	1	0
30	435980	1	2	0	1
31	435982	2	2	2	1
32	435974	2	2	1	1
33	435976	2	5	1	2
34	435977	0	1	0	0
35	435981	5	1	2	1
36	435975	3	1	1	0
37	435978	3	2	0	0
38	435979	3	0	2	0
39	435973	3	1	1	1
40	435992	1	3	1	0
41	435984	3	1	0	0
42	435986	1	0	0	0
43	435987	1	3	0	1
44	435990	2	1	0	0
45	435991	1	3	1	0
46	435988	1	0	0	0
47	435983	0	0	0	0
48	435985	0	1	0	0
49	435989	1	1	0	1
50	435998	0	0	0	0
51	436000	1	1	0	0
52	436001	2	0	2	0
53	435994	1	3	1	1
54	435996	0	1	0	1
55	435993	2	2	1	1
56	435995	3	1	1	1
57	435997	0	1	0	0
58	435999	3	1	1	1
59	436002	0	8	0	3
60	436004	6	1	3	0
61	436003	0	4	0	2
62	436005	1	2	1	2
63	436007	0	1	0	1
64	436008	2	0	1	0
65	436011	2	0	2	0
66	436012	2	1	1	0
67	436010	2	1	1	1
68	436009	1	1	0	0
69	436006	0	2	0	2
70	435957	1	2	0	1
71	436019	0	1	0	0
72	436015	1	4	1	1
73	436017	3	0	2	0
74	436018	3	1	0	0
75	436020	2	1	0	1
76	436016	0	0	0	0
77	436014	2	2	1	2
78	436021	2	2	1	0
79	436022	1	1	0	0
80	436013	1	0	0	0
81	436027	2	0	0	0
82	436023	1	2	1	0
83	436025	3	0	1	0
84	436028	2	1	2	0
85	436029	4	0	3	0
86	436030	2	2	0	0
87	436026	2	2	1	0
88	436031	1	2	1	1
89	436024	4	1	1	0
90	436032	2	0	1	0
91	436038	1	2	0	0
92	436037	0	2	0	0
93	436033	2	1	1	1
94	436034	5	0	1	0
95	436042	2	2	1	2
96	436041	0	1	0	0
97	436035	3	1	1	0
98	436036	1	1	1	0
99	436039	3	0	2	0
100	436040	0	3	0	1
101	436046	0	1	0	0
102	436043	3	2	1	2
103	436044	0	2	0	1
104	436045	1	1	1	0
105	436048	6	1	3	0
106	436051	2	1	0	0
107	436049	1	0	0	0
108	436050	2	0	1	0
109	436047	1	1	0	0
110	436052	1	4	1	1
111	436062	2	1	0	1
112	436054	3	1	1	0
113	436058	2	3	1	1
114	436060	1	0	0	0
115	436053	2	0	0	0
116	436055	3	1	2	0
117	436056	1	1	1	0
118	436059	3	0	1	0
119	436061	3	2	1	1
120	436057	4	4	2	2
121	436068	1	1	1	0
122	436064	1	2	0	0
123	436067	2	1	0	0
124	436069	4	1	1	1
125	436070	2	3	1	2
126	436071	1	3	0	2
127	436063	0	1	0	0
128	436072	1	2	1	1
129	436065	0	3	0	1
130	436066	3	2	1	1
131	436074	2	1	2	0
132	436075	3	1	0	0
133	436076	5	0	2	0
134	436081	0	1	0	0
135	436080	1	0	0	0
136	436073	2	2	1	1
137	436077	3	2	2	1
138	436078	4	3	2	2
139	436082	1	1	1	0
140	436079	3	3	2	1
141	436090	1	0	1	0
142	436087	3	4	1	2
143	436084	2	1	1	1
144	436086	5	0	2	0
145	436088	0	2	0	1
146	436091	0	2	0	1
147	436083	1	0	0	0
148	436092	2	1	1	1
149	436085	3	0	0	0
150	436089	1	2	1	0
151	436095	1	2	0	0
152	436094	1	1	0	1
153	436099	0	3	0	1
154	436100	1	0	1	0
155	436102	1	1	1	1
156	436093	1	0	1	0
157	436096	2	0	0	0
158	436097	5	0	3	0
159	436098	1	2	1	0
160	436101	4	1	2	0
161	436111	0	2	0	1
162	436107	2	0	0	0
163	436109	2	2	1	0
164	436110	3	0	0	0
165	436106	0	2	0	2
166	436104	2	0	0	0
167	436105	1	2	1	0
168	436112	3	0	2	0
169	436108	0	0	0	0
170	436114	1	1	1	0
171	436113	1	1	0	0
172	436121	2	0	0	0
173	436115	0	2	0	0
174	436117	1	0	1	0
175	436119	2	3	0	0
176	436120	2	1	2	0
177	436116	1	1	1	1
178	436122	2	1	0	0
179	436131	1	3	1	1
180	436123	3	0	1	0
181	436132	2	3	0	1
182	436127	0	2	0	1
183	436130	3	2	0	2
184	436125	1	4	1	3
185	436128	2	1	1	1
186	436129	1	3	1	0
187	436126	4	2	2	0
188	436124	0	2	0	1
189	436137	2	3	0	2
190	436133	3	2	2	1
191	436134	3	1	2	1
192	436138	2	0	1	0
193	436142	3	0	1	0
194	436139	2	1	0	0
195	436135	2	1	1	1
196	436140	3	1	1	0
197	436136	4	2	0	0
198	436141	0	0	0	0
199	436147	1	1	1	0
200	436148	1	0	1	0
201	436151	2	3	2	1
202	436149	0	0	0	0
203	436150	2	2	2	1
204	436144	5	0	2	0
205	436145	3	2	1	1
206	436152	2	2	1	1
207	436143	0	4	0	0
208	436146	0	0	0	0
209	436153	1	2	0	0
210	436155	4	0	3	0
211	436156	0	0	0	0
212	436157	3	2	2	2
213	436158	1	3	0	2
214	436159	3	2	0	1
215	436161	3	1	2	0
216	436162	4	1	2	0
217	436154	1	1	0	1
218	436160	3	4	0	2
219	436169	2	2	1	2
220	436166	4	1	3	0
221	436167	2	2	0	2
222	436171	4	4	2	2
223	436172	0	5	0	4
224	436163	1	1	1	1
225	436168	2	4	1	2
226	436170	3	0	1	0
227	436164	3	1	1	1
228	436165	1	3	1	1
229	436178	2	0	0	0
230	436175	3	1	2	0
231	436176	3	1	1	1
232	436177	1	3	0	2
233	436180	2	1	0	1
234	436182	0	2	0	1
235	436179	2	3	2	2
236	436181	0	6	0	4
237	436173	1	2	0	1
238	436174	1	3	1	0
239	436183	1	4	0	1
240	436184	0	5	0	2
241	436186	1	2	0	1
242	436189	2	2	0	0
243	436190	2	0	1	0
244	436192	1	2	0	1
245	436188	1	1	0	1
246	436191	0	5	0	2
247	436187	1	2	1	2
248	436185	1	1	0	0
249	436118	1	0	0	0
250	436199	4	1	0	1
251	436195	4	2	3	1
252	436196	1	1	0	0
253	436198	3	0	0	0
254	436200	1	2	0	0
255	436193	0	1	0	1
256	436194	4	1	2	0
257	436202	1	0	1	0
258	436201	4	2	2	1
259	436203	2	2	0	1
260	436205	1	3	0	0
261	436206	3	0	2	0
262	436209	3	0	2	0
263	436210	0	1	0	0
264	436212	3	1	0	0
265	436207	2	3	0	2
266	436204	0	2	0	1
267	436208	3	1	0	1
268	436211	0	6	0	5
269	436220	2	0	2	0
270	436213	2	2	0	1
271	436218	1	1	1	0
272	436222	2	1	0	0
273	436214	2	1	1	1
274	436215	0	4	0	0
275	436216	1	0	1	0
276	436221	2	2	0	2
277	436219	1	1	0	1
278	436217	3	2	1	1
279	436103	4	3	0	3
280	436225	2	1	1	0
281	436229	1	1	0	1
282	436228	3	0	1	0
283	436231	1	1	1	0
284	436239	4	3	1	2
285	436233	2	1	0	0
286	436236	2	2	1	0
287	436240	1	1	0	1
288	436241	3	3	0	0
289	436242	2	1	0	1
290	436234	2	0	1	0
291	436235	1	1	0	0
292	436237	2	1	1	1
293	436238	0	0	0	0
294	436247	3	1	3	0
295	436250	1	1	1	0
296	436243	1	0	0	0
297	436246	1	1	1	1
298	436248	1	1	1	1
299	436244	2	0	2	0
300	436245	0	0	0	0
301	436252	4	1	2	1
302	436251	3	1	1	0
303	436249	4	3	2	2
304	436255	2	4	1	1
305	436253	3	3	1	0
306	436256	1	0	1	0
307	436257	0	1	0	0
308	436258	2	1	0	0
309	436262	1	2	1	0
310	436254	0	3	0	1
311	436259	2	2	0	1
312	436260	2	2	1	1
313	436261	3	1	1	1
314	436270	4	0	2	0
315	436265	2	0	0	0
316	436266	1	1	0	0
317	436269	5	1	1	0
318	436271	2	2	1	1
319	436263	2	2	2	1
320	436268	0	1	0	1
321	436272	0	2	0	1
322	436264	0	2	0	0
323	436267	6	0	4	0
324	436278	1	5	0	2
325	436280	1	4	0	2
326	436282	0	2	0	1
327	436276	2	0	1	0
328	436273	3	1	1	1
329	436275	5	2	4	1
330	436277	1	3	1	1
331	436223	5	0	1	0
332	436232	0	1	0	1
333	436226	2	0	0	0
334	436227	2	0	1	0
335	436230	4	2	1	1
336	436224	0	4	0	3
337	436291	2	2	1	0
338	436286	1	1	0	0
339	436287	1	1	0	0
340	436288	5	1	1	1
341	436292	2	1	1	0
342	436285	1	0	0	0
343	436284	2	2	2	0
344	436283	3	0	1	0
345	436290	2	3	0	3
346	436289	0	2	0	1
347	436197	2	0	1	0
348	436300	1	1	1	1
349	436293	3	0	1	0
350	436294	0	0	0	0
351	436296	1	4	0	3
352	436302	1	3	1	1
353	436301	5	1	3	0
354	436295	1	0	0	0
355	436297	5	0	3	0
356	436299	4	2	2	0
357	436298	4	0	2	0
358	436306	0	4	0	1
359	436303	1	2	0	0
360	436305	1	0	1	0
361	436308	1	1	1	1
362	436310	2	1	1	1
363	436311	3	1	0	1
364	436312	1	3	0	2
365	436309	2	3	1	1
366	436307	0	1	0	1
367	436304	3	3	1	2
368	436281	0	2	0	0
369	436274	1	2	0	1
370	436279	3	2	1	0
371	436313	2	1	1	1
372	436314	2	4	0	3
373	436315	0	2	0	0
374	436316	1	2	0	2
375	436317	2	1	1	0
376	436318	5	0	2	0
377	436319	2	0	2	0
378	436320	2	4	1	2
379	436321	3	1	2	1
380	436322	0	3	0	1
381	444255	0	1	0	0
382	444256	1	3	1	2
383	444257	1	4	0	3
384	444258	2	0	1	0
385	444260	2	2	1	1
386	444261	0	2	0	0
387	444259	2	1	0	1
388	444263	0	3	0	3
389	444262	0	0	0	0
390	444254	0	2	0	2
391	444266	2	1	2	0
392	444271	2	0	1	0
393	444267	2	1	2	0
394	444270	4	1	3	1
395	444265	2	2	2	0
396	444268	1	1	0	1
397	444269	0	1	0	1
398	444272	2	0	1	0
399	444273	1	1	0	0
400	444264	0	2	0	2
401	444281	3	1	1	0
402	444280	1	2	0	1
403	444275	2	1	0	1
404	444283	0	0	0	0
405	444274	3	0	2	0
406	444279	1	2	1	1
407	444277	4	0	1	0
408	444282	1	0	0	0
409	444276	0	2	0	1
410	444278	2	0	1	0
411	444290	3	1	2	0
412	444289	5	1	2	0
413	444287	2	2	1	0
414	444284	0	0	0	0
415	444286	4	2	1	2
416	444291	1	1	1	1
417	444285	3	2	2	1
418	444292	7	0	3	0
419	444293	0	3	0	2
420	444288	0	0	0	0
421	444300	1	1	0	1
422	444298	1	0	0	0
423	444299	1	0	1	0
424	444301	4	2	2	1
425	444297	1	1	1	1
426	444296	0	1	0	0
427	444294	2	0	1	0
428	444303	0	2	0	1
429	444295	0	0	0	0
430	444302	1	1	0	0
431	444310	1	0	0	0
432	444304	1	3	1	2
433	444305	1	0	1	0
434	444308	0	1	0	1
435	444309	1	2	1	0
436	444311	2	0	0	0
437	444313	4	1	2	0
438	444306	1	1	0	1
439	444312	0	0	0	0
440	444307	4	1	2	1
441	444317	0	4	0	1
442	444318	2	0	0	0
443	444320	0	4	0	0
444	444315	3	0	1	0
445	444323	2	2	1	2
446	444314	0	0	0	0
447	444319	2	0	1	0
448	444321	0	1	0	0
449	444322	0	0	0	0
450	444316	3	0	2	0
451	444325	0	0	0	0
452	444331	1	1	0	1
453	444328	2	2	2	1
454	444329	2	0	0	0
455	444327	0	1	0	0
456	444332	3	0	2	0
457	444326	2	1	1	0
458	444330	3	2	2	1
459	444324	1	4	0	2
460	444333	1	3	1	1
461	444337	1	3	0	2
462	444342	0	3	0	0
463	444341	0	2	0	2
464	444339	1	0	0	0
465	444335	2	1	2	0
466	444340	2	2	0	0
467	444334	2	0	0	0
468	444338	0	1	0	0
469	444343	1	1	0	0
470	444336	0	2	0	1
471	444346	1	0	1	0
472	444353	1	1	1	1
473	444350	0	1	0	1
474	444348	1	0	0	0
475	444344	4	3	0	2
476	444351	1	1	1	0
477	444347	1	0	0	0
478	444352	2	2	0	2
479	444345	0	3	0	2
480	444349	1	0	0	0
481	444355	1	0	0	0
482	444362	0	2	0	1
483	444354	1	2	0	1
484	444360	0	1	0	0
485	444359	1	3	0	1
486	444356	2	1	0	0
487	444361	2	1	0	0
488	444357	0	1	0	1
489	444358	2	1	0	0
490	444363	2	1	1	1
491	444372	2	2	1	2
492	444365	1	0	1	0
493	444369	2	2	0	2
494	444367	2	1	0	0
495	444370	1	1	0	0
496	444371	0	1	0	0
497	444364	2	1	1	1
498	444373	1	1	1	0
499	444368	0	0	0	0
500	444366	2	0	1	0
501	444383	2	1	0	1
502	444374	1	2	0	1
503	444381	1	0	1	0
504	444376	1	1	1	0
505	444377	3	4	2	2
506	444378	2	1	1	1
507	444382	3	1	1	0
508	444380	1	1	1	1
509	444379	2	2	1	1
510	444375	2	0	0	0
511	444389	1	2	0	1
512	444385	1	1	1	0
513	444386	1	0	1	0
514	444388	3	1	1	0
515	444387	1	1	0	0
516	444384	3	0	2	0
517	444393	3	3	2	1
518	444391	1	2	1	0
519	444390	0	3	0	1
520	444392	3	0	1	0
521	444400	1	0	0	0
522	444398	1	1	0	1
523	444394	3	2	1	1
524	444399	4	0	3	0
525	444397	0	0	0	0
526	444401	1	0	0	0
527	444403	1	2	0	2
528	444402	1	1	1	0
529	444396	1	1	0	0
530	444395	2	1	0	1
531	444407	1	1	0	1
532	444409	2	1	1	1
533	444411	2	1	0	0
534	444412	1	0	1	0
535	444410	3	0	2	0
536	444406	1	0	0	0
537	444413	2	2	1	0
538	444405	2	0	1	0
539	444408	0	2	0	1
540	444404	4	1	0	1
541	444422	1	2	1	0
542	444415	0	2	0	1
543	444419	0	1	0	1
544	444421	2	2	1	1
545	444416	1	2	0	1
546	444423	1	1	0	0
547	444414	1	0	0	0
548	444417	2	0	0	0
549	444418	2	0	1	0
550	444420	2	0	0	0
551	444426	1	0	0	0
552	444432	0	0	0	0
553	444427	1	1	1	1
554	444430	3	1	0	0
555	444424	1	0	0	0
556	444425	0	0	0	0
557	444433	3	0	1	0
558	444428	0	1	0	0
559	444431	1	0	0	0
560	444429	1	0	0	0
561	444434	1	1	0	1
562	444437	2	1	1	0
563	444436	2	3	0	2
564	444438	1	1	1	0
565	444441	1	0	1	0
566	444435	0	3	0	2
567	444442	3	0	1	0
568	444443	1	2	0	1
569	444440	1	2	1	0
570	444439	1	1	1	1
571	444447	0	0	0	0
572	444453	2	1	1	1
573	444448	2	1	1	0
574	444452	1	5	0	2
575	444450	1	0	0	0
576	444445	2	1	1	1
577	444446	2	2	0	1
578	444451	3	1	1	0
579	444444	5	0	3	0
580	444449	3	0	2	0
581	444459	2	1	2	0
582	444463	2	3	1	1
583	444456	3	1	0	1
584	444455	3	0	2	0
585	444460	1	2	1	1
586	444458	0	3	0	0
587	444465	1	2	0	2
588	444464	2	0	2	0
589	444469	1	1	0	0
590	444471	2	2	1	1
591	444467	2	1	0	1
592	444468	1	1	1	0
593	444472	1	0	1	0
594	444470	0	0	0	0
595	444466	0	1	0	1
596	444473	1	2	0	0
597	444479	3	2	1	0
598	444476	0	0	0	0
599	444483	0	0	0	0
600	444477	2	3	1	1
601	444475	4	2	1	2
602	444482	0	0	0	0
603	444480	2	1	0	0
604	444474	3	1	2	0
605	444478	1	0	1	0
606	444481	4	0	2	0
607	444492	1	3	0	1
608	444485	1	3	0	1
609	444491	2	4	2	1
610	444493	1	1	1	1
611	444486	5	1	3	0
612	444484	4	0	2	0
613	444490	0	0	0	0
614	444487	1	4	0	1
615	444489	1	0	1	0
616	444488	0	1	0	1
617	444454	2	0	1	0
618	444502	2	0	0	0
619	444498	4	0	3	0
620	444501	1	1	0	0
621	444497	2	2	1	1
622	444494	3	0	1	0
623	444499	1	2	1	1
624	444495	1	1	0	1
625	444503	1	1	1	1
626	444496	0	3	0	1
627	444500	4	2	2	0
628	444462	0	2	0	0
629	444504	2	0	1	0
630	444513	2	3	0	1
631	444512	0	2	0	0
632	444507	2	0	2	0
633	444508	3	2	2	2
634	444505	1	1	0	0
635	444509	0	4	0	1
636	444510	1	1	1	1
637	444511	3	2	1	1
638	444506	2	1	0	1
639	444461	1	6	1	3
640	444457	4	0	2	0
641	444519	0	1	0	0
642	444523	1	1	1	1
643	444520	1	4	0	2
644	444522	0	0	0	0
645	444517	1	0	0	0
646	444515	0	1	0	0
647	444516	1	1	1	0
648	444514	1	2	1	0
649	444521	2	1	1	0
650	444518	2	1	2	0
651	444532	1	1	0	0
652	444525	4	2	2	0
653	444533	1	0	0	0
654	444524	0	1	0	1
655	444527	2	3	0	2
656	444530	0	1	0	1
657	444531	1	0	1	0
658	444528	2	2	0	1
659	444526	2	2	1	0
660	444529	1	2	0	0
661	444535	0	1	0	0
662	444540	1	0	1	0
663	444543	0	2	0	1
664	444542	0	1	0	1
665	444536	2	3	1	1
666	444539	0	0	0	0
667	444537	1	3	0	1
668	444541	1	0	0	0
669	444538	1	1	1	0
670	444551	0	3	0	2
671	444547	1	1	1	1
672	444553	1	0	0	0
673	444549	1	0	0	0
674	444546	1	2	0	0
675	444544	3	0	2	0
676	444545	1	1	0	1
677	444552	1	1	1	1
678	444550	0	0	0	0
679	444548	2	0	1	0
680	444562	2	2	0	2
681	444559	3	0	2	0
682	444561	1	0	1	0
683	444555	3	2	1	0
684	444556	0	0	0	0
685	444560	2	4	1	0
686	444554	2	1	1	1
687	444557	1	2	1	1
688	444558	1	0	1	0
689	444563	1	2	1	0
690	444568	4	1	3	1
691	444569	1	0	0	0
692	444572	0	0	0	0
693	444565	0	0	0	0
694	444570	2	2	1	0
695	444571	3	3	2	1
696	444567	2	2	1	0
697	444566	1	1	0	1
698	444564	2	2	2	0
699	444576	0	1	0	0
700	444574	2	2	2	0
701	444575	1	0	1	0
702	444577	1	0	0	0
703	444582	0	3	0	2
704	444583	0	0	0	0
705	444581	0	2	0	0
706	444579	1	2	0	1
707	444580	1	3	0	2
708	444578	1	2	0	1
709	444573	1	2	1	0
710	444587	3	0	2	0
711	444592	1	1	0	0
712	444590	0	0	0	0
713	444591	1	0	0	0
714	444589	2	0	0	0
715	444585	1	1	0	1
716	444584	2	0	1	0
717	444593	2	2	0	0
718	444586	5	1	1	0
719	444588	3	0	2	0
720	444602	0	0	0	0
721	444598	2	2	0	1
722	444601	1	0	1	0
723	444594	1	1	1	0
724	444595	0	0	0	0
725	444596	2	1	1	1
726	444597	3	3	1	1
727	444599	1	1	1	1
728	444600	1	2	1	0
729	444603	1	1	0	0
730	444606	0	5	0	1
731	444613	0	2	0	2
732	444612	5	1	1	0
733	444610	2	0	1	0
734	444607	2	1	0	1
735	444608	1	2	0	0
736	444609	1	1	0	1
737	444604	2	1	2	0
738	444611	0	2	0	1
739	444605	2	1	1	1
740	444615	2	2	2	1
741	444617	0	2	0	0
742	444622	3	1	2	0
743	444621	0	2	0	0
744	444618	0	1	0	1
745	444623	1	1	0	0
746	444616	1	1	0	1
747	444619	1	0	0	0
748	444620	1	2	0	2
749	444614	3	3	2	0
750	444625	2	3	0	1
751	444628	2	0	1	0
752	444630	2	0	2	0
753	444632	3	3	2	0
754	444624	3	0	2	0
755	444633	0	0	0	0
756	444626	2	1	1	1
757	444627	0	1	0	0
758	444629	2	2	2	2
759	444631	1	1	0	0
760	444534	2	3	2	3
761	438482	0	2	0	2
762	438479	1	2	0	0
763	438481	1	1	1	0
764	438483	1	1	1	0
765	438474	0	2	0	2
766	438476	0	2	0	1
767	438480	1	2	0	1
768	438478	0	0	0	0
769	438477	1	0	1	0
770	438475	3	1	1	0
771	438491	0	1	0	0
772	438490	1	0	0	0
773	438492	1	1	1	0
774	438493	1	3	1	1
775	438485	0	2	0	2
776	438488	3	0	1	0
777	438487	2	0	0	0
778	438484	0	0	0	0
779	438486	4	3	2	2
780	438489	0	2	0	0
781	438503	0	0	0	0
782	438495	0	1	0	0
783	438496	1	1	0	0
784	438498	3	2	1	1
785	438499	1	2	1	1
786	438501	3	4	2	2
787	438500	1	2	0	1
788	438494	4	2	3	2
789	438497	1	0	0	0
790	438502	0	7	0	3
791	438508	3	1	2	1
792	438513	2	3	0	2
793	438512	5	3	2	1
794	438511	2	1	0	1
795	438507	1	0	1	0
796	438505	1	0	0	0
797	438509	1	0	0	0
798	438510	0	0	0	0
799	438506	1	2	0	1
800	438522	2	0	1	0
801	438514	3	0	0	0
802	438520	3	0	2	0
803	438515	0	1	0	0
804	438516	5	0	2	0
805	438517	3	2	1	1
806	438521	2	1	1	1
807	438519	1	0	0	0
808	438523	2	1	0	1
809	438518	2	4	0	3
810	438527	0	2	0	1
811	438529	5	3	4	1
812	438526	0	0	0	0
813	438528	3	2	0	1
814	438532	2	2	0	1
815	438531	4	3	1	2
816	438530	1	1	1	1
817	438533	1	0	0	0
818	438525	1	1	0	1
819	438524	3	1	2	1
820	438539	5	1	3	0
821	438542	2	2	2	1
822	438534	2	2	1	0
823	438541	1	2	0	0
824	438543	2	0	1	0
825	438537	0	0	0	0
826	438540	0	1	0	1
827	438536	1	1	1	0
828	438538	1	1	0	0
829	438535	0	2	0	1
830	438547	1	0	0	0
831	438548	0	0	0	0
832	438550	2	2	1	1
833	438549	0	3	0	2
834	438551	3	0	1	0
835	438552	3	3	3	0
836	438546	0	2	0	1
837	438544	3	2	1	2
838	438545	3	0	1	0
839	438553	2	1	0	0
840	438554	3	0	1	0
841	438558	0	1	0	0
842	438563	4	0	1	0
843	438562	1	1	1	1
844	438560	2	2	0	2
845	438561	1	2	0	1
846	438555	2	1	1	0
847	438556	2	2	2	2
848	438557	1	1	1	1
849	438559	2	2	2	1
850	438564	2	0	1	0
851	438572	1	0	0	0
852	438567	1	1	1	1
853	438569	1	1	0	0
854	438565	0	3	0	1
855	438573	0	1	0	0
856	438568	5	2	3	2
857	438571	1	1	0	0
858	438566	1	0	0	0
859	438570	2	0	2	0
860	438579	1	0	0	0
861	438583	1	2	0	1
862	438577	1	2	1	0
863	438582	0	0	0	0
864	438578	2	2	2	1
865	438576	2	1	1	0
866	438581	2	2	1	1
867	438574	2	2	1	0
868	438575	2	1	2	0
869	438580	2	3	2	3
870	438593	2	1	0	0
871	438585	2	4	1	1
872	438584	2	0	1	0
873	438586	1	1	1	0
874	438592	0	1	0	0
875	438587	1	0	0	0
876	438589	1	0	1	0
877	438590	2	3	0	3
878	438591	0	0	0	0
879	438588	1	0	0	0
880	438594	4	3	2	2
881	438600	1	2	1	1
882	438603	1	3	0	0
883	438596	1	1	0	0
884	438598	1	1	1	1
885	438602	5	1	2	0
886	438597	2	1	0	1
887	438599	1	1	0	0
888	438595	3	1	1	1
889	438606	3	1	2	0
890	438612	1	1	1	0
891	438610	0	0	0	0
892	438608	2	1	2	1
893	438604	1	0	0	0
894	438611	3	1	0	0
895	438613	2	1	2	0
896	438607	0	3	0	1
897	438605	1	0	1	0
898	438609	1	1	0	0
899	438601	1	1	1	1
900	438623	2	0	1	0
901	438618	2	1	0	0
902	438614	4	0	1	0
903	438621	2	0	1	0
904	438615	1	1	1	1
905	438620	0	0	0	0
906	438622	0	0	0	0
907	438619	1	1	0	0
908	438617	1	0	1	0
909	438616	1	1	0	1
910	438629	1	0	0	0
911	438626	0	1	0	1
912	438625	1	1	0	0
913	438631	0	3	0	3
914	438633	1	0	1	0
915	438624	2	1	2	0
916	438628	1	1	1	0
917	438627	2	4	1	2
918	438630	1	1	0	1
919	438632	0	0	0	0
920	438635	1	0	0	0
921	438636	1	0	1	0
922	438634	2	0	0	0
923	438638	0	3	0	2
924	438639	1	1	0	0
925	438642	0	0	0	0
926	438641	0	0	0	0
927	438643	1	1	1	0
928	438640	4	1	2	0
929	438637	3	0	2	0
930	438652	0	1	0	0
931	438645	3	3	1	0
932	438650	0	3	0	2
933	438648	3	2	1	1
934	438644	1	0	0	0
935	438651	3	2	2	0
936	438646	1	1	0	1
937	438649	0	0	0	0
938	438647	0	1	0	0
939	438653	3	2	1	1
940	438504	1	0	0	0
941	438656	0	2	0	1
942	438662	1	1	0	0
943	438660	3	1	2	0
944	438658	2	0	1	0
945	438655	2	1	1	1
946	438661	1	0	0	0
947	438657	4	3	3	2
948	438654	1	0	1	0
949	438659	0	2	0	1
950	438663	1	2	1	0
951	438670	2	3	0	2
952	438673	3	0	1	0
953	438671	1	1	1	1
954	438664	2	1	2	0
955	438666	1	0	0	0
956	438672	0	0	0	0
957	438668	1	4	1	1
958	438677	1	0	0	0
959	438682	0	2	0	1
960	438681	1	1	1	0
961	438680	1	0	0	0
962	438676	0	1	0	1
963	438675	3	2	2	0
964	438683	3	2	0	2
965	438674	2	4	0	1
966	438678	5	1	3	1
967	438679	0	1	0	0
968	438692	0	3	0	1
969	438691	0	0	0	0
970	438693	1	2	0	0
971	438686	3	5	0	1
972	438690	0	1	0	1
973	438685	0	1	0	1
974	438687	0	0	0	0
975	438689	1	1	1	0
976	438684	2	0	1	0
977	438688	2	0	2	0
978	438667	1	0	0	0
979	438665	2	1	1	1
980	438669	0	2	0	1
981	438694	4	0	2	0
982	438700	2	1	2	0
983	438699	1	1	1	0
984	438697	1	3	0	1
985	438698	0	0	0	0
986	438701	0	0	0	0
987	438696	0	3	0	2
988	438695	1	1	1	1
989	438703	1	1	1	0
990	438702	1	2	1	2
991	438706	0	2	0	1
992	438704	1	1	1	1
993	438711	0	1	0	0
994	438710	4	0	2	0
995	438713	2	0	0	0
996	438707	3	2	2	0
997	438709	2	1	0	0
998	438708	1	0	1	0
999	438705	3	3	1	1
1000	438712	0	0	0	0
1001	438721	1	1	0	1
1002	438715	5	0	2	0
1003	438717	2	0	0	0
1004	438718	1	2	0	1
1005	438720	0	0	0	0
1006	438722	1	1	1	1
1007	438719	1	1	0	1
1008	438723	1	2	1	1
1009	438716	0	0	0	0
1010	438714	3	2	1	0
1011	438731	1	3	0	1
1012	438726	4	0	1	0
1013	438725	1	1	0	0
1014	438732	2	2	1	1
1015	438727	2	2	0	1
1016	438724	3	1	2	1
1017	438733	1	1	0	0
1018	438730	1	0	0	0
1019	438728	3	0	0	0
1020	438737	1	0	0	0
1021	438739	3	2	2	1
1022	438742	1	1	0	0
1023	438738	3	3	3	1
1024	438740	2	2	2	1
1025	438741	5	1	3	0
1026	438735	2	1	2	0
1027	438743	1	0	1	0
1028	438734	0	0	0	0
1029	438736	1	0	0	0
1030	438746	1	0	0	0
1031	438750	1	0	1	0
1032	438747	2	0	1	0
1033	438749	2	3	2	1
1034	438748	2	0	1	0
1035	438745	1	0	1	0
1036	438753	0	2	0	1
1037	438751	4	0	1	0
1038	438744	2	3	2	1
1039	438752	2	2	1	0
1040	438762	2	0	1	0
1041	438761	1	0	0	0
1042	438756	2	4	1	2
1043	438757	1	0	1	0
1044	438754	2	0	2	0
1045	438758	1	2	1	0
1046	438759	1	0	0	0
1047	438763	0	1	0	1
1048	438760	2	0	1	0
1049	438755	0	3	0	1
1050	438767	1	0	0	0
1051	438768	0	1	0	1
1052	438773	0	3	0	2
1053	438770	0	0	0	0
1054	438766	1	0	0	0
1055	438764	0	0	0	0
1056	438769	3	2	1	1
1057	438765	0	1	0	0
1058	438772	2	0	1	0
1059	438771	1	2	0	1
1060	438729	0	1	0	0
1061	438776	2	1	0	0
1062	438775	3	1	2	1
1063	438780	0	0	0	0
1064	438781	0	1	0	0
1065	438778	0	1	0	1
1066	438783	0	2	0	1
1067	438779	2	0	2	0
1068	438774	1	1	0	0
1069	438782	2	2	1	1
1070	438777	0	1	0	1
1071	438784	1	1	1	1
1072	438785	4	1	2	1
1073	438791	2	1	0	1
1074	438790	1	2	0	1
1075	438788	4	1	2	0
1076	438787	1	1	1	1
1077	438793	1	2	1	1
1078	438786	2	0	1	0
1079	438792	3	2	1	1
1080	438789	2	1	0	0
1081	438801	0	1	0	1
1082	438803	0	2	0	1
1083	438802	1	3	1	1
1084	438796	3	0	0	0
1085	438794	3	1	1	1
1086	438798	1	1	0	1
1087	438799	3	0	1	0
1088	438800	3	0	1	0
1089	438795	1	1	1	0
1090	438797	4	2	1	2
1091	438806	0	2	0	1
1092	438813	2	0	2	0
1093	438812	3	0	0	0
1094	438807	4	2	1	2
1095	438811	0	1	0	1
1096	438804	0	2	0	2
1097	438805	3	2	2	1
1098	438809	0	1	0	0
1099	438808	3	0	1	0
1100	438810	0	1	0	1
1101	438817	2	2	1	2
1102	438823	1	0	1	0
1103	438822	3	2	1	2
1104	438820	0	4	0	2
1105	438814	2	2	0	1
1106	438819	1	0	1	0
1107	438815	1	0	0	0
1108	438821	0	0	0	0
1109	438816	3	2	2	1
1110	438818	2	0	1	0
1111	438824	1	1	1	0
1112	438830	5	0	3	0
1113	438827	0	1	0	0
1114	438828	0	1	0	0
1115	438829	2	1	1	0
1116	438825	2	1	0	1
1117	438826	0	3	0	2
1118	438833	2	2	1	1
1119	438832	0	2	0	1
1120	438831	1	0	1	0
1121	438837	1	0	1	0
1122	438834	2	0	2	0
1123	438835	1	4	0	1
1124	438836	0	2	0	2
1125	438838	3	0	1	0
1126	438839	0	0	0	0
1127	438840	1	2	0	0
1128	438841	1	3	0	1
1129	438842	4	4	1	4
1130	438843	2	2	1	1
1131	438847	7	0	3	0
1132	438844	1	1	1	0
1133	438851	0	2	0	1
1134	438849	0	1	0	0
1135	438852	6	1	0	1
1136	438850	0	0	0	0
1137	438846	1	2	0	0
1138	438845	2	2	0	1
1139	438853	1	1	0	0
1140	438848	1	2	1	1
1141	441789	0	4	0	1
1142	441792	3	2	2	1
1143	441794	2	0	2	0
1144	441795	1	2	0	2
1145	441796	4	4	3	3
1146	441797	5	0	2	0
1147	441790	1	0	0	0
1148	441791	4	1	2	0
1149	441793	1	0	1	0
1150	441799	5	1	0	1
1151	441800	1	0	0	0
1152	441803	1	2	0	0
1153	441804	1	1	1	0
1154	441805	2	3	1	0
1155	441806	1	4	1	3
1156	441802	0	3	0	2
1157	441801	1	1	1	0
1158	441798	3	1	2	0
1159	441807	2	2	2	0
1160	441809	5	1	1	1
1161	441812	3	1	1	1
1162	441813	4	0	1	0
1163	441814	2	2	1	1
1164	441815	5	0	3	0
1165	441811	1	2	1	0
1166	441810	1	1	0	1
1167	441808	0	3	0	0
1168	441816	2	2	1	1
1169	441817	3	0	3	0
1170	441818	2	4	2	1
1171	441819	2	1	2	1
1172	441820	1	3	0	0
1173	441821	1	3	0	2
1174	441822	1	1	0	0
1175	441823	4	2	2	0
1176	441824	3	3	3	0
1177	441833	3	1	2	1
1178	441825	7	0	4	0
1179	441826	1	0	0	0
1180	441827	0	2	0	2
1181	441830	0	1	0	0
1182	441832	2	1	2	1
1183	441831	2	1	1	1
1184	441828	4	1	1	0
1185	441829	0	0	0	0
1186	441839	1	3	1	2
1187	441836	2	0	1	0
1188	441837	0	3	0	1
1189	441838	0	2	0	0
1190	441840	1	3	0	3
1191	441841	1	0	0	0
1192	441834	2	2	2	0
1193	441842	4	2	2	0
1194	441835	2	0	1	0
1195	441848	2	2	1	1
1196	441844	4	2	1	2
1197	441845	0	0	0	0
1198	441850	1	2	0	0
1199	441851	3	1	0	1
1200	441849	2	3	1	2
1201	441846	3	0	2	0
1202	441843	3	0	2	0
1203	441847	2	0	1	0
1204	441852	1	0	0	0
1205	441858	1	3	1	3
1206	441860	1	3	1	2
1207	441853	0	3	0	1
1208	441854	2	1	2	1
1209	441855	1	2	1	1
1210	441856	1	3	1	2
1211	441857	3	1	1	0
1212	441859	2	5	2	3
1213	441867	2	2	1	0
1214	441861	8	0	0	0
1215	441865	2	1	1	1
1216	441866	2	0	1	0
1217	441868	3	2	1	2
1218	441869	2	3	0	2
1219	441862	6	0	4	0
1220	441864	3	3	2	1
1221	441863	2	1	1	0
1222	441878	1	2	1	1
1223	441871	0	3	0	2
1224	441872	3	3	1	3
1225	441874	2	0	0	0
1226	441875	1	1	1	1
1227	441876	2	3	0	2
1228	441870	0	4	0	2
1229	441873	2	2	1	1
1230	441877	2	0	0	0
1231	441882	4	0	2	0
1232	441879	4	2	2	0
1233	441885	1	1	0	1
1234	441886	2	1	1	1
1235	441887	0	0	0	0
1236	441884	1	1	1	0
1237	441881	4	0	1	0
1238	441883	2	2	1	0
1239	441880	3	1	1	1
1240	441893	0	1	0	1
1241	441888	4	2	3	2
1242	441889	1	1	0	1
1243	441890	1	1	1	1
1244	441892	2	1	1	0
1245	441895	0	3	0	2
1246	441891	1	2	1	2
1247	441896	0	0	0	0
1248	441894	1	1	0	1
1249	441905	0	1	0	0
1250	441898	2	1	2	1
1251	441901	2	1	0	0
1252	441902	3	1	2	1
1253	441904	2	0	1	0
1254	441900	0	1	0	0
1255	441899	1	1	0	1
1256	441903	2	1	1	0
1257	441911	3	1	2	0
1258	441907	3	1	1	0
1259	441908	5	1	3	1
1260	441909	0	1	0	0
1261	441912	2	0	1	0
1262	441914	3	2	1	0
1263	441906	2	3	1	1
1264	441913	1	1	1	0
1265	441910	0	0	0	0
1266	441920	2	2	1	1
1267	441919	0	1	0	1
1268	441921	3	0	1	0
1269	441922	1	1	1	1
1270	441923	0	1	0	0
1271	441916	3	1	1	1
1272	441917	2	0	0	0
1273	441918	3	0	1	0
1274	441915	3	0	1	0
1275	441930	1	1	0	0
1276	441924	1	1	1	1
1277	441929	3	3	2	1
1278	441925	2	0	0	0
1279	441926	4	0	3	0
1280	441927	2	1	0	1
1281	441928	1	2	1	2
1282	441931	3	0	2	0
1283	441932	3	2	0	1
1284	441933	3	0	1	0
1285	441934	0	1	0	1
1286	441935	0	0	0	0
1287	441936	1	1	0	1
1288	441938	1	1	1	0
1289	441940	0	1	0	0
1290	441941	0	3	0	1
1291	441939	1	1	0	0
1292	441937	3	1	2	0
1293	441943	0	4	0	1
1294	441946	2	2	0	1
1295	441947	1	1	1	1
1296	441948	3	2	1	0
1297	441950	1	0	0	0
1298	441945	2	3	1	0
1299	441942	0	1	0	0
1300	441949	1	2	1	0
1301	441897	1	0	0	0
1302	441954	1	0	0	0
1303	441951	2	3	0	2
1304	441952	5	2	2	1
1305	441953	3	1	1	1
1306	441956	1	1	1	1
1307	441958	1	1	1	1
1308	441955	0	0	0	0
1309	441959	1	0	0	0
1310	441957	3	1	1	1
1311	441960	0	0	0	0
1312	441962	0	2	0	1
1313	441964	3	1	1	1
1314	441966	0	1	0	1
1315	441967	1	1	1	0
1316	441968	1	3	1	2
1317	441963	2	0	0	0
1318	441965	2	2	0	1
1319	441961	2	0	1	0
1320	441944	1	1	1	1
1321	441971	3	0	2	0
1322	441970	2	2	1	1
1323	441972	1	0	1	0
1324	441975	1	1	1	1
1325	441976	1	2	1	2
1326	441977	0	0	0	0
1327	441969	3	0	1	0
1328	441973	3	1	2	0
1329	441974	1	1	0	0
1330	441984	0	1	0	0
1331	441979	1	1	0	1
1332	441980	0	1	0	0
1333	441981	1	2	0	1
1334	441985	1	0	1	0
1335	441986	1	2	0	1
1336	441983	2	0	1	0
1337	441982	3	3	2	2
1338	441978	3	2	2	1
1339	441990	2	1	1	1
1340	441991	1	1	0	0
1341	441994	2	2	2	1
1342	441995	1	1	1	1
1343	441993	5	2	2	0
1344	441987	2	1	0	0
1345	441989	2	2	1	2
1346	441992	2	3	2	1
1347	441988	2	1	0	1
1348	441996	2	2	1	1
1349	441997	0	2	0	1
1350	441998	1	4	1	1
1351	442000	1	2	0	1
1352	442001	1	1	1	0
1353	442003	0	6	0	5
1354	442004	2	3	0	1
1355	441999	0	2	0	1
1356	442002	2	1	2	0
1357	442006	2	0	1	0
1358	442009	8	1	3	1
1359	442010	3	3	1	1
1360	442012	1	0	1	0
1361	442013	2	0	1	0
1362	442005	1	2	0	2
1363	442007	1	2	0	1
1364	442011	3	1	1	1
1365	442008	2	0	1	0
1366	442015	1	5	1	1
1367	442014	2	5	1	2
1368	442018	1	1	0	1
1369	442019	2	1	0	0
1370	442020	2	0	1	0
1371	442021	1	3	1	1
1372	442022	0	3	0	2
1373	442016	2	3	1	2
1374	442017	3	1	1	1
1375	442024	0	0	0	0
1376	442025	0	3	0	1
1377	442026	0	2	0	1
1378	442027	0	0	0	0
1379	442029	2	1	0	1
1380	442023	0	2	0	1
1381	442028	1	1	1	1
1382	442030	3	3	1	0
1383	442031	2	2	1	0
1384	442036	1	1	0	0
1385	442032	3	2	0	2
1386	442033	1	4	0	3
1387	442034	0	1	0	1
1388	442037	2	1	0	0
1389	442040	4	0	1	0
1390	442039	0	1	0	0
1391	442038	3	1	2	0
1392	442035	1	3	1	0
1393	442042	2	0	0	0
1394	442041	1	2	1	2
1395	442045	3	0	1	0
1396	442046	2	0	0	0
1397	442047	4	1	0	1
1398	442049	1	1	0	0
1399	442044	3	0	3	0
1400	442043	0	1	0	1
1401	442048	5	0	1	0
1402	442056	3	1	0	1
1403	442051	1	2	0	1
1404	442054	4	3	1	1
1405	442055	1	0	1	0
1406	442058	0	2	0	0
1407	442050	1	5	0	2
1408	442057	2	1	1	0
1409	442052	1	1	0	0
1410	442053	1	1	1	1
1411	442064	3	2	2	0
1412	442059	4	1	2	1
1413	442061	2	1	1	1
1414	442062	1	2	1	0
1415	442065	0	3	0	0
1416	442066	2	2	0	0
1417	442060	0	0	0	0
1418	442063	1	1	1	0
1419	442067	0	1	0	0
1420	442069	1	1	0	1
1421	442068	3	1	1	1
1422	442073	2	2	1	1
1423	442075	5	1	4	1
1424	442076	3	0	2	0
1425	442070	0	0	0	0
1426	442074	3	4	0	3
1427	442071	1	5	1	2
1428	442072	1	1	0	1
1429	442084	0	1	0	0
1430	442078	3	2	1	2
1431	442080	1	1	1	1
1432	442083	1	1	0	1
1433	442085	1	1	1	1
1434	442077	3	0	3	0
1435	442082	0	6	0	5
1436	442081	2	0	2	0
1437	442079	0	5	0	2
1438	442086	4	2	1	2
1439	442087	2	2	0	1
1440	442088	2	1	0	0
1441	442089	1	3	1	1
1442	442090	4	0	2	0
1443	442091	4	1	3	0
1444	442092	4	1	1	0
1445	442093	2	1	2	0
1446	442094	4	0	2	0
1447	442710	1	1	1	0
1448	442711	2	1	1	1
1449	442712	0	0	0	0
1450	442714	3	2	1	2
1451	442707	2	4	1	2
1452	442708	1	2	1	0
1453	442709	2	2	0	1
1454	442715	5	1	1	1
1455	442713	2	1	0	0
1456	442719	2	2	0	1
1457	442721	1	4	0	2
1458	442720	1	1	0	0
1459	442722	2	0	0	0
1460	442716	1	2	0	1
1461	442718	1	1	0	0
1462	442724	2	0	1	0
1463	442717	3	0	2	0
1464	442723	1	1	1	0
1465	442727	3	3	2	1
1466	442730	2	0	1	0
1467	442731	3	1	1	0
1468	442733	2	2	2	1
1469	442725	0	1	0	0
1470	442728	1	3	1	2
1471	442732	2	0	0	0
1472	442726	4	1	2	0
1473	442729	0	0	0	0
1474	442737	1	1	1	1
1475	442741	0	0	0	0
1476	442735	3	0	2	0
1477	442738	2	2	2	1
1478	442734	3	0	0	0
1479	442736	2	2	1	1
1480	442740	1	0	1	0
1481	442739	2	0	1	0
1482	442742	1	4	0	4
1483	442747	2	3	1	1
1484	442751	2	2	0	1
1485	442749	0	1	0	1
1486	442744	2	2	1	1
1487	442743	0	1	0	0
1488	442748	2	2	0	2
1489	442750	1	2	1	0
1490	442746	0	0	0	0
1491	442745	0	0	0	0
1492	442753	0	1	0	0
1493	442755	5	3	1	1
1494	442760	1	0	0	0
1495	442754	0	1	0	0
1496	442752	2	1	2	1
1497	442759	2	1	1	1
1498	442756	0	0	0	0
1499	442758	4	0	2	0
1500	442757	1	2	0	2
1501	442767	0	1	0	1
1502	442763	0	0	0	0
1503	442762	3	2	2	2
1504	442768	2	0	1	0
1505	442761	0	2	0	1
1506	442765	3	0	2	0
1507	442766	0	0	0	0
1508	442764	0	3	0	1
1509	442769	3	1	1	1
1510	442774	1	2	0	0
1511	442770	0	1	0	1
1512	442777	1	3	0	1
1513	442772	3	0	2	0
1514	442773	3	3	3	1
1515	442776	1	1	0	1
1516	442775	1	1	0	1
1517	442778	1	3	0	2
1518	442779	0	0	0	0
1519	442787	3	0	2	0
1520	442784	1	0	0	0
1521	442781	2	1	2	1
1522	442782	2	0	1	0
1523	442783	1	1	0	0
1524	442786	1	0	1	0
1525	442780	2	1	1	1
1526	442785	1	2	0	2
1527	442788	0	1	0	0
1528	442795	1	0	0	0
1529	442793	4	0	1	0
1530	442794	2	3	1	2
1531	442789	0	0	0	0
1532	442790	3	0	1	0
1533	442792	2	0	2	0
1534	442796	1	1	1	0
1535	442804	3	0	1	0
1536	442798	0	0	0	0
1537	442803	0	0	0	0
1538	442802	1	1	0	0
1539	442799	0	1	0	0
1540	442800	1	2	0	0
1541	442805	0	0	0	0
1542	442797	2	0	1	0
1543	442801	2	0	1	0
1544	442809	0	0	0	0
1545	442813	0	3	0	1
1546	442806	0	0	0	0
1547	442807	1	0	0	0
1548	442808	3	1	2	1
1549	442810	1	1	1	0
1550	442814	0	1	0	0
1551	442811	1	0	0	0
1552	442821	5	2	2	1
1553	442815	0	3	0	1
1554	442822	1	1	1	1
1555	442819	1	0	0	0
1556	442816	2	3	2	1
1557	442817	0	0	0	0
1558	442818	1	3	0	1
1559	442823	3	1	1	1
1560	442820	0	2	0	2
1561	442771	1	1	0	1
1562	442832	2	1	2	0
1563	442830	3	2	1	1
1564	442826	1	0	1	0
1565	442824	0	2	0	1
1566	442825	2	0	1	0
1567	442827	1	1	0	0
1568	442831	3	0	2	0
1569	442829	2	0	2	0
1570	442828	2	0	1	0
1571	442791	3	0	2	0
1572	442812	1	1	1	0
1573	442836	0	0	0	0
1574	442841	1	2	0	0
1575	442839	2	1	1	0
1576	442837	2	1	0	0
1577	442833	0	0	0	0
1578	442835	0	1	0	0
1579	442840	2	1	1	0
1580	442838	3	0	2	0
1581	442834	2	4	1	4
1582	442843	0	1	0	0
1583	442842	3	1	2	0
1584	442850	2	0	1	0
1585	442846	0	2	0	0
1586	442844	1	2	0	1
1587	442845	0	1	0	1
1588	442847	0	0	0	0
1589	442848	2	1	2	0
1590	442849	1	1	0	0
1591	442851	1	3	1	0
1592	442852	1	2	1	2
1593	442853	1	1	1	0
1594	442854	2	0	0	0
1595	442855	1	0	0	0
1596	442856	3	1	0	0
1597	442857	2	1	1	1
1598	442858	4	0	4	0
1599	442859	1	0	1	0
1600	442864	1	1	1	0
1601	442861	1	3	0	1
1602	442868	2	0	1	0
1603	442865	3	0	1	0
1604	442862	0	1	0	1
1605	442863	1	2	0	1
1606	442867	2	0	0	0
1607	442860	3	1	1	0
1608	442866	0	2	0	1
1609	442875	2	3	0	3
1610	442873	1	0	0	0
1611	442874	2	2	1	2
1612	442872	0	0	0	0
1613	442869	1	1	0	1
1614	442870	3	3	1	1
1615	442877	0	0	0	0
1616	442871	0	2	0	1
1617	442876	2	2	2	0
1618	442883	1	2	0	1
1619	442886	2	1	1	0
1620	442880	0	1	0	0
1621	442878	1	1	0	0
1622	442882	4	0	4	0
1623	442885	2	3	0	3
1624	442879	1	2	1	1
1625	442884	0	0	0	0
1626	442881	1	0	1	0
1627	442893	1	1	0	0
1628	442895	3	1	2	1
1629	442894	3	1	2	1
1630	442887	0	1	0	0
1631	442888	1	1	0	0
1632	442889	2	0	0	0
1633	442890	1	2	0	1
1634	442891	1	2	1	0
1635	442892	2	3	1	1
1636	442899	1	0	1	0
1637	442900	3	0	2	0
1638	442897	0	2	0	0
1639	442901	1	3	0	2
1640	442896	1	2	0	1
1641	442898	3	0	1	0
1642	442904	3	1	1	0
1643	442903	1	1	1	1
1644	442902	1	0	0	0
1645	442907	1	2	1	1
1646	442906	0	1	0	0
1647	442912	0	3	0	2
1648	442913	2	3	1	2
1649	442905	1	2	0	0
1650	442908	3	1	0	1
1651	442909	0	0	0	0
1652	442911	1	1	0	1
1653	442910	4	1	2	1
1654	442914	0	0	0	0
1655	442921	0	1	0	0
1656	442915	1	5	0	1
1657	442917	2	1	0	1
1658	442916	0	2	0	0
1659	442918	2	2	0	0
1660	442920	1	0	1	0
1661	442922	1	2	0	0
1662	442919	0	3	0	1
1663	442926	1	2	1	2
1664	442924	0	2	0	0
1665	442931	1	0	1	0
1666	442929	2	2	2	2
1667	442923	1	0	0	0
1668	442925	1	0	1	0
1669	442930	0	1	0	0
1670	442928	2	2	0	2
1671	442927	2	0	1	0
1672	442935	2	3	0	1
1673	442934	1	3	1	1
1674	442937	1	3	0	1
1675	442938	1	1	0	0
1676	442932	2	2	1	1
1677	442933	2	1	2	1
1678	442939	2	1	1	1
1679	442940	2	0	1	0
1680	442936	2	6	2	2
1681	442948	2	1	1	0
1682	442944	2	5	0	3
1683	442947	1	1	0	0
1684	442943	0	1	0	0
1685	442941	0	2	0	0
1686	442942	0	3	0	1
1687	442945	1	2	0	1
1688	442949	2	0	0	0
1689	442946	0	2	0	0
1690	442954	3	1	0	0
1691	442956	1	1	0	0
1692	442955	1	1	0	1
1693	442957	4	3	3	1
1694	442952	0	0	0	0
1695	442953	2	0	0	0
1696	442958	0	0	0	0
1697	442950	1	0	1	0
1698	442951	1	3	1	0
1699	442963	2	1	2	1
1700	442966	3	1	1	1
1701	442967	1	2	1	2
1702	442959	0	1	0	0
1703	442961	1	1	1	0
1704	442965	4	3	1	0
1705	442971	3	0	1	0
1706	442969	0	3	0	0
1707	442974	1	0	1	0
1708	442968	0	1	0	0
1709	442972	1	0	1	0
1710	442976	1	2	0	1
1711	442975	0	2	0	1
1712	442970	2	2	1	1
1713	442973	4	1	4	1
1714	442962	1	4	0	2
1715	442960	1	0	0	0
1716	442964	2	2	1	1
1717	442980	1	1	1	1
1718	442983	3	3	1	2
1719	442979	1	2	1	2
1720	442977	4	1	1	1
1721	442978	1	2	1	0
1722	442984	1	3	1	1
1723	442985	4	5	2	1
1724	442981	3	2	2	1
1725	442982	2	1	1	0
1726	442989	1	2	1	1
1727	442992	2	0	0	0
1728	442986	3	1	1	0
1729	442987	4	1	2	1
1730	442988	2	3	2	1
1731	442993	0	0	0	0
1732	442991	3	4	2	0
1733	442998	1	0	1	0
1734	443002	1	1	1	1
1735	442995	0	1	0	0
1736	442996	1	2	0	2
1737	442997	0	2	0	0
1738	442999	3	1	2	1
1739	443000	1	3	1	1
1740	443001	2	1	0	0
1741	443003	1	1	0	0
1742	442990	1	2	1	2
1743	442994	1	0	1	0
1744	443004	1	2	0	0
1745	443005	4	0	3	0
1746	443006	5	0	2	0
1747	443007	0	2	0	2
1748	443008	0	3	0	0
1749	443009	2	1	1	0
1750	443010	2	2	0	1
1751	443011	2	2	2	0
1752	443012	2	1	0	0
\.


--
-- TOC entry 3455 (class 0 OID 16489)
-- Dependencies: 222
-- Data for Name: seasons; Type: TABLE DATA; Schema: public; Owner: sports_league_owner
--

COPY public.seasons (season_id, league_id, year) FROM stdin;
1	1	2023-2024
2	2	2023-2024
3	3	2023-2024
4	4	2023-2024
5	5	2023-2024
\.


--
-- TOC entry 3451 (class 0 OID 16471)
-- Dependencies: 218
-- Data for Name: stadiums; Type: TABLE DATA; Schema: public; Owner: sports_league_owner
--

COPY public.stadiums (stadium_id, name, location, capacity) FROM stdin;
81	Stadium Municipal	1 allée Gabriel Biénèsm, BP 54023 Toulouse 31028	\N
82	Stade Francis-Le Blé	Port de Plaisance, 470 bis rue Alain Colas Brest 29200	\N
83	Orange Vélodrome	La Commanderie, 33, traverse de La Martine Marseille 13012	\N
21	Emirates Stadium	London, UK	60704
22	Villa Park	Birmingham, UK	42640
23	Stamford Bridge	London, UK	40834
24	Goodison Park	Liverpool, UK	39571
25	Craven Cottage	London, UK	25700
26	Anfield	Liverpool, UK	54074
27	Etihad Stadium	Manchester, UK	55097
28	Old Trafford	Manchester, UK	74879
29	St. James' Park	Newcastle upon Tyne, UK	52305
30	Tottenham Hotspur Stadium	London, UK	62062
31	Molineux Stadium	Wolverhampton, UK	32050
32	Turf Moor	Burnley, UK	21944
33	The City Ground	Nottingham, UK	30445
34	Selhurst Park	London, UK	25456
35	Bramall Lane	Sheffield, UK	32702
36	Kenilworth Road Stadium	Luton, UK	10356
37	The American Express Community Stadium	Brighton & Hove, UK	30750
38	Griffin Park	Brentford, UK	12763
39	London Stadium	London, UK	60000
40	Vitality Stadium	Bournemouth, UK	11329
101	RheinEnergieSTADION	Franz-Kremer-Allee 1 Köln 50937	\N
102	PreZero Arena	Horrenberger Straße 58 Zuzenhausen 74939	\N
103	BayArena	Bismarckstr. 122-124 Leverkusen 51373	\N
104	Signal Iduna Park	Rheinlanddamm 207-209 Dortmund 44137	\N
105	Allianz Arena	Säbenerstr. 51 München 81547	\N
106	Mercedes-Benz Arena	Mercedesstraße 109 Stuttgart 70372	\N
107	Volkswagen Arena	In den Allerwiesen 1 Wolfsburg 38446	\N
108	Weserstadion	Franz-Böhmert-Str. 1c Bremen 28205	\N
109	Opel Arena	Dr.-Martin-Luther-King-Weg 20 Mainz 55122	\N
110	WWK Arena	Donauwörther Straße 170 Augsburg 86154	\N
111	Schwarzwald-Stadion	Schwarzwaldstraße 193 Freiburg 79117	\N
112	Stadion im Borussia-Park	Hennes-Weisweiler-Allee 1 Mönchengladbach 41179	\N
113	Deutsche Bank Park	Mörfelder Landstraße 362 Frankfurt am Main 60528	\N
114	Stadion An der Alten Försterei	An der Wuhlheide 263 Berlin 12555	\N
115	Vonovia Ruhrstadion	Castroper Straße 145 Bochum 44791	\N
116	Voith-Arena	Schloßhaustraße 162 Heidenheim 89522	\N
117	Merck-Stadion am Böllenfalltor	Nieder-Ramstädter-Straße 170 Darmstadt 64285	\N
118	Red Bull Arena	Neumarkt 29-33 Leipzig 04109	\N
41	Stadio Giuseppe Meazza	Via Filippo Turati 3 Milano 20121	\N
42	Stadio Artemio Franchi	Viale Manfredo Fanti 4 Firenze 50137	\N
43	Stadio Olimpico	Via di Trigoria km. 3,600 Roma 00128	\N
44	Stadio Atleti Azzurri d'Italia	Corso Europa, 46, Zingonia Ciserano 24040	\N
45	Stadio Renato Dall'Ara	Via Casteldebole 10 Bologna 40132	\N
46	Sardegna Arena	Viale la Plaia 15 Cagliari 09123	\N
47	Stadio Comunale Luigi Ferraris	Via Ronchi, 67 Genova 16155	\N
48	Allianz Stadium	Corso Galileo Ferraris, 32 Torino 10128	\N
49	Stadio San Paolo	Centro Tecnico di Castel Volturno, Via S.S. Domitana, Km 35 Castel Volturno 81030	\N
50	Dacia Arena	Via Agostino e Angelo Candolini 2 Udine 33100	\N
51	Stadio Carlo Castellani	Piazza Matteotti Empoli 50053	\N
52	Stadio Marc'Antonio Bentegodi	Via Evangelista Torricelli, 37 Verona 37136	\N
53	Stadio Arechi	Via San Leonardo, 51 Salerno 84131	\N
54	Stadio Benito Stirpe	Via Marittima, 2 Frosinone 03100	\N
55	Mapei Stadium - Città del Tricolore	Piazza Risorgimento, 47 Sassuolo 41049	\N
56	Stadio Olimpico di Torino	Via Arcivescovado 1 Torino 10122	\N
57	Stadio Comunale Via Del Mare	Via Templari 11 Lecce 73100	\N
58	Stadio Comunale Brianteo	Via Ragazzi del '99, 14 Monza 20900	\N
61	San Mamés	Ibaigane, Alameda Mazarredo, 23 Bilbao 48009	\N
62	Estadio Wanda Metropolitano	Paseo Virgen del Puerto, 67 Madrid 28005	\N
63	Estadio El Sadar	Calle del Sadar, s/n Pamplona 31006	\N
64	Camp Nou	Avenida Arístides Maillol s/n Barcelona 08028	\N
65	Coliseum Alfonso Pérez	Avenida Teresa de Calcuta, s/n Getafe 28903	\N
66	Estadio Nuevo Los Cármenes	Calle del Pintor Manuel Maldonado, s/n Granada 18007	\N
67	Estadio Santiago Bernabéu	Avenida Concha Espina, 1 Madrid 28036	\N
68	Estadio del Rayo Vallecano	Calle del Payaso Fofó, s/n Madrid 28018	\N
69	Iberostar Estadi	Son Moix, Calle Camí dels Reis, s/n Palma de Mallorca 07011	\N
70	Estadio Benito Villamarín	Avenida de Heliópolis, s/n Sevilla 41012	\N
71	Estadio Municipal de Anoeta	Anoeta Pasalekua, 1 San Sebastián 20014	\N
72	Estadio de la Cerámica	Camino Miralcamp, s/n Villarreal 12540	\N
73	Estadio de Mestalla	Plaza del Valencia Club de Fútbol, 2 Valencia 46010	\N
74	Estadio de Mendizorroza	Mendizorroza, Paseo Cervantes, s/n Vitoria 01007	\N
75	Estadio Ramón de Carranza	Plaza de Madrid, s/n Cádiz 11010	\N
76	Estadio de los Juegos Mediterráneos	Calle Alcalde Santiago Martínez Cabrejas, 5 Almería 04007	\N
77	Estadio de Gran Canaria	Calle Pío XII, 29 Las Palmas de Gran Canaria 35005	\N
78	Estadi Municipal de Montilivi	Avinguda de Montilivi, 141 Girona 17003	\N
79	Estadio de Balaídos	Calle del Conde de Gondomar, 1 Vigo 36203	\N
80	Estadio Ramón Sánchez Pizjuán	Calle Sevilla Fútbol Club, s/n Sevilla 41005	\N
84	Stade de la Mosson	Domaine de Grammont CS 79041 Montpellier 34967	\N
85	Stade Pierre-Mauroy	Grand Rue 59, 780 Camphin-en-Pévèle Lille null	\N
86	Stade de Nice	35, avenue du Ray Nice 06100	\N
87	Groupama Stadium	350 avenue Jean Jaurès Lyon 69007	\N
88	Parc des Princes	24, rue de Commandant Guibaud Paris 7501	\N
89	Stade Yves Allainmat - Le Moustoir	Tade Yves Allainmat<br>Rue Du Tour Des Portes, BP 404 Lorient 56104	\N
90	Roazhon Park	La Piverdière - Chemin de la Taupinais CS 5390 Rennes 35039	\N
91	Stade Océane	2 route du château BP 90 Saint-Laurent-de-Brèvedent 76700	\N
92	Stade Gabriel Montpied	Rue Adrien Mabrut Clermont-Ferrand 63100	\N
93	Stade de la Beaujoire - Louis Fonteneau	Centre Sportif José Arribas, La Jonelière Nantes 44240	\N
94	Stade Saint-Symphorien	3, allée Saint Symphonien, BP 40292 Metz 5700	\N
95	Stade Bollaert-Delelis	33 rue Arthur Lamendin Avion 62210	\N
96	Stade Auguste-Delaune II	26 rue Robert-Fulton Reims 51100	\N
97	Stade Louis II.	Avenue des Castellans Monaco 98000	\N
98	Stade de la Meinau	12 Rue Extenwoerth Strasbourg 67000	\N
\.


--
-- TOC entry 3465 (class 0 OID 49153)
-- Dependencies: 232
-- Data for Name: standings; Type: TABLE DATA; Schema: public; Owner: sports_league_owner
--

COPY public.standings (standing_id, season_id, league_id, "position", team_id, played_games, won, draw, lost, points, goals_for, goals_against, goal_difference, form) FROM stdin;
21	4	4	1	3	34	28	6	0	90	89	24	65	{D,D,W,W,W}
22	4	4	2	10	34	23	4	7	73	78	39	39	{L,D,W,W,W}
23	4	4	3	5	34	23	3	8	72	94	45	49	{D,L,L,W,L}
24	4	4	4	721	34	19	8	7	65	77	39	38	{W,W,D,D,D}
25	4	4	5	4	34	18	9	7	63	68	43	25	{W,W,W,L,W}
26	4	4	6	19	34	11	14	9	47	51	50	1	{W,L,L,D,D}
27	4	4	7	2	34	13	7	14	46	66	66	0	{W,L,D,W,W}
28	4	4	8	44	34	10	12	12	42	50	55	-5	{L,W,D,D,W}
29	4	4	9	12	34	11	9	14	42	48	54	-6	{W,W,D,D,W}
30	4	4	10	17	34	11	9	14	42	45	58	-13	{D,L,D,D,L}
31	4	4	11	16	34	10	9	15	39	50	60	-10	{L,L,L,L,L}
32	4	4	12	11	34	10	7	17	37	41	56	-15	{W,W,W,L,L}
33	4	4	13	15	34	7	14	13	35	39	51	-12	{D,D,D,W,W}
34	4	4	14	18	34	7	13	14	34	56	67	-11	{L,D,D,D,L}
35	4	4	15	28	34	9	6	19	33	33	58	-25	{L,D,L,L,W}
36	4	4	16	36	34	7	12	15	33	42	74	-32	{L,W,W,L,L}
37	4	4	17	1	34	5	12	17	27	28	60	-32	{L,D,D,W,L}
38	4	4	18	55	34	3	8	23	17	30	86	-56	{W,L,L,L,L}
1	1	1	1	65	38	28	7	3	91	96	34	62	{W,W,W,W,W}
2	1	1	2	57	38	28	5	5	89	91	29	62	{W,W,W,W,W}
3	1	1	3	64	38	24	10	4	82	86	41	45	{L,D,W,D,W}
4	1	1	4	58	38	20	8	10	68	76	61	15	{W,D,L,D,L}
6	1	1	6	61	38	18	9	11	63	77	63	14	{W,W,W,W,W}
8	1	1	8	66	38	18	6	14	60	57	58	-1	{D,L,L,W,W}
10	1	1	10	354	38	13	10	15	49	57	58	-1	{W,D,W,W,W}
11	1	1	11	397	38	12	12	14	48	55	62	-7	{L,W,D,L,L}
13	1	1	13	63	38	13	8	17	47	55	61	-6	{L,D,D,L,W}
15	1	1	15	62	38	13	9	16	40	40	51	-11	{W,W,D,W,L}
17	1	1	17	351	38	9	9	20	32	49	67	-18	{L,L,W,L,W}
19	1	1	19	328	38	5	9	24	24	41	78	-37	{W,D,L,L,L}
41	2	2	1	108	38	29	7	2	94	89	22	67	{W,L,W,D,D}
42	2	2	2	98	38	22	9	7	75	76	49	27	{D,D,W,L,D}
44	2	2	4	102	37	21	6	10	69	70	39	31	{W,W,W,W,W}
46	2	2	6	100	38	18	9	11	63	65	46	19	{D,D,L,W,L}
48	2	2	8	99	37	16	9	12	57	58	44	14	{W,L,W,D,W}
50	2	2	10	113	38	13	14	11	53	55	48	7	{D,D,L,D,D}
52	2	2	12	5911	38	11	12	15	45	39	51	-12	{D,D,L,L,L}
54	2	2	14	5890	38	8	14	16	38	32	54	-22	{D,D,L,L,D}
55	2	2	15	115	38	6	19	13	37	37	53	-16	{D,D,W,D,W}
57	2	2	17	445	38	9	9	20	36	29	54	-25	{L,D,L,D,W}
59	2	2	19	471	38	7	9	22	30	43	75	-32	{L,W,L,L,D}
61	3	3	1	86	38	29	8	1	95	87	26	61	{W,W,W,D,D}
63	3	3	3	298	38	25	6	7	81	85	46	39	{W,D,L,W,W}
65	3	3	5	77	38	19	11	8	68	61	37	24	{W,D,L,W,W}
67	3	3	7	90	38	14	15	9	57	48	45	3	{W,W,D,L,D}
68	3	3	8	94	38	14	11	13	53	65	65	0	{L,W,W,D,D}
70	3	3	10	263	38	12	10	16	46	36	46	-10	{W,D,L,W,D}
72	3	3	12	82	38	10	13	15	43	42	54	-12	{L,L,L,L,L}
74	3	3	14	559	38	10	11	17	41	48	54	-6	{W,L,L,L,L}
76	3	3	16	275	38	10	10	18	40	33	47	-14	{L,L,D,D,D}
78	3	3	18	264	38	6	15	17	33	26	55	-29	{L,W,W,D,L}
79	3	3	19	267	38	3	12	23	21	43	75	-32	{W,L,L,D,W}
5	1	1	5	73	38	20	6	12	66	74	61	13	{L,L,W,L,W}
7	1	1	7	67	38	18	6	14	60	85	62	23	{W,W,D,L,W}
9	1	1	9	563	38	14	10	14	52	60	74	-14	{L,D,L,W,L}
12	1	1	12	1044	38	13	9	16	48	54	67	-13	{W,W,L,L,L}
14	1	1	14	76	38	13	7	18	46	50	65	-15	{L,W,L,L,L}
16	1	1	16	402	38	10	9	19	39	56	65	-9	{W,L,D,W,L}
18	1	1	18	389	38	6	8	24	26	52	85	-33	{L,L,D,L,L}
20	1	1	20	356	38	3	7	28	16	35	104	-69	{L,L,L,L,L}
43	2	2	3	109	38	19	14	5	71	54	31	23	{D,D,D,D,W}
45	2	2	5	103	38	18	14	6	68	54	32	22	{D,D,W,D,L}
47	2	2	7	110	38	18	7	13	61	49	39	10	{W,D,W,D,D}
49	2	2	9	586	38	13	14	11	53	36	36	0	{L,D,W,W,L}
51	2	2	11	107	38	12	13	13	49	45	45	0	{W,D,W,L,W}
53	2	2	13	450	38	9	11	18	38	38	51	-13	{L,W,L,W,D}
56	2	2	16	104	38	8	12	18	36	42	68	-26	{L,D,L,W,L}
58	2	2	18	470	38	8	11	19	35	44	69	-25	{W,D,L,W,L}
60	2	2	20	455	38	2	11	25	17	32	81	-49	{L,L,D,L,D}
62	3	3	2	81	38	26	7	5	85	79	44	35	{L,W,W,W,W}
64	3	3	4	78	38	24	4	10	76	70	43	27	{W,W,W,L,W}
66	3	3	6	92	38	16	12	10	60	51	39	12	{W,L,W,W,L}
69	3	3	9	95	38	13	10	15	49	40	45	-5	{L,D,L,L,D}
71	3	3	11	79	38	12	9	17	45	45	56	-11	{L,D,D,W,D}
73	3	3	13	558	38	10	11	17	41	46	57	-11	{W,L,W,W,D}
75	3	3	15	89	38	8	16	14	40	33	44	-11	{L,W,D,D,W}
77	3	3	17	87	38	8	14	16	38	29	48	-19	{L,D,W,L,L}
80	3	3	20	83	38	4	9	25	21	38	79	-41	{L,L,L,L,L}
81	5	5	1	524	34	22	10	2	76	81	33	48	{W,D,L,W,W}
82	5	5	2	548	34	20	7	7	67	68	42	26	{W,L,W,W,W}
83	5	5	3	512	34	17	10	7	61	53	34	19	{L,W,D,D,W}
84	5	5	4	521	34	16	11	7	59	52	34	18	{L,W,L,W,D}
85	5	5	5	522	34	15	10	9	55	40	29	11	{D,W,W,L,D}
86	5	5	6	523	34	16	5	13	53	49	55	-6	{L,W,W,W,W}
87	5	5	7	546	34	14	9	11	51	45	37	8	{W,D,L,L,W}
88	5	5	8	516	34	13	11	10	50	52	41	11	{D,W,W,L,W}
89	5	5	9	547	34	13	8	13	47	42	47	-5	{L,L,D,W,W}
90	5	5	10	529	34	12	10	12	46	53	46	7	{W,L,W,D,L}
91	5	5	11	511	34	11	10	13	43	42	46	-4	{D,W,L,W,L}
92	5	5	12	518	34	10	12	12	41	43	48	-5	{W,D,W,L,D}
93	5	5	13	576	34	10	9	15	39	38	50	-12	{L,L,L,W,L}
94	5	5	14	543	34	9	6	19	33	30	55	-25	{L,D,D,L,L}
95	5	5	15	533	34	7	11	16	32	34	45	-11	{L,D,W,L,L}
96	5	5	16	545	34	8	5	21	29	35	58	-23	{W,L,L,L,L}
97	5	5	17	525	34	7	8	19	29	43	66	-23	{L,L,L,L,W}
98	5	5	18	541	34	5	10	19	25	26	60	-34	{L,W,L,L,L}
\.


--
-- TOC entry 3457 (class 0 OID 16501)
-- Dependencies: 224
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: sports_league_owner
--

COPY public.teams (team_id, name, founded_year, stadium_id, league_id, coach_id, cresturl) FROM stdin;
77	Athletic Club	1898	61	3	61	https://crests.football-data.org/77.png
78	Club Atlético de Madrid	1903	62	3	62	https://crests.football-data.org/78.svg
79	CA Osasuna	1920	63	3	63	https://crests.football-data.org/79.svg
81	FC Barcelona	1899	64	3	64	https://crests.football-data.org/81.svg
82	Getafe CF	1946	65	3	65	https://crests.football-data.org/82.png
83	Granada CF	1931	66	3	66	https://crests.football-data.org/83.svg
86	Real Madrid CF	1902	67	3	67	https://crests.football-data.org/86.png
87	Rayo Vallecano de Madrid	1924	68	3	68	https://crests.football-data.org/87.svg
89	RCD Mallorca	1916	69	3	69	https://crests.football-data.org/89.png
90	Real Betis Balompié	1907	70	3	70	https://crests.football-data.org/90.png
92	Real Sociedad de Fútbol	1903	71	3	71	https://crests.football-data.org/92.svg
94	Villarreal CF	1923	72	3	72	https://crests.football-data.org/94.png
95	Valencia CF	1919	73	3	73	https://crests.football-data.org/95.svg
263	Deportivo Alavés	1921	74	3	74	https://crests.football-data.org/263.png
264	Cádiz CF	1910	75	3	75	https://crests.football-data.org/264.png
267	UD Almería	1989	76	3	76	https://crests.football-data.org/267.png
1	1. FC Köln	1948	101	4	101	https://crests.football-data.org/1.png
2	TSG 1899 Hoffenheim	1921	102	4	102	https://crests.football-data.org/2.png
3	Bayer 04 Leverkusen	1904	103	4	103	https://crests.football-data.org/3.png
4	Borussia Dortmund	1909	104	4	104	https://crests.football-data.org/4.png
5	FC Bayern München	1900	105	4	105	https://crests.football-data.org/5.svg
10	VfB Stuttgart	1893	106	4	106	https://crests.football-data.org/10.png
11	VfL Wolfsburg	1945	107	4	107	https://crests.football-data.org/11.svg
12	SV Werder Bremen	1899	108	4	108	https://crests.football-data.org/12.svg
15	1. FSV Mainz 05	1905	109	4	109	https://crests.football-data.org/15.png
16	FC Augsburg	1907	110	4	110	https://crests.football-data.org/16.png
17	SC Freiburg	1912	111	4	111	https://crests.football-data.org/17.svg
18	Borussia Mönchengladbach	1900	112	4	112	https://crests.football-data.org/18.png
19	Eintracht Frankfurt	1899	113	4	113	https://crests.football-data.org/19.svg
28	1. FC Union Berlin	1906	114	4	114	https://crests.football-data.org/28.svg
36	VfL Bochum 1848	1849	115	4	115	https://crests.football-data.org/36.png
44	1. FC Heidenheim 1846	1846	116	4	116	https://crests.football-data.org/44.svg
55	SV Darmstadt 98	1898	117	4	117	https://crests.football-data.org/55.png
721	RB Leipzig	2009	118	4	118	https://crests.football-data.org/721.png
98	AC Milan	1899	41	2	41	https://crests.football-data.org/98.png
99	ACF Fiorentina	1926	42	2	42	https://crests.football-data.org/99.png
100	AS Roma	1927	43	2	43	https://crests.football-data.org/100.png
102	Atalanta BC	1904	44	2	44	https://crests.football-data.org/102.png
103	Bologna FC 1909	1909	45	2	45	https://crests.football-data.org/103.png
104	Cagliari Calcio	1920	46	2	46	https://crests.football-data.org/104.png
107	Genoa CFC	1893	47	2	47	https://crests.football-data.org/107.png
108	FC Internazionale Milano	1908	41	2	48	https://crests.football-data.org/108.png
109	Juventus FC	1897	48	2	49	https://crests.football-data.org/109.png
110	SS Lazio	1900	43	2	50	https://crests.football-data.org/110.png
113	SSC Napoli	1904	49	2	51	https://crests.football-data.org/113.png
115	Udinese Calcio	1896	50	2	52	https://crests.football-data.org/115.png
445	Empoli FC	1920	51	2	53	https://crests.football-data.org/445.png
57	Arsenal	1886	21	1	21	https://crests.football-data.org/57.png
58	Aston Villa	1872	22	1	22	https://crests.football-data.org/58.png
61	Chelsea	1905	23	1	23	https://crests.football-data.org/61.png
62	Everton	1878	24	1	24	https://crests.football-data.org/62.png
63	Fulham	1879	25	1	25	https://crests.football-data.org/63.svg
64	Liverpool	1892	26	1	26	https://crests.football-data.org/64.png
65	Manchester City	1880	27	1	27	https://crests.football-data.org/65.png
66	Manchester United	1878	28	1	28	https://crests.football-data.org/66.png
67	Newcastle United	1881	29	1	29	https://crests.football-data.org/67.png
73	Tottenham Hotspur	1882	30	1	30	https://crests.football-data.org/73.png
76	Wolverhampton Wanderers	1877	31	1	31	https://crests.football-data.org/76.svg
328	Burnley	1881	32	1	32	https://crests.football-data.org/328.png
351	Nottingham Forest	1865	33	1	33	https://crests.football-data.org/351.png
354	Crystal Palace	1905	34	1	34	https://crests.football-data.org/354.png
356	Sheffield United	\N	35	1	35	https://crests.football-data.org/356.svg
389	Luton Town	1885	36	1	36	https://crests.football-data.org/389.png
397	Brighton & Hove Albion	1898	37	1	37	https://crests.football-data.org/397.svg
402	Brentford	1889	38	1	38	https://crests.football-data.org/402.png
563	West Ham United	1895	39	1	39	https://crests.football-data.org/563.png
1044	AFC Bournemouth	1890	40	1	40	https://crests.football-data.org/1044.png
450	Hellas Verona FC	1903	52	2	54	https://crests.football-data.org/450.png
455	US Salernitana 1919	1919	53	2	55	https://crests.football-data.org/455.png
470	Frosinone Calcio	1912	54	2	56	https://crests.football-data.org/470.png
471	US Sassuolo Calcio	1920	55	2	57	https://crests.football-data.org/471.png
586	Torino FC	1894	56	2	58	https://crests.football-data.org/586.png
5890	US Lecce	1908	57	2	59	https://crests.football-data.org/5890.png
5911	AC Monza	1912	58	2	60	https://crests.football-data.org/5911.png
275	UD Las Palmas	1949	77	3	77	https://crests.football-data.org/275.png
298	Girona FC	1930	78	3	78	https://crests.football-data.org/298.png
558	RC Celta de Vigo	1923	79	3	79	https://crests.football-data.org/558.svg
559	Sevilla FC	1905	80	3	80	https://crests.football-data.org/559.svg
511	Toulouse FC	1937	81	5	81	https://crests.football-data.org/511.png
512	Stade Brestois 29	1903	82	5	82	https://crests.football-data.org/512.png
516	Olympique de Marseille	1898	83	5	83	https://crests.football-data.org/516.png
518	Montpellier HSC	1970	84	5	84	https://crests.football-data.org/518.png
521	Lille OSC	1944	85	5	85	https://crests.football-data.org/521.svg
522	OGC Nice	1904	86	5	86	https://crests.football-data.org/522.png
523	Olympique Lyonnais	1896	87	5	87	https://crests.football-data.org/523.svg
524	Paris Saint-Germain FC	1904	88	5	88	https://crests.football-data.org/524.png
525	FC Lorient	1926	89	5	89	https://crests.football-data.org/525.png
529	Stade Rennais FC 1901	1901	90	5	90	https://crests.football-data.org/529.png
533	Le Havre AC	1872	91	5	91	https://crests.football-data.org/533.png
541	Clermont Foot 63	1911	92	5	92	https://crests.football-data.org/541.svg
543	FC Nantes	1943	93	5	93	https://crests.football-data.org/543.png
545	FC Metz	1919	94	5	94	https://crests.football-data.org/545.svg
546	Racing Club de Lens	1906	95	5	95	https://crests.football-data.org/546.png
547	Stade de Reims	1909	96	5	96	https://crests.football-data.org/547.png
548	AS Monaco FC	1919	97	5	97	https://crests.football-data.org/548.png
576	RC Strasbourg Alsace	1906	98	5	98	https://crests.football-data.org/576.png
\.


--
-- TOC entry 3449 (class 0 OID 16462)
-- Dependencies: 216
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: sports_league_owner
--

COPY public.users (user_id, username, password, email, is_admin) FROM stdin;
2	geydruqbaku23	12345678	geydruqbaku23@gmail.com	f
3	1	1234	gayibov21@itu.edu.tr	f
1	kaimg	12345678	qayibovkamran@gmail.com	f
6	geniy	$2b$12$715sLtvK3Ubw3kIK4s3PBeYwYb/Bg.e4CNNkNlpN9cnjMjAVmOhsO	geniy@gmail.com	f
7	12	$2b$12$NATEwLpl1Dxvu8eaM8vUyuAVKLr8Wt2TRc8MVWiN7RNwRx86GbJjG	adrf@gmail.com	f
4	admin	$2b$12$715sLtvK3Ubw3kIK4s3PBeYwYb/Bg.e4CNNkNlpN9cnjMjAVmOhsO	admin@example.com	t
\.


--
-- TOC entry 3491 (class 0 OID 0)
-- Dependencies: 225
-- Name: coaches_coach_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sports_league_owner
--

SELECT pg_catalog.setval('public.coaches_coach_id_seq', 8, true);


--
-- TOC entry 3492 (class 0 OID 0)
-- Dependencies: 233
-- Name: countries_country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sports_league_owner
--

SELECT pg_catalog.setval('public.countries_country_id_seq', 5, true);


--
-- TOC entry 3493 (class 0 OID 0)
-- Dependencies: 219
-- Name: leagues_league_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sports_league_owner
--

SELECT pg_catalog.setval('public.leagues_league_id_seq', 5, true);


--
-- TOC entry 3494 (class 0 OID 0)
-- Dependencies: 229
-- Name: matches_match_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sports_league_owner
--

SELECT pg_catalog.setval('public.matches_match_id_seq', 5, true);


--
-- TOC entry 3495 (class 0 OID 0)
-- Dependencies: 227
-- Name: players_player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sports_league_owner
--

SELECT pg_catalog.setval('public.players_player_id_seq', 10, true);


--
-- TOC entry 3496 (class 0 OID 0)
-- Dependencies: 239
-- Name: scorers_scorer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sports_league_owner
--

SELECT pg_catalog.setval('public.scorers_scorer_id_seq', 103, true);


--
-- TOC entry 3497 (class 0 OID 0)
-- Dependencies: 237
-- Name: scores_score_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sports_league_owner
--

SELECT pg_catalog.setval('public.scores_score_id_seq', 1752, true);


--
-- TOC entry 3498 (class 0 OID 0)
-- Dependencies: 221
-- Name: seasons_season_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sports_league_owner
--

SELECT pg_catalog.setval('public.seasons_season_id_seq', 5, true);


--
-- TOC entry 3499 (class 0 OID 0)
-- Dependencies: 217
-- Name: stadiums_stadium_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sports_league_owner
--

SELECT pg_catalog.setval('public.stadiums_stadium_id_seq', 11, true);


--
-- TOC entry 3500 (class 0 OID 0)
-- Dependencies: 231
-- Name: standings_standing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sports_league_owner
--

SELECT pg_catalog.setval('public.standings_standing_id_seq', 20, true);


--
-- TOC entry 3501 (class 0 OID 0)
-- Dependencies: 223
-- Name: teams_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sports_league_owner
--

SELECT pg_catalog.setval('public.teams_team_id_seq', 7, true);


--
-- TOC entry 3502 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sports_league_owner
--

SELECT pg_catalog.setval('public.users_user_id_seq', 7, true);


--
-- TOC entry 3267 (class 2606 OID 16525)
-- Name: coaches coaches_pkey; Type: CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.coaches
    ADD CONSTRAINT coaches_pkey PRIMARY KEY (coach_id);


--
-- TOC entry 3275 (class 2606 OID 106505)
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (country_id);


--
-- TOC entry 3261 (class 2606 OID 16487)
-- Name: leagues leagues_pkey; Type: CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.leagues
    ADD CONSTRAINT leagues_pkey PRIMARY KEY (league_id);


--
-- TOC entry 3279 (class 2606 OID 122911)
-- Name: match_referees match_referees_pkey; Type: CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.match_referees
    ADD CONSTRAINT match_referees_pkey PRIMARY KEY (match_id, referee_id);


--
-- TOC entry 3271 (class 2606 OID 16549)
-- Name: matches matches_pkey; Type: CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_pkey PRIMARY KEY (match_id);


--
-- TOC entry 3269 (class 2606 OID 16537)
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (player_id);


--
-- TOC entry 3277 (class 2606 OID 122906)
-- Name: referees referees_pkey; Type: CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.referees
    ADD CONSTRAINT referees_pkey PRIMARY KEY (referee_id);


--
-- TOC entry 3283 (class 2606 OID 139270)
-- Name: scorers scorers_pkey; Type: CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.scorers
    ADD CONSTRAINT scorers_pkey PRIMARY KEY (scorer_id);


--
-- TOC entry 3281 (class 2606 OID 131078)
-- Name: scores scores_pkey; Type: CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT scores_pkey PRIMARY KEY (score_id);


--
-- TOC entry 3263 (class 2606 OID 16494)
-- Name: seasons seasons_pkey; Type: CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.seasons
    ADD CONSTRAINT seasons_pkey PRIMARY KEY (season_id);


--
-- TOC entry 3259 (class 2606 OID 16478)
-- Name: stadiums stadiums_pkey; Type: CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.stadiums
    ADD CONSTRAINT stadiums_pkey PRIMARY KEY (stadium_id);


--
-- TOC entry 3273 (class 2606 OID 49158)
-- Name: standings standings_pkey; Type: CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.standings
    ADD CONSTRAINT standings_pkey PRIMARY KEY (standing_id);


--
-- TOC entry 3265 (class 2606 OID 16508)
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);


--
-- TOC entry 3257 (class 2606 OID 16469)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3289 (class 2606 OID 16526)
-- Name: coaches coaches_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.coaches
    ADD CONSTRAINT coaches_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- TOC entry 3292 (class 2606 OID 122897)
-- Name: matches fk_away_team; Type: FK CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT fk_away_team FOREIGN KEY (away_team_id) REFERENCES public.teams(team_id);


--
-- TOC entry 3286 (class 2606 OID 32768)
-- Name: teams fk_coach; Type: FK CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT fk_coach FOREIGN KEY (coach_id) REFERENCES public.coaches(coach_id) ON DELETE SET NULL;


--
-- TOC entry 3293 (class 2606 OID 122892)
-- Name: matches fk_home_team; Type: FK CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT fk_home_team FOREIGN KEY (home_team_id) REFERENCES public.teams(team_id);


--
-- TOC entry 3290 (class 2606 OID 32773)
-- Name: coaches fk_team; Type: FK CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.coaches
    ADD CONSTRAINT fk_team FOREIGN KEY (team_id) REFERENCES public.teams(team_id) ON DELETE SET NULL;


--
-- TOC entry 3284 (class 2606 OID 106506)
-- Name: leagues leagues_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.leagues
    ADD CONSTRAINT leagues_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.countries(country_id);


--
-- TOC entry 3299 (class 2606 OID 122912)
-- Name: match_referees match_referees_match_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.match_referees
    ADD CONSTRAINT match_referees_match_id_fkey FOREIGN KEY (match_id) REFERENCES public.matches(match_id);


--
-- TOC entry 3300 (class 2606 OID 122917)
-- Name: match_referees match_referees_referee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.match_referees
    ADD CONSTRAINT match_referees_referee_id_fkey FOREIGN KEY (referee_id) REFERENCES public.referees(referee_id);


--
-- TOC entry 3294 (class 2606 OID 16565)
-- Name: matches matches_league_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_league_id_fkey FOREIGN KEY (league_id) REFERENCES public.leagues(league_id);


--
-- TOC entry 3295 (class 2606 OID 16560)
-- Name: matches matches_season_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_season_id_fkey FOREIGN KEY (season_id) REFERENCES public.seasons(season_id);


--
-- TOC entry 3291 (class 2606 OID 16538)
-- Name: players players_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- TOC entry 3302 (class 2606 OID 139281)
-- Name: scorers scorers_league_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.scorers
    ADD CONSTRAINT scorers_league_id_fkey FOREIGN KEY (league_id) REFERENCES public.leagues(league_id);


--
-- TOC entry 3303 (class 2606 OID 139271)
-- Name: scorers scorers_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.scorers
    ADD CONSTRAINT scorers_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(player_id);


--
-- TOC entry 3304 (class 2606 OID 139276)
-- Name: scorers scorers_season_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.scorers
    ADD CONSTRAINT scorers_season_id_fkey FOREIGN KEY (season_id) REFERENCES public.seasons(season_id);


--
-- TOC entry 3301 (class 2606 OID 131079)
-- Name: scores scores_match_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT scores_match_id_fkey FOREIGN KEY (match_id) REFERENCES public.matches(match_id);


--
-- TOC entry 3285 (class 2606 OID 16495)
-- Name: seasons seasons_league_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.seasons
    ADD CONSTRAINT seasons_league_id_fkey FOREIGN KEY (league_id) REFERENCES public.leagues(league_id);


--
-- TOC entry 3296 (class 2606 OID 49164)
-- Name: standings standings_league_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.standings
    ADD CONSTRAINT standings_league_id_fkey FOREIGN KEY (league_id) REFERENCES public.leagues(league_id);


--
-- TOC entry 3297 (class 2606 OID 49159)
-- Name: standings standings_season_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.standings
    ADD CONSTRAINT standings_season_id_fkey FOREIGN KEY (season_id) REFERENCES public.seasons(season_id);


--
-- TOC entry 3298 (class 2606 OID 49169)
-- Name: standings standings_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.standings
    ADD CONSTRAINT standings_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id);


--
-- TOC entry 3287 (class 2606 OID 16514)
-- Name: teams teams_league_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_league_id_fkey FOREIGN KEY (league_id) REFERENCES public.leagues(league_id);


--
-- TOC entry 3288 (class 2606 OID 16509)
-- Name: teams teams_stadium_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sports_league_owner
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_stadium_id_fkey FOREIGN KEY (stadium_id) REFERENCES public.stadiums(stadium_id);


--
-- TOC entry 2102 (class 826 OID 16391)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- TOC entry 2101 (class 826 OID 16390)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


-- Completed on 2024-06-10 15:24:39

--
-- PostgreSQL database dump complete
--

