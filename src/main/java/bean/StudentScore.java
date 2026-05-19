package bean;

import java.io.Serializable;
import java.util.List;

public class StudentScore implements Serializable {

    private Student student;
    private List<Score> scores;
    private double average;
    private int total;

    public Student getStudent() { return student; }
    public void setStudent(Student student) { this.student = student; }

    public List<Score> getScores() { return scores; }
    public void setScores(List<Score> scores) { this.scores = scores; }

    public double getAverage() { return average; }
    public void setAverage(double average) { this.average = average; }

    public int getTotal() { return total; }
    public void setTotal(int total) { this.total = total; }
}