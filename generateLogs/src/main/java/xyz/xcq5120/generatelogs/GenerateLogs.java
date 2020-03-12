package xyz.xcq5120.generatelogs;


import java.io.*;
import java.nio.charset.StandardCharsets;

public class GenerateLogs {
  public static void main(String[] args) {
    String readFileName = args[0];
    String writeFileName = args[1];
    Integer speed = Integer.parseInt(args[2]);
    try {
      readFileByLines(readFileName, writeFileName, speed);
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  private static void readFileByLines(String fileName, String writeFileName, Integer speed) throws IOException {
    InputStreamReader isr = null;
    BufferedReader br;
    String tempString;
    try {
      System.out.println("以行为单位读取文件内容，一次读一整行：");
      // FileInputStream
      FileInputStream fis = new FileInputStream(fileName);
      // 从文件系统中的某个文件中获取字节
      isr = new InputStreamReader(fis, StandardCharsets.UTF_8);
      br = new BufferedReader(isr);
      int count = 0;
      while ((tempString = br.readLine()) != null) {
        count++;
        // 显示行号
        Thread.sleep(speed);
        System.out.println("row:" + count + ">>>>>>>>" + tempString);
        writeToFile(writeFileName, tempString);
      }
      isr.close();
    } catch (IOException | InterruptedException e) {
      e.printStackTrace();
    } finally {
      if (isr != null) {
        isr.close();
      }
    }
  }

  private static void writeToFile(String file, String content) {
    BufferedWriter out = null;
    try {
      out = new BufferedWriter(new OutputStreamWriter(
          new FileOutputStream(file, true)));
      out.write(content);
      out.write("\n");
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      try {
        if (out != null) {
          out.close();
        }
      } catch (IOException e) {
        e.printStackTrace();
      }
    }
  }
}