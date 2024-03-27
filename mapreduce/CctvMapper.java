package com.bigdata.cctv;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

import java.io.IOException;
/**
 * 맵리듀스에서 데이터를 분석하려면 라인단위로 데이터를 읽어서 \t를 이용해서 데이터를 분리하고 첫번째 인덱스의
 * 데이터를 선택
 */
public class CctvMapper extends Mapper<Object, Text, Text, IntWritable> {
    private final  static IntWritable one = new IntWritable(1);
    private Text word = new Text();

    @Override
    protected void map(Object key, Text value, Mapper<Object, Text, Text, IntWritable>.Context context) throws IOException, InterruptedException {
        // 관리기관명 추출
        String[] strs = value.toString().split(",");
        word.set(strs[1]);
        context.write(word,one);
    }
}
