package bean;

import java.io.Serializable;

public class Test implements Serializable {

    private String studentNo;
    private String subjectCd;
    private String schoolCd;
    private int no;
    private Integer point;
    private String classNum;

    // 表示用（JOIN結果・成績管理一覧用）
    private String studentName;
    private String subjectName;
    private int entYear;

    public String getStudentNo() { return studentNo; }
    public void setStudentNo(String studentNo) { this.studentNo = studentNo; }

    public String getSubjectCd() { return subjectCd; }
    public void setSubjectCd(String subjectCd) { this.subjectCd = subjectCd; }

    public String getSchoolCd() { return schoolCd; }
    public void setSchoolCd(String schoolCd) { this.schoolCd = schoolCd; }

    public int getNo() { return no; }
    public void setNo(int no) { this.no = no; }

    public Integer getPoint() { return point; }
    public void setPoint(Integer point) { this.point = point; }

    public String getClassNum() { return classNum; }
    public void setClassNum(String classNum) { this.classNum = classNum; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public String getSubjectName() { return subjectName; }
    public void setSubjectName(String subjectName) { this.subjectName = subjectName; }

    public int getEntYear() { return entYear; }
    public void setEntYear(int entYear) { this.entYear = entYear; }
}