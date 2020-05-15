package xyz.xcq5120.test

import org.apache.spark.sql.SparkSession

object StructuredStreamingKafkaTest {
  def main(args: Array[String]): Unit = {

    val spark = SparkSession.builder()
      .master("local[2]")
      .appName("streaming").getOrCreate()

    val df = spark
      .readStream
      .format("kafka")
      .option("kafka.bootstrap.servers", "hadoop-1:9092")
      .option("subscribe", "weblogs")
      .load()

    import spark.implicits._
    val lines = df.selectExpr("CAST(value AS STRING)").as[String]
    val words = lines.flatMap(_.split(" "))
    val wordCounts = words.groupBy("value").count()

    val query = wordCounts.writeStream
      .outputMode("complete")
      .format("console")
      .start()

    query.awaitTermination()


  }
}
