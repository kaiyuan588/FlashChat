package ga.alg;

import ga.dao.Point;

public class Fitness {
	
	/**
	 * To calculate fitness
	 * @param individual an individual's information
	 * @return fitness
	 */
	public static double calculate(Point[] ps,Point[] individual) {
		double distance = 0;
		for (int i = 0; i < individual.length; i++) {
			distance += Point.distance(ps[i], individual[i]);
//			distance += ps[i].distance(individual[i]);
		}
		return 10000/distance;
	}
	
	public static double calDis(Point[] ps,Point[] individual) {
		double distance = 0;
		for (int i = 0; i < individual.length; i++) {
			distance += Point.distance(ps[i], individual[i]);
//			distance += ps[i].distance(individual[i]);
		}
		return distance;
	}

}
