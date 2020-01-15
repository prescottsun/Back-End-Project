--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10 (Ubuntu 10.10-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.10 (Ubuntu 10.10-0ubuntu0.18.04.1)

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

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: activity_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activity_log (
    id integer NOT NULL,
    user_id integer,
    resource_id integer,
    activity_name character varying(200),
    activity_description character varying(500),
    date_completed date DEFAULT now(),
    hours_spent numeric DEFAULT 0
);


ALTER TABLE public.activity_log OWNER TO postgres;

--
-- Name: activity_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activity_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activity_log_id_seq OWNER TO postgres;

--
-- Name: activity_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activity_log_id_seq OWNED BY public.activity_log.id;


--
-- Name: resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resources (
    id integer NOT NULL,
    title character varying(200),
    type character varying(200),
    description character varying(500),
    url character varying(200)
);


ALTER TABLE public.resources OWNER TO postgres;

--
-- Name: resources_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.resources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resources_id_seq OWNER TO postgres;

--
-- Name: resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resources_id_seq OWNED BY public.resources.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    id integer NOT NULL,
    user_id integer,
    resource_id integer,
    stars numeric,
    content character varying(500),
    CONSTRAINT reviews_stars_check CHECK (((stars >= (1)::numeric) AND (stars <= (5)::numeric)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reviews_id_seq OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100),
    email character varying(200),
    password character varying(200),
    about character varying(500),
    profile_picture character varying(200)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: activity_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_log ALTER COLUMN id SET DEFAULT nextval('public.activity_log_id_seq'::regclass);


--
-- Name: resources id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources ALTER COLUMN id SET DEFAULT nextval('public.resources_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: activity_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activity_log (id, user_id, resource_id, activity_name, activity_description, date_completed, hours_spent) FROM stdin;
12	1	1	Watched a video tutorial	Watched a video tutorial on creating an API with the NEP stack	2019-10-23	2
13	1	2	Watched video tutorials	Watched video tutorials on different topics of Javascript	2019-10-25	3
14	1	4	Read an article	Read an article on bcrypt	2019-10-26	1
15	2	3	Watched video tutorials	Watched a Youtube series on using Node.js	2019-10-20	4
16	2	2	Read an article	Read a blog article on how to use bcrypt	2019-10-27	1
17	1	6	Read blog article	Read an article on designing RESTful APIs with Node and PSQL	2019-10-18	2
18	3	7	Watched video series	Watched videos from a Youtube series covering fundamental concepts of computer science	2019-10-22	3
19	3	5	Read book series	Read from a few chapters from a book series on Javascript	2019-10-16	2
20	2	6	Read article	Read an online article on Node and Postgres	2019-10-19	1
21	3	2	Watched Youtube series	Watched Youtube tutorials from The Coding Train on various topics relating to Javascript	2019-10-15	5
22	1	3	Watched a video tutorial	Watched a video tutorial on Node JS	2019-10-29	2
\.


--
-- Data for Name: resources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resources (id, title, type, description, url) FROM stdin;
1	Build A Restful Api With Node.js Express & MongoDB	Video tutorial	A video tutorial on RESTful Node APIs	https://www.youtube.com/watch?v=vjf774RKrLc
2	Topics of Javascript/ES6-8	Video tutorials	Youtube tutorials by The Coding Train on different Javascript topcs	https://www.youtube.com/playlist?list=PLRqwX-V7Uu6YgpA3Oht-7B4NBQwFVe3pr
3	Node JS Tutorial for Beginners	Video tutorials	Youtube tutorials by The Net Ninja on using Node.js	https://www.youtube.com/playlist?list=PL4cUxeGkcC9gcy9lrvMJ75z9maRw4byYp
4	Hashing in Action: Understanding bcrypt	Article	Blog article going in-depth on the usage of bcrypt	https://auth0.com/blog/hashing-in-action-understanding-bcrypt/
5	You Dont Know JS	Book series	Book series by Kyle Simpson on Javascript	https://github.com/getify/You-Dont-Know-JS
6	Designing a RESTful API with Node and Postgres	Article	Blog tutorial on using Node and PSQL to create a RESTful API	https://mherman.org/blog/designing-a-restful-api-with-node-and-postgres/#postgres-setup
7	Crash Course Computer Science	Video series	Animated Youtube series covering various topics on the history and theory of computer science	https://www.youtube.com/playlist?list=PL8dPuuaLjXtNlUrzyH5r6jN9ulIgZBpdo
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (id, user_id, resource_id, stars, content) FROM stdin;
28	1	1	5	This helped me learn a lot
29	1	2	4	This was very interesting
30	1	4	2	I did not find this that helpful
31	2	3	5	This helped clarify the topic for me
32	2	2	4	This is worth checkout out
33	1	6	1	I could not understand this
34	3	7	5	The material was very engaging
35	3	5	3	This was ok
36	2	6	4	Great
37	3	2	5	Fantastic. 5 stars
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, first_name, last_name, email, password, about, profile_picture) FROM stdin;
1	Prescott	Sun	sunprescott@gmail.com	$2a$10$bX07VfqX2LnsMLhCxBNCEeYKkCnBKnBEKxhBZfdQojZQzEXQ7xPfm	Student at DigitalCrafts	\N
3	Michelle	Owens	michelle@gmail.com	$2a$10$wbQk4uiAV07fqb5jJMlZrO35W.X9g7gAcqflRSQYnoI9Hrv71mAxC	Student at DigitalCrafts	\N
2	Kyra	Mellema	kyra@gmail.com	$2a$10$JrtvPmsmO2o96mhFxdQ7geXf2wedaeTGtlu805D47wUdT9Y85dB2.	Student at DigitalCrafts	\N
11	Bob	Bobson	mail.com	$2a$10$GgdPwPeUcqJLkHTdaZGzTumK/FEzsjNlGpNoE6ot8MparlmNnDC6W	I love to code!	\N
\.


--
-- Name: activity_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.activity_log_id_seq', 22, true);


--
-- Name: resources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resources_id_seq', 43, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_id_seq', 37, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 11, true);


--
-- Name: activity_log activity_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_log
    ADD CONSTRAINT activity_log_pkey PRIMARY KEY (id);


--
-- Name: resources resources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: activity_log activity_log_resource_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_log
    ADD CONSTRAINT activity_log_resource_id_fkey FOREIGN KEY (resource_id) REFERENCES public.resources(id);


--
-- Name: activity_log activity_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_log
    ADD CONSTRAINT activity_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: reviews reviews_resource_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_resource_id_fkey FOREIGN KEY (resource_id) REFERENCES public.resources(id);


--
-- Name: reviews reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

