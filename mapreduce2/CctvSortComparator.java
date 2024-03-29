package com.bigdata.cctv;

import org.apache.hadoop.io.RawComparator;
import org.apache.hadoop.io.WritableComparable;
import org.apache.hadoop.io.WritableComparator;

public class CctvSortComparator extends WritableComparator {
    public CctvSortComparator() {
        super(CctvComparePair.class, true);
    }

    @Override
    public int compare(WritableComparable a, WritableComparable b) {
        CctvComparePair x = (CctvComparePair) a;
        CctvComparePair y = (CctvComparePair) b;

        return x.compareTo(y);
    }
}
