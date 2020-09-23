package com;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {

	public static String db_url = "jdbc:mysql://localhost:3306/parkinglotmis?characterEncoding=utf8";
	public static String db_user = "root";
	public static String db_pass = "szj123456";

	public static Connection getConn () {
		Connection conn = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(db_url, db_user, db_pass);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return conn;
	}
	public static void release(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
 
	}
}