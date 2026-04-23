package bean;

import java.io.Serializable;

public class ClassScore implements Serializable {

    private Subject subject;
    private double average;
    private int max;
    private int min;

    public Subject getSubject() { return subject; }
    public void setSubject(Subject subject) { this.subject = subject; }

    public double getAverage() { return average; }
    public void setAverage(double average) { this.average = average; }

    public int getMax() { return max; }
    public void setMax(int max) { this.max = max; }

    public int getMin() { return min; }
    public void setMin(int min) { this.min = min; }
}