package com.bigdata.cctv;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

/**
 * job
 * job 함수는 작업에 관련된 정보를 전달, 매퍼,리듀서, 컴파이너를 설정하고 출력 데이터 타입을 설정
 * FileInputFormat에 입력, 출력 정보를 지정
 */
public class CctvMain {
    public static void main(String[] args) throws Exception{
        Configuration conf = new Configuration();

        Job job = Job.getInstance(conf, "cctv");
        job.setJarByClass(CctvMain.class);

        // 매퍼 리듀서
        job.setMapperClass(CctvMapper.class);
        job.setReducerClass(CctvReducer.class);

        // 파티셔너, 소트, 그룹핑
        job.setPartitionerClass(CctvPartitioner.class);
        job.setSortComparatorClass(CctvSortComparator.class);
        job.setGroupingComparatorClass(CctvGroupingComparator.class);

        // 맵의 출력
        job.setMapOutputKeyClass(CctvComparePair.class);
        job.setMapOutputValueClass(Text.class);
        // 리듀서의 출력
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);

        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));

        System.exit(job.waitForCompletion(true) ? 0 : 1);   // ? 0 : 1는 없어도 됨
    }
}










