package com.bigdata.cctv;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

import java.io.IOException;

public class CctvReducer extends Reducer<CctvComparePair, Text, Text, Text>  {
    // 출력하는 키와 값을 정리
    private Text outputKey = new Text();
    private Text outputValue = new Text();

    @Override
    protected void reduce(CctvComparePair key, Iterable<Text> values, Reducer<CctvComparePair, Text, Text, Text>.Context context) throws IOException, InterruptedException {

        int uniq = 0;
        int sum = 0;

        // 문자의 판별
        String previous = "";
        for (Text value : values) {

            String current = value.toString(); // 값의 문자열로

            if (!previous.equals(current)) {
                uniq++;
                previous = current;
            }

            sum++;
        }

        outputKey.set(key.getAdmin());
        outputValue.set(new StringBuffer().append(uniq).append("\t").append(sum).toString());

        context.write(outputKey, outputValue);
    }
}
