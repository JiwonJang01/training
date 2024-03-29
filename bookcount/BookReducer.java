package com.bigdata.cctv;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import java.io.IOException;
import java.io.StringWriter;

/**
 * combiner 역할도 포함
 */

public class BookReducer extends Reducer<Text, Text, NullWritable, Text> {

    @Override
    protected void reduce(Text key, Iterable<Text> values, Reducer<Text, Text, NullWritable, IntWritable>.Context context) throws IOException, InterruptedException {
        JSONObject obj = new JSONObject();
        JSONArray ja = new JSONArray();
        try {
            for (Text val:values) {
                JSONObject jo = new JSONObject().put("book", val.toString());
                ja.put(jo);
            }
            obj.put("books",ja);
            obj.put("author",key.toString());
            context.write(NullWritable.get(), new Text(obj.toString()));
        } catch (JSONException e) {
                throw new RuntimeException(e);
        }
    }
}
