CREATE TABLE extra
(
    user_id TEXT PRIMARY KEY NOT NULL
);
CREATE TABLE paper_form
(
    paper_form_id TEXT PRIMARY KEY NOT NULL,
    paper_form_fields_id INTEGER,
    created_ts TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_ts TIMESTAMP WITH TIME ZONE NOT NULL,
    due_dt DATE,
    user_filler_id TEXT,
    user_verifier_id TEXT,
    signed_ts TIMESTAMP WITH TIME ZONE
);
CREATE TABLE paper_form_field
(
    id TEXT PRIMARY KEY NOT NULL,
    paper_form_template_field_id INTEGER,
    value TEXT,
    updated_ts TIMESTAMP WITH TIME ZONE NOT NULL,
    created_ts TIMESTAMP WITH TIME ZONE NOT NULL
);
CREATE TABLE paper_form_fields
(
    paper_form_id TEXT,
    paper_form_field_id TEXT
);
CREATE TABLE paper_form_template
(
    id TEXT PRIMARY KEY NOT NULL,
    base_image_64 CHAR(64),
    creation_ts TIMESTAMP WITH TIME ZONE,
    updated_ts TIMESTAMP WITH TIME ZONE
);
CREATE TABLE paper_form_template_field
(
    id INTEGER DEFAULT nextval('paper_form_field_id_seq'::regclass) PRIMARY KEY NOT NULL,
    label TEXT NOT NULL,
    coord_x INTEGER,
    coord_y INTEGER,
    category TEXT,
    updated_ts TIMESTAMP WITH TIME ZONE
);
CREATE TABLE paper_form_template_fields
(
    paper_form_template_id TEXT,
    paper_form_template_field_id INTEGER
);
CREATE TABLE profile_field
(
    profile_field_id TEXT PRIMARY KEY NOT NULL,
    label TEXT NOT NULL,
    value TEXT
);
CREATE TABLE profile_field_input
(
    profile_field_id TEXT,
    input TEXT,
    updated_ts TIMESTAMP WITH TIME ZONE NOT NULL,
    profile_field_input_id INTEGER DEFAULT nextval('profile_field_input_profile_field_input_id_seq'::regclass) PRIMARY KEY NOT NULL
);
CREATE TABLE static_base_extra_profile_fields
(
    profile_field_id TEXT PRIMARY KEY NOT NULL,
    label TEXT
);
CREATE TABLE "user"
(
    user_id TEXT PRIMARY KEY NOT NULL,
    password_salt TEXT NOT NULL
);
CREATE TABLE user_profile
(
    user_id TEXT NOT NULL,
    last_submitted_ts TIMESTAMP WITH TIME ZONE
);
CREATE TABLE user_profile_field_inputs
(
    user_id TEXT NOT NULL,
    profile_field_input_id INTEGER
);
ALTER TABLE extra ADD FOREIGN KEY (user_id) REFERENCES "user" (user_id);
CREATE UNIQUE INDEX extra_user_id_uindex ON extra (user_id);
ALTER TABLE paper_form ADD FOREIGN KEY (user_filler_id) REFERENCES "user" (user_id);
ALTER TABLE paper_form ADD FOREIGN KEY (user_verifier_id) REFERENCES "user" (user_id);
CREATE UNIQUE INDEX paper_form_paper_form_id_uindex ON paper_form (paper_form_id);
ALTER TABLE paper_form_field ADD FOREIGN KEY (paper_form_template_field_id) REFERENCES paper_form_template_field (id);
ALTER TABLE paper_form_fields ADD FOREIGN KEY (paper_form_id) REFERENCES paper_form (paper_form_id);
ALTER TABLE paper_form_fields ADD FOREIGN KEY (paper_form_field_id) REFERENCES paper_form_field (id);
CREATE UNIQUE INDEX paper_form_template_id_uindex ON paper_form_template (id);
CREATE UNIQUE INDEX paper_form_field_id_uindex ON paper_form_template_field (id);
ALTER TABLE paper_form_template_fields ADD FOREIGN KEY (paper_form_template_id) REFERENCES paper_form_template (id);
ALTER TABLE paper_form_template_fields ADD FOREIGN KEY (paper_form_template_field_id) REFERENCES paper_form_template_field (id);
CREATE UNIQUE INDEX profile_field_profile_field_id_uindex ON profile_field (profile_field_id);
ALTER TABLE profile_field_input ADD FOREIGN KEY (profile_field_id) REFERENCES profile_field (profile_field_id);
CREATE UNIQUE INDEX profile_field_input_profile_field_input_id_uindex ON profile_field_input (profile_field_input_id);
CREATE UNIQUE INDEX static_base_extra_profile_fields_profile_field_id_uindex ON static_base_extra_profile_fields (profile_field_id);
CREATE UNIQUE INDEX user_user_id_uindex ON "user" (user_id);
ALTER TABLE user_profile ADD FOREIGN KEY (user_id) REFERENCES "user" (user_id);
CREATE UNIQUE INDEX user_profile_user_id_uindex ON user_profile (user_id);
ALTER TABLE user_profile_field_inputs ADD FOREIGN KEY (user_id) REFERENCES user_profile (user_id);
ALTER TABLE user_profile_field_inputs ADD FOREIGN KEY (profile_field_input_id) REFERENCES profile_field_input (profile_field_input_id)CREATE FUNCTION get_extra_profile(p_user_id TEXT) RETURNS TABLE(USER_ID TEXT, LABEL TEXT, VALUE TEXT);
CREATE FUNCTION register_extra(p_user_id TEXT, p_password_salt TEXT, p_first_name TEXT, p_last_name TEXT, p_middle_initial TEXT) RETURNS TABLE(USER_ID TEXT, PROFILE_FIELD_ID TEXT, INPUT TEXT);