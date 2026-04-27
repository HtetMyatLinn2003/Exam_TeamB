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

    /**
     * IDで科目を1件取得する
     */
    public Subject get(int id) throws Exception {
        Subject subject = null;
        Connection connection = getConnection();
        PreparedStatement statement = null;

        try {
            statement = connection.prepareStatement(
                "SELECT * FROM subject WHERE id=?");
            statement.setInt(1, id);
            ResultSet rSet = statement.executeQuery();

            SchoolDao schoolDao = new SchoolDao();
            if (rSet.next()) {
                subject = new Subject();
                subject.setId(rSet.getInt("id"));
                subject.setName(rSet.getString("name"));
                subject.setSchool(schoolDao.get(rSet.getString("school_cd")));
            }
        } catch (Exception e) {
            throw e;
        } finally {
            close(statement, connection);
        }

        return subject;
    }

    /**
     * 学校で絞り込んだ科目一覧を取得する
     */
    public List<Subject> filter(School school) throws Exception {
        List<Subject> list = new ArrayList<>();
        Connection connection = getConnection();
        PreparedStatement statement = null;

        try {
            statement = connection.prepareStatement(
                "SELECT * FROM subject WHERE school_cd=? ORDER BY name");
            statement.setString(1, school.getCd());
            ResultSet rSet = statement.executeQuery();

            SchoolDao schoolDao = new SchoolDao();
            while (rSet.next()) {
                Subject subject = new Subject();
                subject.setId(rSet.getInt("id"));
                subject.setName(rSet.getString("name"));
                subject.setSchool(schoolDao.get(rSet.getString("school_cd")));
                list.add(subject);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            close(statement, connection);
        }

        return list;
    }

    /**
     * 科目を保存（INSERT or UPDATE）する
     */
    public boolean save(Subject subject) throws Exception {
        Connection connection = getConnection();
        PreparedStatement statement = null;
        int count = 0;

        try {
            Subject old = get(subject.getId());
            if (old == null) {
                statement = connection.prepareStatement(
                    "INSERT INTO subject(name, school_cd) VALUES(?, ?)");
                statement.setString(1, subject.getName());
                statement.setString(2, subject.getSchool().getCd());
            } else {
                statement = connection.prepareStatement(
                    "UPDATE subject SET name=?, school_cd=? WHERE id=?");
                statement.setString(1, subject.getName());
                statement.setString(2, subject.getSchool().getCd());
                statement.setInt(3, subject.getId());
            }
            count = statement.executeUpdate();
        } catch (Exception e) {
            throw e;
        } finally {
            close(statement, connection);
        }

        return count > 0;
    }

    /**
     * 科目を削除する
     */
    public boolean delete(int id) throws Exception {
        Connection connection = getConnection();
        PreparedStatement statement = null;
        int count = 0;

        try {
            statement = connection.prepareStatement("DELETE FROM subject WHERE id=?");
            statement.setInt(1, id);
            count = statement.executeUpdate();
        } catch (Exception e) {
            throw e;
        } finally {
            close(statement, connection);
        }

        return count > 0;
    }

    private void close(PreparedStatement statement, Connection connection) throws SQLException {
        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException sqle) {
                throw sqle;
            }
        }
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException sqle) {
                throw sqle;
            }
        }
    }
}
