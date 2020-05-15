package xyz.xcq5120.test

import org.apache.spark.sql.SparkSession

object Test {
  def main(args: Array[String]): Unit = {
    val spark = SparkSession
      .builder
//      .master("yarn-cluster")
      .master("local[2]")
      .appName("SparkTest")
      .getOrCreate()

//    val filePath = args(0)
    val filePath = "./src/main/resources/word.input"

//    val rdd = spark.sparkContext.textFile(filePath)
//    val lines = rdd.flatMap( x => x.split(" "))
//      .map(x => (x,1))
//      .reduceByKey((a,b) => (a+b))
//      .collect().toList
//    println(lines)

    import spark.implicits._
    spark.read.textFile(filePath)
      .flatMap(x=>x.split(" "))
      .map(x => (x,1))
      .groupBy("_1")
      .count()
      .show()

  }
}
