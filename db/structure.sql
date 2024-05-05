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
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_admin_comments (
    id bigint NOT NULL,
    namespace character varying,
    body text,
    resource_type character varying,
    resource_id bigint,
    author_type character varying,
    author_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_admin_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_admin_comments_id_seq OWNED BY public.active_admin_comments.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: attempt_transitions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.attempt_transitions (
    id bigint NOT NULL,
    to_state character varying NOT NULL,
    metadata json DEFAULT '{}'::json,
    sort_key integer NOT NULL,
    attempt_id integer NOT NULL,
    most_recent boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: attempt_transitions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.attempt_transitions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attempt_transitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.attempt_transitions_id_seq OWNED BY public.attempt_transitions.id;


--
-- Name: attempts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.attempts (
    id bigint NOT NULL,
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    interviewee_id bigint,
    interview_id bigint,
    response jsonb,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: attempts_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.attempts_categories (
    id bigint NOT NULL,
    attempt_id bigint,
    category_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: attempts_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.attempts_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attempts_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.attempts_categories_id_seq OWNED BY public.attempts_categories.id;


--
-- Name: attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.attempts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.attempts_id_seq OWNED BY public.attempts.id;


--
-- Name: attempts_questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.attempts_questions (
    id bigint NOT NULL,
    attempt_id bigint,
    question_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: attempts_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.attempts_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attempts_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.attempts_questions_id_seq OWNED BY public.attempts_questions.id;


--
-- Name: auth_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_tokens (
    id bigint NOT NULL,
    client_id character varying,
    user_id bigint,
    token character varying,
    expires timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: auth_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_tokens_id_seq OWNED BY public.auth_tokens.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying,
    parent_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: categories_questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories_questions (
    id bigint NOT NULL,
    category_id bigint,
    question_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: categories_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_questions_id_seq OWNED BY public.categories_questions.id;


--
-- Name: essays; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.essays (
    id bigint NOT NULL,
    answer_min_length integer,
    answer_max_length integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: essays_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.essays_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: essays_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.essays_id_seq OWNED BY public.essays.id;


--
-- Name: interviewees; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.interviewees (
    id bigint NOT NULL,
    auth_code character varying,
    user_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: interviewees_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.interviewees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: interviewees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.interviewees_id_seq OWNED BY public.interviewees.id;


--
-- Name: interviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.interviews (
    id bigint NOT NULL,
    name character varying,
    config jsonb,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: interviews_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.interviews_categories (
    id bigint NOT NULL,
    interview_id bigint,
    category_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: interviews_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.interviews_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: interviews_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.interviews_categories_id_seq OWNED BY public.interviews_categories.id;


--
-- Name: interviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.interviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: interviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.interviews_id_seq OWNED BY public.interviews.id;


--
-- Name: mcqs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mcqs (
    id bigint NOT NULL,
    options text[] DEFAULT '{}'::text[],
    correct_options integer[] DEFAULT '{}'::integer[],
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: mcqs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.mcqs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mcqs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.mcqs_id_seq OWNED BY public.mcqs.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.questions (
    id bigint NOT NULL,
    title character varying,
    questionable_type character varying,
    questionable_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: tenants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tenants (
    id bigint NOT NULL,
    domain character varying,
    name character varying,
    config json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: tenants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tenants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tenants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tenants_id_seq OWNED BY public.tenants.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    title character varying,
    first_name character varying,
    middle_name character varying,
    last_name character varying,
    admin boolean
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: active_admin_comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_admin_comments ALTER COLUMN id SET DEFAULT nextval('public.active_admin_comments_id_seq'::regclass);


--
-- Name: attempt_transitions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attempt_transitions ALTER COLUMN id SET DEFAULT nextval('public.attempt_transitions_id_seq'::regclass);


--
-- Name: attempts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attempts ALTER COLUMN id SET DEFAULT nextval('public.attempts_id_seq'::regclass);


--
-- Name: attempts_categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attempts_categories ALTER COLUMN id SET DEFAULT nextval('public.attempts_categories_id_seq'::regclass);


--
-- Name: attempts_questions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attempts_questions ALTER COLUMN id SET DEFAULT nextval('public.attempts_questions_id_seq'::regclass);


--
-- Name: auth_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_tokens ALTER COLUMN id SET DEFAULT nextval('public.auth_tokens_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: categories_questions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories_questions ALTER COLUMN id SET DEFAULT nextval('public.categories_questions_id_seq'::regclass);


--
-- Name: essays id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.essays ALTER COLUMN id SET DEFAULT nextval('public.essays_id_seq'::regclass);


--
-- Name: interviewees id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interviewees ALTER COLUMN id SET DEFAULT nextval('public.interviewees_id_seq'::regclass);


--
-- Name: interviews id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interviews ALTER COLUMN id SET DEFAULT nextval('public.interviews_id_seq'::regclass);


--
-- Name: interviews_categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interviews_categories ALTER COLUMN id SET DEFAULT nextval('public.interviews_categories_id_seq'::regclass);


--
-- Name: mcqs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mcqs ALTER COLUMN id SET DEFAULT nextval('public.mcqs_id_seq'::regclass);


--
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- Name: tenants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tenants ALTER COLUMN id SET DEFAULT nextval('public.tenants_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: active_admin_comments active_admin_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_admin_comments
    ADD CONSTRAINT active_admin_comments_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: attempt_transitions attempt_transitions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attempt_transitions
    ADD CONSTRAINT attempt_transitions_pkey PRIMARY KEY (id);


--
-- Name: attempts_categories attempts_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attempts_categories
    ADD CONSTRAINT attempts_categories_pkey PRIMARY KEY (id);


--
-- Name: attempts attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attempts
    ADD CONSTRAINT attempts_pkey PRIMARY KEY (id);


--
-- Name: attempts_questions attempts_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attempts_questions
    ADD CONSTRAINT attempts_questions_pkey PRIMARY KEY (id);


--
-- Name: auth_tokens auth_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_tokens
    ADD CONSTRAINT auth_tokens_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categories_questions categories_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories_questions
    ADD CONSTRAINT categories_questions_pkey PRIMARY KEY (id);


--
-- Name: essays essays_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.essays
    ADD CONSTRAINT essays_pkey PRIMARY KEY (id);


--
-- Name: interviewees interviewees_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interviewees
    ADD CONSTRAINT interviewees_pkey PRIMARY KEY (id);


--
-- Name: interviews_categories interviews_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interviews_categories
    ADD CONSTRAINT interviews_categories_pkey PRIMARY KEY (id);


--
-- Name: interviews interviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interviews
    ADD CONSTRAINT interviews_pkey PRIMARY KEY (id);


--
-- Name: mcqs mcqs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mcqs
    ADD CONSTRAINT mcqs_pkey PRIMARY KEY (id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: tenants tenants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON public.active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_namespace ON public.active_admin_comments USING btree (namespace);


--
-- Name: index_active_admin_comments_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_resource_type_and_resource_id ON public.active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_attempt_transitions_parent_most_recent; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_attempt_transitions_parent_most_recent ON public.attempt_transitions USING btree (attempt_id, most_recent) WHERE most_recent;


--
-- Name: index_attempt_transitions_parent_sort; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_attempt_transitions_parent_sort ON public.attempt_transitions USING btree (attempt_id, sort_key);


--
-- Name: index_attempts_categories_on_attempt_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_attempts_categories_on_attempt_id ON public.attempts_categories USING btree (attempt_id);


--
-- Name: index_attempts_categories_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_attempts_categories_on_category_id ON public.attempts_categories USING btree (category_id);


--
-- Name: index_attempts_on_interview_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_attempts_on_interview_id ON public.attempts USING btree (interview_id);


--
-- Name: index_attempts_on_interviewee_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_attempts_on_interviewee_id ON public.attempts USING btree (interviewee_id);


--
-- Name: index_attempts_questions_on_attempt_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_attempts_questions_on_attempt_id ON public.attempts_questions USING btree (attempt_id);


--
-- Name: index_attempts_questions_on_question_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_attempts_questions_on_question_id ON public.attempts_questions USING btree (question_id);


--
-- Name: index_auth_tokens_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_auth_tokens_on_user_id ON public.auth_tokens USING btree (user_id);


--
-- Name: index_auth_tokens_on_user_id_and_token_and_expires; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_auth_tokens_on_user_id_and_token_and_expires ON public.auth_tokens USING btree (user_id, token, expires);


--
-- Name: index_categories_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categories_on_name ON public.categories USING btree (name);


--
-- Name: index_categories_questions_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categories_questions_on_category_id ON public.categories_questions USING btree (category_id);


--
-- Name: index_categories_questions_on_question_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categories_questions_on_question_id ON public.categories_questions USING btree (question_id);


--
-- Name: index_interviewees_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_interviewees_on_user_id ON public.interviewees USING btree (user_id);


--
-- Name: index_interviews_categories_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_interviews_categories_on_category_id ON public.interviews_categories USING btree (category_id);


--
-- Name: index_interviews_categories_on_interview_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_interviews_categories_on_interview_id ON public.interviews_categories USING btree (interview_id);


--
-- Name: index_questions_on_questionable_type_and_questionable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_questions_on_questionable_type_and_questionable_id ON public.questions USING btree (questionable_type, questionable_id);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_unlock_token ON public.users USING btree (unlock_token);


--
-- Name: attempts fk_rails_075e709a68; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attempts
    ADD CONSTRAINT fk_rails_075e709a68 FOREIGN KEY (interviewee_id) REFERENCES public.interviewees(id);


--
-- Name: categories_questions fk_rails_0c3a564e94; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories_questions
    ADD CONSTRAINT fk_rails_0c3a564e94 FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: attempts_questions fk_rails_0d4ac5d326; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attempts_questions
    ADD CONSTRAINT fk_rails_0d4ac5d326 FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: auth_tokens fk_rails_0d66c22f4c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_tokens
    ADD CONSTRAINT fk_rails_0d66c22f4c FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: attempt_transitions fk_rails_1322f08966; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attempt_transitions
    ADD CONSTRAINT fk_rails_1322f08966 FOREIGN KEY (attempt_id) REFERENCES public.attempts(id);


--
-- Name: interviews_categories fk_rails_35c86a3d0c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interviews_categories
    ADD CONSTRAINT fk_rails_35c86a3d0c FOREIGN KEY (interview_id) REFERENCES public.interviews(id);


--
-- Name: attempts fk_rails_3ba61dc18d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attempts
    ADD CONSTRAINT fk_rails_3ba61dc18d FOREIGN KEY (interview_id) REFERENCES public.interviews(id);


--
-- Name: interviewees fk_rails_7b059af869; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interviewees
    ADD CONSTRAINT fk_rails_7b059af869 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: attempts_categories fk_rails_a43ebc01e7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attempts_categories
    ADD CONSTRAINT fk_rails_a43ebc01e7 FOREIGN KEY (attempt_id) REFERENCES public.attempts(id);


--
-- Name: categories_questions fk_rails_c37e12c473; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories_questions
    ADD CONSTRAINT fk_rails_c37e12c473 FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: attempts_categories fk_rails_da85c29e5b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attempts_categories
    ADD CONSTRAINT fk_rails_da85c29e5b FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: attempts_questions fk_rails_de7b649517; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attempts_questions
    ADD CONSTRAINT fk_rails_de7b649517 FOREIGN KEY (attempt_id) REFERENCES public.attempts(id);


--
-- Name: interviews_categories fk_rails_f065a6eea4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.interviews_categories
    ADD CONSTRAINT fk_rails_f065a6eea4 FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20180930114048'),
('20180930114804'),
('20181001191733'),
('20181001192446'),
('20181001202717'),
('20181001202938'),
('20181001203631'),
('20181001204256'),
('20181001213148'),
('20181001213219'),
('20181001213251'),
('20181001213323'),
('20181001213401'),
('20181002081720'),
('20181003144755'),
('20181003172759'),
('20181007093903'),
('20240505141751');


