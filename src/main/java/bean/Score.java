package bean;

import java.io.Serializable;

public class Score implements Serializable {

    private Student student;
    private Subject subject;
    private int point;

    public Student getStudent() { return student; }
    public void setStudent(Student student) { this.student = student; }

    public Subject getSubject() { return subject; }
    public void setSubject(Subject subject) { this.subject = subject; }

    public int getPoint() { return point; }
    public void setPoint(int point) { this.point = point; }
}