/*
 * Copyright (c) 2018. Phasmid Software
 */

package edu.neu.coe.info6205.util;

import edu.neu.coe.info6205.sort.simple.InsertionSort;
import edu.neu.coe.info6205.sort.simple.SelectionSort;
//import edu.neu.coe.info6205.sort.simple.ShellSort;
import edu.neu.coe.info6205.sort.simple.Sort;

import java.util.Random;
import java.util.function.Function;

/**
 * @param <T> The generic type T is that of the input to the function f which you will pass in to the constructor.
 */
public class Benchmark<T> {
	
	private static Integer[] random_Array = new Integer[1000];
	private static Integer[] reverse_Array = new Integer[1000];
	private static Integer[] order_Array = new Integer[1000];
	private static Random rd = new Random();
    /**
     * Constructor for a Benchmark.
     * @param f a function of T => Void.
     * Function f is the function whose timing you want to measure. For example, you might create a function which sorts an array.
     * When you create a lambda defining f, you must return "null."
     */
    public Benchmark(Function<T, Void> f) {
        this.f = f;
    }

    /**
     * Run function f m times and return the average time in milliseconds.
     * @param t the value that will in turn be passed to function f.
     * @param m the number of times the function f will be called.
     * @return the average number of milliseconds taken for each run of function f.
     */
    public double run(T t, int m) {
       int i = 0;
       long time1 = System.nanoTime();
  
       while(i < m) {
    	popArray(random_Array,reverse_Array,order_Array);
    	f.apply(t);
    	   i++;
    	  
       }
       long time2 = System.nanoTime();

    	double rt = (double)((time2-time1)/(m));
    	//System.out.println("The time is: "+ rt/1000000);
       return rt/1000000;  
    }

    private final Function<T, Void> f;

    /**
     * Everything below this point has to do with a particular example of running a Benchmark.
     * In this case, we time three types of simple sort on a randome integer array of length 1000.
     * Each test is run 200 times.
     * @param args the command-line arguments, of which none are significant.
     */
    public static void main(String[] args) {
        Random random = new Random();
        int m = 100; // This is the number of repetitions: sufficient to give a good mean value of timing
        // TODO You need to apply doubling to n
        int n = 1000; // This is the size of the array
        
        for(int e = 0; e<n; e++) {
        	popArray(random_Array,reverse_Array,order_Array);
        	
        	System.out.println("RANDOM array , Selection sort");
        	benchmarkSort(random_Array, "SelectionSort",new SelectionSort<Integer>(), m);
        	
        	System.out.println("RANDOM array , Insertion sort");
        	

        	benchmarkSort(random_Array, "InsertionSort", new InsertionSort<Integer>(), m);
        	System.out.println(" ");
        	
        	System.out.println("REVERSE array , Selection sort");

        	benchmarkSort(reverse_Array, "SelectionSort", new SelectionSort<Integer>(), m);
        	
        	System.out.println("REVERSE array , Insertion sort");

        	benchmarkSort(reverse_Array, "InsertionSort", new InsertionSort<Integer>(), m);
        	System.out.println(" ");
        	
        	System.out.println("ORDER array , Selection sort");

        	benchmarkSort(order_Array, "SelectionSort", new SelectionSort<Integer>(), m);
        	
        	System.out.println("ORDER array , Insertion sort");

        	benchmarkSort(order_Array, "InsertionSort", new InsertionSort<Integer>(), m);
        	System.out.println(" ");
        	
        }

        for (int k = 0; k< 5; k++) {
            Integer[] array = new Integer[n];
            for (int i = 0; i < n; i++) array[i] = random.nextInt();
            benchmarkSort(array, "InsertionSort: "+n, new InsertionSort<>(), m);
            benchmarkSort(array, "SelectionSort: "+n, new SelectionSort<>(), m);
//        benchmarkSort(array, "ShellSort    ", new ShellSort<>(3), m);
            n = n * 2;
        }
    }

    private static void benchmarkSort(Integer[] array, String name, Sort<Integer> sorter, int m) {
        Function<Integer[], Void> sortFunction = (xs) -> {
            sorter.sort(xs);
            return null;
        };
        Benchmark<Integer[]> bm = new Benchmark<>(sortFunction);
        double x = bm.run(array, m);
        System.out.println(name + ": " + x + " millisecs");
    }
    private static void popArray(Integer[] random_Array,Integer[] reverse_Array,Integer[] order_Array) {
    	for(int i =0; i< 1000; i++) {
    		order_Array[i] = i;
    		reverse_Array[i] = 1000-i;
    		random_Array[i] = rd.nextInt(10);
    	}
    	
    }
}
