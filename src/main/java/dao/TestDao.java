package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Test;

public class TestDao extends Dao {

	public Test get(String studentNo, String subjectCd, String schoolCd, int no) throws Exception {
		Test test = null;
		Connection connection = getConnection();
		PreparedStatement statement = null;
		try {
			statement = connection.prepareStatement(
					"select t.*, s.name as student_name, s.ent_year as ent_year," +
							" sub.name as subject_name" +
							" from test t" +
							" left join student s on t.student_no = s.no" +
							" left join subject sub on t.subject_cd = sub.cd and t.school_cd = sub.school_cd" +
							" where t.student_no=? and t.subject_cd=? and t.school_cd=? and t.no=?");
			statement.setString(1, studentNo);
			statement.setString(2, subjectCd);
			statement.setString(3, schoolCd);
			statement.setInt(4, no);
			ResultSet rSet = statement.executeQuery();
			if (rSet.next()) {
				test = mapRow(rSet);
			}
		} catch (Exception e) {
			throw e;
		} finally {
			close(statement, connection);
		}
		return test;
	}

	/** 存在しない場合 null を返す（エラーを出さない） */
	public Test getOrNull(String studentNo, String subjectCd, String schoolCd, int no) {
		try {
			return get(studentNo, subjectCd, schoolCd, no);
		} catch (Exception e) {
			return null;
		}
	}

	/** 学生別成績一覧（点数があるもののみ） */
	public List<Test> filterByStudent(String studentNo, School school) throws Exception {
		List<Test> list = new ArrayList<>();
		Connection connection = getConnection();
		PreparedStatement statement = null;
		try {
			statement = connection.prepareStatement(
					"select t.*, s.name as student_name, s.ent_year as ent_year," +
							" sub.name as subject_name" +
							" from test t" +
							" left join student s on t.student_no = s.no" +
							" left join subject sub on t.subject_cd = sub.cd and t.school_cd = sub.school_cd" +
							" where t.student_no=? and t.school_cd=? and t.point is not null" +
							" order by t.subject_cd asc, t.no asc");
			statement.setString(1, studentNo);
			statement.setString(2, school.getCd());
			ResultSet rSet = statement.executeQuery();
			while (rSet.next()) {
				list.add(mapRow(rSet));
			}
		} catch (Exception e) {
			throw e;
		} finally {
			close(statement, connection);
		}
		return list;
	}

	/** 科目別成績一覧 */
	public List<Test> filterBySubjectAndClass(
			int entYear,
			String subjectCd,
			String classNum,
			School school) throws Exception {

		List<Test> list = new ArrayList<>();

		Connection connection = getConnection();

		PreparedStatement statement = null;

		try {

			String sql = "select t.*, " +
					" s.name as student_name, " +
					" s.ent_year as ent_year, " +
					" sub.name as subject_name " +

					"from test t " +

					"left join student s " +
					"on t.student_no = s.no " +

					"left join subject sub " +
					"on t.subject_cd = sub.cd " +
					"and t.school_cd = sub.school_cd " +

					"where t.subject_cd=? " +
					"and t.school_cd=? " +
					"and s.ent_year=? ";

			// クラス条件
			if (classNum != null
					&& !classNum.isEmpty()
					&& !classNum.equals("0")) {

				sql += "and s.class_num=? ";
			}

			sql += "order by t.student_no asc, t.no asc";

			statement = connection.prepareStatement(sql);

			statement.setString(1, subjectCd);

			statement.setString(
					2,
					school.getCd());

			statement.setInt(3, entYear);

			// クラス条件
			if (classNum != null
					&& !classNum.isEmpty()
					&& !classNum.equals("0")) {

				statement.setString(4, classNum);
			}

			ResultSet rSet = statement.executeQuery();

			while (rSet.next()) {

				list.add(mapRow(rSet));
			}

		} catch (Exception e) {

			throw e;

		} finally {

			close(statement, connection);
		}

		return list;
	}

	/** 登録（no を指定して INSERT） */
	public boolean saveWithNo(Test test) throws Exception {
		Connection connection = getConnection();
		PreparedStatement statement = null;
		int count = 0;
		try {
			statement = connection.prepareStatement(
					"insert into test(student_no, subject_cd, school_cd, no, point, class_num)" +
							" values(?, ?, ?, ?, ?, ?)");
			statement.setString(1, test.getStudentNo());
			statement.setString(2, test.getSubjectCd());
			statement.setString(3, test.getSchoolCd());
			statement.setInt(4, test.getNo());
			statement.setObject(5, test.getPoint());
			statement.setString(6, test.getClassNum());
			count = statement.executeUpdate();
		} catch (Exception e) {
			throw e;
		} finally {
			close(statement, connection);
		}
		return count > 0;
	}

	/** 得点更新 */
	public boolean update(Test test) throws Exception {
		Connection connection = getConnection();
		PreparedStatement statement = null;
		int count = 0;
		try {
			statement = connection.prepareStatement(
					"update test set point=? where student_no=? and subject_cd=? and school_cd=? and no=?");
			statement.setObject(1, test.getPoint());
			statement.setString(2, test.getStudentNo());
			statement.setString(3, test.getSubjectCd());
			statement.setString(4, test.getSchoolCd());
			statement.setInt(5, test.getNo());
			count = statement.executeUpdate();
		} catch (Exception e) {
			throw e;
		} finally {
			close(statement, connection);
		}
		return count > 0;
	}

	/** 削除 */
	public boolean delete(String studentNo, String subjectCd, String schoolCd, int no) throws Exception {
		Connection connection = getConnection();
		PreparedStatement statement = null;
		int count = 0;
		try {
			statement = connection.prepareStatement(
					"delete from test where student_no=? and subject_cd=? and school_cd=? and no=?");
			statement.setString(1, studentNo);
			statement.setString(2, subjectCd);
			statement.setString(3, schoolCd);
			statement.setInt(4, no);
			count = statement.executeUpdate();
		} catch (Exception e) {
			throw e;
		} finally {
			close(statement, connection);
		}
		return count > 0;
	}

	private Test mapRow(ResultSet rSet) throws SQLException {
		Test test = new Test();
		test.setStudentNo(rSet.getString("student_no"));
		test.setSubjectCd(rSet.getString("subject_cd"));
		test.setSchoolCd(rSet.getString("school_cd"));
		test.setNo(rSet.getInt("no"));
		test.setPoint((Integer) rSet.getObject("point"));
		test.setClassNum(rSet.getString("class_num"));
		test.setStudentName(rSet.getString("student_name"));
		test.setSubjectName(rSet.getString("subject_name"));
		try {
			test.setEntYear(rSet.getInt("ent_year"));
		} catch (SQLException ignored) {
		}
		return test;
	}

	private void close(PreparedStatement st, Connection con) throws SQLException {
		if (st != null) {
			try {
				st.close();
			} catch (SQLException e) {
				throw e;
			}
		}
		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				throw e;
			}
		}
	}
}
