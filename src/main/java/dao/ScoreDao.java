package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.security.auth.Subject;

import bean.School;
import bean.Score;
import bean.Student;

public class ScoreDao extends Dao {

    public Score get(String studentNo, String subjectCd) throws Exception {
        Connection connection = getConnection();
        PreparedStatement statement = null;
        Score score = null;

        try {
            statement = connection.prepareStatement(
                "select * from score where student_no=? and subject_cd=?");
            statement.setString(1, studentNo);
            statement.setString(2, subjectCd);
            ResultSet rSet = statement.executeQuery();

            if (rSet.next()) {
                StudentDao studentDao = new StudentDao();
                SubjectDao subjectDao = new SubjectDao();
                score = new Score();
                score.setStudent(studentDao.get(rSet.getString("student_no")));
                score.setSubject(subjectDao.get(rSet.getString("subject_cd")));
                score.setPoint(rSet.getInt("point"));
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
        return score;
    }

    public List<Score> filterByStudent(Student student) throws Exception {
        Connection connection = getConnection();
        PreparedStatement statement = null;
        List<Score> list = new ArrayList<>();

        try {
            statement = connection.prepareStatement(
                "select * from score where student_no=? order by subject_cd asc");
            statement.setString(1, student.getNo());
            ResultSet rSet = statement.executeQuery();

            SubjectDao subjectDao = new SubjectDao();
            while (rSet.next()) {
                Score score = new Score();
                score.setStudent(student);
                score.setSubject(subjectDao.get(rSet.getString("subject_cd")));
                score.setPoint(rSet.getInt("point"));
                list.add(score);
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

    public List<Score> filterBySubject(Subject subject) throws Exception {
        Connection connection = getConnection();
        PreparedStatement statement = null;
        List<Score> list = new ArrayList<>();

        try {
            statement = connection.prepareStatement(
                "select * from score where subject_cd=? order by student_no asc");
            statement.setString(1, subject.getCd());
            ResultSet rSet = statement.executeQuery();

            StudentDao studentDao = new StudentDao();
            while (rSet.next()) {
                Score score = new Score();
                score.setStudent(studentDao.get(rSet.getString("student_no")));
                score.setSubject(subject);
                score.setPoint(rSet.getInt("point"));
                list.add(score);
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

    public List<Score> filterBySchool(School school) throws Exception {
        Connection connection = getConnection();
        PreparedStatement statement = null;
        List<Score> list = new ArrayList<>();

        try {
            statement = connection.prepareStatement(
                "select sc.* from score sc " +
                "join student st on sc.student_no = st.no " +
                "where st.school_cd=? " +
                "order by sc.student_no asc, sc.subject_cd asc");
            statement.setString(1, school.getCd());
            ResultSet rSet = statement.executeQuery();

            StudentDao studentDao = new StudentDao();
            SubjectDao subjectDao = new SubjectDao();
            while (rSet.next()) {
                Score score = new Score();
                score.setStudent(studentDao.get(rSet.getString("student_no")));
                score.setSubject(subjectDao.get(rSet.getString("subject_cd")));
                score.setPoint(rSet.getInt("point"));
                list.add(score);
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

    public boolean save(Score score) throws Exception {
        Connection connection = getConnection();
        PreparedStatement statement = null;
        int count = 0;

        try {
            Score old = get(score.getStudent().getNo(), score.getSubject().getCd());
            if (old == null) {
                statement = connection.prepareStatement(
                    "insert into score(student_no, subject_cd, point) values(?, ?, ?)");
                statement.setString(1, score.getStudent().getNo());
                statement.setString(2, score.getSubject().getCd());
                statement.setInt(3, score.getPoint());
            } else {
                statement = connection.prepareStatement(
                    "update score set point=? where student_no=? and subject_cd=?");
                statement.setInt(1, score.getPoint());
                statement.setString(2, score.getStudent().getNo());
                statement.setString(3, score.getSubject().getCd());
            }
            count = statement.executeUpdate();
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
        return count > 0;
    }
}