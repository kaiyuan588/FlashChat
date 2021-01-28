package edu.neu.coe.info6205.sort.simple;

import static edu.neu.coe.info6205.sort.simple.Helper.less;
import static edu.neu.coe.info6205.sort.simple.Helper.swap;

public class SelectionSort<X extends Comparable<X>> extends Helper<X>implements Sort<X> {

    @Override
    public void sort(X[] xs, int from, int to) {
        // TODO implement selection sort

    	for(int i = from; i < to; i++) {
			int min = i;
			for(int j = i+1; j < to; j++) {
				if(less(xs[j], xs[min])) {
					min = j;
				}
				swap1(xs ,i ,min);
			}
		}
    	
    	
    }


}
