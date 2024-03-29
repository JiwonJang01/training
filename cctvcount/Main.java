package com.bigdata.cctv;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class Main {
    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        Job job = Job.getInstance(conf,"cctv_popuse");
        job.setJarByClass(Main.class);

        // Mapper
        job.setMapperClass(CctvMapper.class);
        // combiner
        job.setCombinerClass(CctvReducer.class);
        // reducer
        job.setReducerClass(CctvReducer.class);

        // setoutputkey
        job.setOutputKeyClass(Text.class);
        // setoutputvaluseclass
        job.setOutputValueClass(IntWritable.class);

        // fileinputformat
        FileInputFormat.addInputPath(job,new Path(args[0]));
        // fileoutputformat
        FileOutputFormat.setOutputPath(job,new Path(args[1]));

        job.waitForCompletion(true);
    }
}
