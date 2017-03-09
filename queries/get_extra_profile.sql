CREATE FUNCTION get_extra_profile (p_user_id text) RETURNS TABLE(first_name character, last_name character)
	LANGUAGE sql
AS $$
  SELECT
    bp.first_name,
    bp.last_name
  FROM extra_profile ep
JOIN base_profile bp on bp.base_profile_id = ep.base_profile_id
JOIN extra e ON e.user_id = p_user_id

$$
