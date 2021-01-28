package ga.alg;

import java.util.Arrays;
import java.util.Random;

import ga.dao.Generation;
import ga.dao.Point;

public class Init {

	private Point[][] population;
	private Generation generation;
	private int sizeOfPop;
	private int sizeOfChro;
	private int xMax;
	private int yMax;
	
	
	public Init(int sizeOfPop, int sizeOfChro, int xMax, int yMax, Point[] ps) {
		super();
		this.sizeOfPop = sizeOfPop;
		this.sizeOfChro = sizeOfChro;
		this.xMax = xMax;
		this.yMax = yMax;
		produceGen(ps);
	}
	
	private Generation produceGen(Point[] ps){
		population = new Point[sizeOfPop][sizeOfChro];
		Random random = new Random();
		for (int i = 0; i < sizeOfPop; i++) {
			for (int j = 0; j < sizeOfChro; j++) {
				population[i][j] = new Point(random.nextInt(xMax), random.nextInt(yMax));
				
			}
//			Arrays.sort(population[i]);
		}
		generation = new Generation(population,ps);
		return generation;
	}

	public Point[][] getPopulation() {
		return population;
	}

	public Generation getGeneration() {
		return generation;
	}
}
