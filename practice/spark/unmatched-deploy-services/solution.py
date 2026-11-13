from pyspark.sql.functions import col, lower, trim

dl = (
  spark.read.table("deploy_logs")
  .select(
    lower(trim(col("svc_name"))).alias("service_name")
  )
  .distinct()
)

et = (
  spark.read.table("err_tracks")
  .select(
    lower(trim(col("svc_name"))).alias("service_name")
  )
  .distinct()
)

result = (
  dl.join(
    broadcast(et),
    on="service_name",
    how="left_anti"
  )
  .orderBy("service_name")
)

result.show()
