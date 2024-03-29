package com.bigdata.cctv;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

import java.io.IOException;

public class CctvMapper extends Mapper<Object, Text, Text, IntWritable> {
    private  Text word = new Text();
    private final IntWritable wr = new IntWritable(1);

    @Override
    protected void map(Object key, Text value, Mapper<Object, Text, Text, IntWritable>.Context context) throws IOException, InterruptedException {
        // 데이터 추출
        String[] strs = value.toString().split(",");
        word.set(strs[4]);
        context.write(word,wr);
    }

}
