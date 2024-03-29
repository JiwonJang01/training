package com.bigdata.cctv;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

import java.io.IOException;

public class CctvMapper extends Mapper<Object, Text, CctvComparePair, Text> {
    private final static Text one = new Text();

    @Override
    protected void map(Object key, Text value, Mapper<Object, Text, CctvComparePair, Text>.Context context) throws IOException, InterruptedException {
        String[] strs = value.toString().split(","); // csv를 ,기준으로 분할
        String admin = strs[1];     // 관리 기관명 추출
        String purpose = strs[4];   // 설치 목적 추출

        CctvComparePair pair = new CctvComparePair(admin, purpose);
        one.set(purpose);

        context.write(pair, one);
    }
}
