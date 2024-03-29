package com.bigdata.cctv;

import com.google.gson.JsonObject;
import netscape.javascript.JSObject;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import java.io.IOException;

public class BookMapper extends Mapper<Object, Text, Text, Text> {
    private  Text word = new Text();
    private final IntWritable wr = new IntWritable(1);

    @Override
    protected void map(Object key, Text value, Mapper<Object, Text, Text, Text>.Context context) throws IOException, InterruptedException {
        // 데이터 추출
        String[] strs = value.toString().split("\n");

        for(String str : strs){
            try {
                JSONObject obj = new JSONObject(str);
                String author = obj.getString("author");
                String book = obj.getString("book");
                context.write(new Text(author),new Text(book));
            } catch (JSONException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
