package com.bigdata.cctv;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Partitioner;

public class CctvPartitioner extends Partitioner<CctvComparePair, Text>  {
    @Override
    public int getPartition(CctvComparePair key, Text text, int numPartitions) {
        return (key.getAdmin().charAt(0)) % numPartitions;
    }
}
