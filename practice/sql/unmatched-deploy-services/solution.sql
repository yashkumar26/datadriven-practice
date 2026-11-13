SELECT DISTINCT
  LOWER(TRIM(d.svc_name)) AS service_name
FROM deploy_logs d
WHERE NOT EXISTS (
  SELECT 1
  FROM err_tracks e
  WHERE LOWER(TRIM(e.svc_name)) =
      LOWER(TRIM(d.svc_name))
)
ORDER BY service_name;
