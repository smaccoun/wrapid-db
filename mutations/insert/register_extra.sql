/*
SAMPLE USAGE:
  SELECT register_extra AS user_id FROM register_extra('john@fake.com', 'wrapid', 'John', 'Smith', 'J');

--DROP FUNCTION register_extra(text, text, text, text, text);
 */

CREATE OR REPLACE FUNCTION register_extra (p_user_id text, p_password_salt text, p_first_name text, p_last_name text, p_middle_initial text)
  RETURNS text
AS $$
  WITH
  user_insert AS(
    INSERT INTO public.user VALUES (p_user_id, p_password_salt)
    RETURNING user_id
  ),
  base_profile_insert AS (
    INSERT INTO base_profile VALUES (DEFAULT, p_first_name, p_last_name, p_middle_initial)
    RETURNING base_profile_id
  ),
  extra_profile_insert AS (
    INSERT INTO extra_profile
    SELECT
        nextval('extra_profile_extra_profile_id_seq') AS extra_profile_id
      , base_profile_insert.base_profile_id
    FROM base_profile_insert
    RETURNING extra_profile_id
  )
  INSERT INTO extra
      SELECT
        ui.user_id AS user_id,
        epi.extra_profile_id
      FROM extra_profile_insert epi
      CROSS JOIN user_insert ui
  RETURNING user_id

$$
LANGUAGE sql;