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

    public Subject get(String cd, String schoolCd) throws Exception {
        Subject subject = null;
        Connection connection = getConnection();
        PreparedStatement statement = null;

        try {
            statement = connection.prepareStatement(
                "SELECT * FROM subject WHERE TRIM(cd)=? AND school_cd=?");
            statement.setString(1, cd != null ? cd.trim() : null);
            statement.setString(2, schoolCd);
            ResultSet rSet = statement.executeQuery();

            SchoolDao schoolDao = new SchoolDao();
            if (rSet.next()) {
                subject = new Subject();
                subject.setCd(rSet.getString("cd"));
                subject.setName(rSet.getString("name"));
                subject.setSchool(schoolDao.get(rSet.getString("school_cd")));
            }
        } finally {
            close(statement, connection);
        }

        return subject;
    }

    public List<Subject> filter(School school) throws Exception {
        List<Subject> list = new ArrayList<>();
        Connection connection = getConnection();
        PreparedStatement statement = null;

        try {
            statement = connection.prepareStatement(
                "SELECT * FROM subject WHERE school_cd=? ORDER BY cd");
            statement.setString(1, school.getCd());
            ResultSet rSet = statement.executeQuery();

            SchoolDao schoolDao = new SchoolDao();
            while (rSet.next()) {
                Subject subject = new Subject();
                subject.setCd(rSet.getString("cd"));
                subject.setName(rSet.getString("name"));
                subject.setSchool(schoolDao.get(rSet.getString("school_cd")));
                list.add(subject);
            }
        } finally {
            close(statement, connection);
        }

        return list;
    }

    public boolean save(Subject subject) throws Exception {
        Connection connection = getConnection();
        PreparedStatement statement = null;
        int count = 0;

        try {
            Subject old = get(subject.getCd(), subject.getSchool().getCd());
            if (old == null) {
                statement = connection.prepareStatement(
                    "INSERT INTO subject(cd, name, school_cd) VALUES(?, ?, ?)");
                statement.setString(1, subject.getCd());
                statement.setString(2, subject.getName());
                statement.setString(3, subject.getSchool().getCd());
            } else {
                statement = connection.prepareStatement(
                    "UPDATE subject SET name=? WHERE cd=? AND school_cd=?");
                statement.setString(1, subject.getName());
                statement.setString(2, subject.getCd());
                statement.setString(3, subject.getSchool().getCd());
            }
            count = statement.executeUpdate();
        } finally {
            close(statement, connection);
        }

        return count > 0;
    }

    public boolean delete(String cd, String schoolCd) throws Exception {
        Connection connection = getConnection();
        PreparedStatement statement = null;
        int count = 0;

        try {
            statement = connection.prepareStatement(
                "DELETE FROM subject WHERE TRIM(cd)=? AND school_cd=?");
            statement.setString(1, cd != null ? cd.trim() : null);
            statement.setString(2, schoolCd);
            count = statement.executeUpdate();
        } finally {
            close(statement, connection);
        }

        return count > 0;
    }

    private void close(PreparedStatement statement, Connection connection) throws SQLException {
        if (statement != null) {
            try { statement.close(); } catch (SQLException e) { throw e; }
        }
        if (connection != null) {
            try { connection.close(); } catch (SQLException e) { throw e; }
        }
    }
}