package edu.neu.coe.StudentRank.solution;

import edu.neu.coe.StudentRank.Student;

public class StudentRankSolution {
	Student[] roster;
	int size;
	
    public StudentRankSolution(int n) {
		super();
		roster = new Student[n];
		size = 0;
	}
    
    public Student[] getRoster() {
		return roster;
	}

	public void addStudent(Student s) {
    		roster[size++] = s;
    }
    
    public void rankStudents() {
    		sort(roster);
    }
    
    public void sort(Student[] roster) {
    		//TODO Implement insertion sort that sorts the students based on GPA from highest to lowest
    	int size = roster.length;
    	for(int i=0;i<size;i++){
    		for(int j=i; j>0 && higher(roster[j],roster[j-1]);j-- ){
    			exchange(roster, j, j-1);
    		}
    	}
    	
    }
    
    public static boolean higher(Student s1, Student s2) {
    		//TODO Implement the higher() function used by your sort method. Hint: it should use the Student class's compareTo() method
		return s1.compareTo(s2)>0;
	}
    
    private void exchange(Student[] array, int i, int j) {
    		Student s = array[i];
    		array[i] = array[j];
    		array[j] = s;
    }

}
