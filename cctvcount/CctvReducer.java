package com.bigdata.cctv;

import com.fasterxml.jackson.core.TreeNode;
import com.google.inject.Key;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

import java.io.IOException;

/**
 * combiner 역할도 포함
 */

public class CctvReducer extends Reducer<Text, IntWritable, Text, IntWritable> {
    private IntWritable iw = new IntWritable();
    @Override
    protected void reduce(Text key, Iterable<IntWritable> values, Reducer<Text, IntWritable, Text, IntWritable>.Context context) throws IOException, InterruptedException {
        int sum = 0;

        for (IntWritable value : values)
            sum += value.get();

        iw.set(sum);
        context.write(key, iw);
    }
}
