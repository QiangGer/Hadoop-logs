package xyz.xcq5120.test

import java.sql._
import org.apache.spark.sql.{ForeachWriter, Row}
import org.apache.log4j.Logger


class JDBCSink(url: String, username: String, password: String) extends ForeachWriter[Row] {

  var statement: Statement = _
  var resultSet: ResultSet = _
  var connection: Connection = _

  override def open(partitionId: Long, version: Long): Boolean = {
    Class.forName("com.mysql.jdbc.Driver").newInstance()
    connection = DriverManager.getConnection(url, username, password)

    //    connection = new MySqlPool(url, username, password).getJdbcConn()
    statement = connection.createStatement()
    true
  }

  override def process(value: Row): Unit = {

    val titleName = value.getAs[String]("titleName").replaceAll("[\\[\\]]", "")
    val count = value.getAs[Long]("count")

    val querySql = "select * from webCount " +
      "where titleName = '" + titleName + "'"

    val updateSql = "update webCount set " +
      "count = " + count + " where titleName = '" + titleName + "'"

    val insertSql = "insert into webCount(titleName,count)" +
      "values('" + titleName + "'," + count + ")"

    try {

      //查看连接是否成功
      val resultSet = statement.executeQuery(querySql)
      if (resultSet.next()) {
        statement.executeUpdate(updateSql)
//        System.out.println(updateSql)
      } else {
        statement.execute(insertSql)
//        System.out.println(insertSql)
      }
    } catch {
      case ex: SQLException => {
        println("SQLException")
      }
      case ex: Exception => {
        println("Exception")
      }
      case ex: RuntimeException => {
        println("RuntimeException")
      }
      case ex: Throwable => {
        println("Throwable")
      }
    }
  }


  override def close(errorOrNull: Throwable): Unit = {
    //    if(resultSet.wasNull()){
    //      resultSet.close()
    //    }
    if (statement == null) {
      statement.close()
    }
    if (connection == null) {
      connection.close()
    }
  }
}
