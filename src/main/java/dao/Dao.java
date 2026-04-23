package dao;

import java.sql.Connection;

import javax.sql.DataSource;

public class Dao {
	/**
	 * データソース:DataSource:クラスフィールド
	 */
	public static DataSource ds;

	/**
	 * getConnectionメソッド データベースへのコネクションを返す
	 *
	 * @return データベースへのコネクション:Connection
	 * @throws Exception
	 */
	public Connection getConnection() throws Exception {
		// データベースへのコネクションを返却
		return ds.getConnection();
	}
}
