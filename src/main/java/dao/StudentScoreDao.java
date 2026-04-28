package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.Score;
import bean.School;
import bean.Student;
import bean.StudentScore;
import bean.Subject;

public class StudentScoreDao extends Dao {

    public StudentScore get(Student student) throws Exception {
        Connection connection = getConnection();
        PreparedStatement statement = null;
        StudentScore studentScore = new StudentScore();
        List<Score> scores = new ArrayList<>();

        try {
            statement = connection.prepareStatement(
                "select sc.*, s.name as subject_name from score sc " +
                "join subject s on sc.subject_cd = s.cd " +
                "where sc.student_no=? order by sc.subject_cd asc");
            statement.setString(1, student.getNo());
            ResultSet rSet = statement.executeQuery();

            int total = 0;
            int cnt = 0;
            while (rSet.next()) {
                Subject subject = new Subject();
                subject.setCd(rSet.getString("subject_cd"));
                subject.setName(rSet.getString("subject_name"));
                subject.setSchool(student.getSchool());

                Score score = new Score();
                score.setStudent(student);
                score.setSubject(subject);
                score.setPoint(rSet.getInt("point"));

                scores.add(score);
                total += score.getPoint();
                cnt++;
            }

            studentScore.setStudent(student);
            studentScore.setScores(scores);
            studentScore.setTotal(total);
            studentScore.setAverage(cnt > 0 ? (double) total / cnt : 0.0);

        } catch (Exception e) {
            throw e;
        } finally {
            if (statement != null) {
                try { statement.close(); } catch (SQLException sqle) { throw sqle; }
            }
            if (connection != null) {
                try { connection.close(); } catch (SQLException sqle) { throw sqle; }
            }
        }
        return studentScore;
    }

    public List<StudentScore> filter(School school, int entYear, String classNum) throws Exception {
        Connection connection = getConnection();
        PreparedStatement statement = null;
        List<StudentScore> list = new ArrayList<>();

        try {
            statement = connection.prepareStatement(
                "select st.no, st.name as student_name, " +
                "sc.subject_cd, sub.name as subject_name, sc.point " +
                "from student st " +
                "left join score sc on st.no = sc.student_no " +
                "left join subject sub on sc.subject_cd = sub.cd " +
                "where st.school_cd=? and st.ent_year=? and st.class_num=? " +
                "order by st.no asc, sc.subject_cd asc");
            statement.setString(1, school.getCd());
            statement.setInt(2, entYear);
            statement.setString(3, classNum);
            ResultSet rSet = statement.executeQuery();

            String currentNo = null;
            StudentScore current = null;
            List<Score> scores = null;
            int total = 0;
            int cnt = 0;

            while (rSet.next()) {
                String no = rSet.getString("no");
                if (!no.equals(currentNo)) {
                    if (current != null) {
                        current.setScores(scores);
                        current.setTotal(total);
                        current.setAverage(cnt > 0 ? (double) total / cnt : 0.0);
                        list.add(current);
                    }
                    Student student = new Student();
                    student.setNo(no);
                    student.setName(rSet.getString("student_name"));
                    student.setEntYear(entYear);
                    student.setClassNum(classNum);
                    student.setSchool(school);

                    current = new StudentScore();
                    current.setStudent(student);
                    scores = new ArrayList<>();
                    total = 0;
                    cnt = 0;
                    currentNo = no;
                }

                String subjectCd = rSet.getString("subject_cd");
                if (subjectCd != null) {
                    Subject subject = new Subject();
                    subject.setCd(subjectCd);
                    subject.setName(rSet.getString("subject_name"));
                    subject.setSchool(school);

                    Score score = new Score();
                    score.setStudent(current.getStudent());
                    score.setSubject(subject);
                    score.setPoint(rSet.getInt("point"));

                    scores.add(score);
                    total += score.getPoint();
                    cnt++;
                }
            }

            if (current != null) {
                current.setScores(scores);
                current.setTotal(total);
                current.setAverage(cnt > 0 ? (double) total / cnt : 0.0);
                list.add(current);
            }

        } catch (Exception e) {
            throw e;
        } finally {
            if (statement != null) {
                try { statement.close(); } catch (SQLException sqle) { throw sqle; }
            }
            if (connection != null) {
                try { connection.close(); } catch (SQLException sqle) { throw sqle; }
            }
        }
        return list;
    }
}