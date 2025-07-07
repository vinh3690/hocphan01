package model;

import java.sql.Connection;
import java.sql.DriverManager;

public class Database {
	public static Connection connect() {
		Connection connect = null;
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String url = "jdbc:sqlserver://DESKTOP-7S67ETB:1433;databaseName=hoaQua;encrypt=true;trustServerCertificate=true;";
			String user = "sa";
			String pass = "12345678";
			connect = DriverManager.getConnection(url, user, pass);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return connect;
	}
	public static void main(String[] args) {
		System.out.println(connect());
	}
}
