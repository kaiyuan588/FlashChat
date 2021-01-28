package edu.neu.coe.info6205.sort.simple;

/**
 * Helper class for sorting methods.
 * @param <X>
 */
public class Helper<X extends Comparable<X>> implements Sort<X>{
	public void sort(X[] a, int from, int to) {} 
    /**
     * Method to determine if one X value is less than another.
     * @param v the candidate element.
     * @param w the comparand element.
     * @param <X> the underlying type (must be Comparable).
     * @return true only if v is less than w.
     */
    static <X extends Comparable<X>> boolean less(X v, X w) {
        return v.compareTo(w) < 0;
    }
 
    /**
     * Swap the elements of array a at indices i and j.
     * @param a the array.
     * @param lo the lowest index of interest (only used for checking).
     * @param hi one more than the highest index of interest (only used for checking).
     * @param i one of the indices.
     * @param j the other index.
     * @param <X> the type of the elements (must be Comparable).
     */
    
    static <X extends Comparable<X>> void swap(X[] a, int lo, int hi, int i, int j) {
        if (i<lo) throw new RuntimeException("i is out of range: i; "+i+"; lo="+lo);
        if (j>hi) throw new RuntimeException("j is out of range: j; "+j+"; hi="+hi);
        X temp = a[i];
        a[i] = a[j];
        a[j] = temp;
    }
	public void swap1(X[] xs, int i, int j) {
		X t = xs[i];
		xs[i] = xs[j];
		xs[j]= t;
		
	}
}
