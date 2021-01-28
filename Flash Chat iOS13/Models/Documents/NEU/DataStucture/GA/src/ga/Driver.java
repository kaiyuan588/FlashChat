package ga;

import java.io.BufferedWriter;
import java.io.FileWriter;

import ga.dao.*;
import ga.graph.*;
import ga.alg.*;


public class Driver {

	public static void main(String[] args) {
		long start = System.currentTimeMillis();
		try {
			Readimage ri = new Readimage(20);
			Point[] ps = ri.getImagePixelToArray("resource/333.png");
			ri.writeImage(ps,"resource/example.png");
			ga(ps, ri);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		long end = System.currentTimeMillis();
		System.out.println(end - start);
	}

	public static void write(Point[] ps, Point[][] firstGen) throws Exception {		
		
		String fileName = "resource/write.txt";
		BufferedWriter out = new BufferedWriter(new FileWriter(fileName));
		out.write("Target :\n");
		for (Point p : ps) {
			out.write(p.toString());
			out.newLine();
		}
		out.write("First Generation:\n");
		for (int i = 0; i < firstGen.length; i++) {
			out.write(i + "th population: \n");
			for (int j = 0; j < firstGen[i].length; j++) {
				out.write(firstGen[i][j].toString());
				out.newLine();
			}
		}
		out.close();
	}
	
	public static void ga(Point[] ps, Readimage ri) {
		Init init = new Init(1000, ps.length, ri.getWidth(), ri.getHeight(), ps);
		Generation gen = init.getGeneration();
		for (int i = 0; i < 20000; i++) {
			Survive.execute(gen);
			byte[][][] child = Breed.execute(gen);
			gen.clear();
			gen = null;
			gen = new Generation(child,ps);
			child = null;
			if(i%99==0) {
				String fileN = "resource/t"+i+".png";
				ri.writeImage(gen.max(), fileN);
			}
		}
		Point[][] generation = gen.getPopulation();
		double[] firrank = Rank.adapt(ps, generation);
		for (int i = 0; i < firrank.length; i++) {
			System.out.println(firrank[i]);
		}
		System.out.println(Fitness.calDis(ps, gen.max()));
		System.out.println(gen.getPopulation().length);
		System.out.println(generation[0]==generation[1]);
		ri.writeImage(gen.max(), "resource/result.png");
	}
}
