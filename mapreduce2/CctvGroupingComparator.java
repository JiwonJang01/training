package com.bigdata.cctv;

import org.apache.hadoop.io.RawComparator;
import org.apache.hadoop.io.WritableComparable;
import org.apache.hadoop.io.WritableComparator;

public class CctvGroupingComparator extends WritableComparator {
    public CctvGroupingComparator() {
        super(CctvComparePair.class, true);
    }

    @Override
    public int compare(WritableComparable a, WritableComparable b) {
        CctvComparePair x = (CctvComparePair) a;
        CctvComparePair y = (CctvComparePair) b;

        return x.getAdmin().compareTo(y.getAdmin()); // 관리기관 별 구분
    }
}
