from pyspark.sql.functions import *
dl=spark.read.table("deploy_logs")
et=spark.read.table("err_tracks").withColumnRenamed("svc_name","svc_name_et")

dl=dl.withColumn("svc_name",trim(lower(col("svc_name"))))
et=et.withColumn("svc_name_et",trim(lower(col("svc_name_et"))))
joined_df=dl.join(et,dl.svc_name==et.svc_name_et,"left")
joined_df.filter("svc_name_et is null").select("svc_name").distinct().orderBy("svc_name").show()
