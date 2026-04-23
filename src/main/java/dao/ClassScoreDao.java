package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.security.auth.Subject;

import bean.ClassScore;
import bean.School;

public class ClassScoreDao extends Dao {

    public List<ClassScore> filter(School school, int entYear, String classNum) throws Exception {
        Connection connection = getConnection();
        PreparedStatement statement = null;
        List<ClassScore> list = new ArrayList<>();

        try {
            statement = connection.prepareStatement(
                "select sub.cd, sub.name as subject_name, " +
                "avg(sc.point) as avg_point, " +
                "max(sc.point) as max_point, " +
                "min(sc.point) as min_point " +
                "from score sc " +
                "join student st on sc.student_no = st.no " +
                "join subject sub on sc.subject_cd = sub.cd " +
                "where st.school_cd=? and st.ent_year=? and st.class_num=? " +
                "group by sub.cd, sub.name " +
                "order by sub.cd asc");
            statement.setString(1, school.getCd());
            statement.setInt(2, entYear);
            statement.setString(3, classNum);
            ResultSet rSet = statement.executeQuery();

            while (rSet.next()) {
                Subject subject = new Subject();
                subject.setCd(rSet.getString("cd"));
                subject.setName(rSet.getString("subject_name"));
                subject.setSchool(school);

                ClassScore classScore = new ClassScore();
                classScore.setSubject(subject);
                classScore.setAverage(rSet.getDouble("avg_point"));
                classScore.setMax(rSet.getInt("max_point"));
                classScore.setMin(rSet.getInt("min_point"));

                list.add(classScore);
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

    public List<ClassScore> filterBySchool(School school) throws Exception {
        Connection connection = getConnection();
        PreparedStatement statement = null;
        List<ClassScore> list = new ArrayList<>();

        try {
            statement = connection.prepareStatement(
                "select sub.cd, sub.name as subject_name, " +
                "avg(sc.point) as avg_point, " +
                "max(sc.point) as max_point, " +
                "min(sc.point) as min_point " +
                "from score sc " +
                "join student st on sc.student_no = st.no " +
                "join subject sub on sc.subject_cd = sub.cd " +
                "where st.school_cd=? " +
                "group by sub.cd, sub.name " +
                "order by sub.cd asc");
            statement.setString(1, school.getCd());
            ResultSet rSet = statement.executeQuery();

            while (rSet.next()) {
                Subject subject = new Subject();
                subject.setCd(rSet.getString("cd"));
                subject.setName(rSet.getString("subject_name"));
                subject.setSchool(school);

                ClassScore classScore = new ClassScore();
                classScore.setSubject(subject);
                classScore.setAverage(rSet.getDouble("avg_point"));
                classScore.setMax(rSet.getInt("max_point"));
                classScore.setMin(rSet.getInt("min_point"));

                list.add(classScore);
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