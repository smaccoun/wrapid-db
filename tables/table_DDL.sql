CREATE TABLE base_profile
(
    base_profile_id INTEGER DEFAULT nextval('base_profile_base_profile_id_seq'::regclass) PRIMARY KEY NOT NULL,
    first_name CHAR(30),
    last_name CHAR(30),
    middle_initial CHAR(30)
);
CREATE UNIQUE INDEX base_profile_base_profile_id_uindex ON base_profile (base_profile_id);
CREATE TABLE extra
(
    user_id TEXT PRIMARY KEY NOT NULL,
    extra_profile_id INTEGER,
    CONSTRAINT extra_user_user_id_fk FOREIGN KEY (user_id) REFERENCES "user" (user_id),
    CONSTRAINT extra_extra_profile_extra_profile_id_fk FOREIGN KEY (extra_profile_id) REFERENCES extra_profile (extra_profile_id)
);
CREATE UNIQUE INDEX extra_user_id_uindex ON extra (user_id);
CREATE TABLE extra_profile
(
    extra_profile_id INTEGER DEFAULT nextval('extra_profile_extra_profile_id_seq'::regclass) PRIMARY KEY NOT NULL,
    base_profile_id INTEGER,
    street_address TEXT,
    city CHAR(50),
    state CHAR(2),
    zip CHAR(5),
    CONSTRAINT extra_profile_base_profile_base_profile_id_fk FOREIGN KEY (base_profile_id) REFERENCES base_profile (base_profile_id)
);
CREATE UNIQUE INDEX extra_profile_extra_profile_id_uindex ON extra_profile (extra_profile_id);
CREATE TABLE "user"
(
    user_id TEXT PRIMARY KEY NOT NULL,
    password_salt TEXT NOT NULL
);
CREATE UNIQUE INDEX user_user_id_uindex ON "user" (user_id);