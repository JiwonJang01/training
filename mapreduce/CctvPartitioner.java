package com.bigdata.cctv;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Partitioner;

/**
 * 리듀서의 키를 기준으로 정렬해서 건수 확인
 * 매퍼의 결과는 리듀서로 전달할 때 셔플&정렬과정을 거친다
 * 기본 파티셔너는 내장된 해쉬파티셔너
 * 기본을 우리가 원하는 기준으로 정렬하기 위해서
 * 리듀서의 개수를 하나로 해야함
 */
public class CctvPartitioner extends Partitioner<Text, IntWritable> {
    /*
     * @param text
     * @param intWritable
     * @param i
     * @return
     */
    // 기관명 기준으로 정렬 : return (text.toString().charAt(0) % i);
    // 값을 기준으로 정렬 : return (intWritable.get() % i); 오름차순
    // 값을 기준으로 정렬 : return (-intWritable.get() % i); 내림차순
    // text : key
    // intWritable.get() : value
    @Override
    public int getPartition(Text text, IntWritable intWritable, int i) {
        return (-intWritable.get() % i); // 파티션 번호를 리듀스 테스트의 수로 나누어 확장
        // 나머지 값을 파티션 번호, 첫번쨰 문자가 같은 키들은 같은 파티션 번호를 가짐
    }
}
