package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Subject;

public class SubjectDao extends Dao {

    public Subject get(String cd) throws Exception {
        Connection connection = getConnection();
        PreparedStatement statement = null;
        Subject subject = null;

        try {
            statement = connection.prepareStatement(
                "select * from subject where cd=?");
            statement.setString(1, cd);
            ResultSet rSet = statement.executeQuery();

            if (rSet.next()) {
                SchoolDao schoolDao = new SchoolDao();
                subject = new Subject();
                subject.setCd(rSet.getString("cd"));
                subject.setName(rSet.getString("name"));
                subject.setSchool(schoolDao.get(rSet.getString("school_cd")));
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
        return subject;
    }

    public List<Subject> filter(School school) throws Exception {
        Connection connection = getConnection();
        PreparedStatement statement = null;
        List<Subject> list = new ArrayList<>();

        try {
            statement = connection.prepareStatement(
                "select * from subject where school_cd=? order by cd asc");
            statement.setString(1, school.getCd());
            ResultSet rSet = statement.executeQuery();

            while (rSet.next()) {
                Subject subject = new Subject();
                subject.setCd(rSet.getString("cd"));
                subject.setName(rSet.getString("name"));
                subject.setSchool(school);
                list.add(subject);
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

    public boolean save(Subject subject) throws Exception {
        Connection connection = getConnection();
        PreparedStatement statement = null;
        int count = 0;

        try {
            Subject old = get(subject.getCd());
            if (old == null) {
                statement = connection.prepareStatement(
                    "insert into subject(cd, name, school_cd) values(?, ?, ?)");
                statement.setString(1, subject.getCd());
                statement.setString(2, subject.getName());
                statement.setString(3, subject.getSchool().getCd());
            } else {
                statement = connection.prepareStatement(
                    "update subject set name=? where cd=?");
                statement.setString(1, subject.getName());
                statement.setString(2, subject.getCd());
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