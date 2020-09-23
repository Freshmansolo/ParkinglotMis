package com;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.junit.Test;

import com.DBUtil;

/**
 * 使用junit执行单元测试
 */
public class TestDemo {
	
	//当测试的方法逐渐增多时可以在大纲视图中，找到该方法名，并右击该方法名运行测试。
	@Test
	public void testQuery() {   //查询操作
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;
		try {
			//1.获取连接对象（这里使用到的DBUtil类就是我们上面写的工具类）
			connection = DBUtil.getConn();
			//2.根据连接对象，得到statement
			statement = connection.createStatement();
			//3.执行sql语句，返回ResultSet
			String sql = "select * from parkinginfo";
			resultSet = statement.executeQuery(sql);
			//4.遍历结果
			while(resultSet.next()) {
				String num = resultSet.getString("num");
				String location = resultSet.getString("location");
//				int permission = resultSet.getInt("permission");
				System.out.println("num = "+num+"  location = "+location);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testInsert() { //添加操作
		Connection connection = null;
		Statement statement = null;
		try {
			//1.获取连接对象
			connection = DBUtil.getConn();
			//2.根据连接对象，得到statement
			statement = connection.createStatement();
			//3.执行添加语句
			String sql = "insert into accounts values('songzijian123', '123456' , 1)";
			//这里返回的结果为影响的行数，如果大于零，则表示操作成功
			int result = statement.executeUpdate(sql);
			if (result > 0) {
				System.out.println("添加成功");
			} else {
				System.out.println("添加失败");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.release(connection);
		}
	}
	
	@Test
	public void testDelete() {  //删除操作
		Connection connection = null;
		Statement statement = null;
		try {
			//1.获取连接对象
			connection = DBUtil.getConn();
			//2.根据连接对象，得到statement
			statement = connection.createStatement();
			//3.执行删除语句
			String sql = "delete from accounts where account='songzijian'";
			//这里返回的结果为影响的行数，如果大于零，则表示操作成功
			int result = statement.executeUpdate(sql);
			if (result > 0) {
				System.out.println("删除成功");
			} else {
				System.out.println("删除失败");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.release(connection);
		}
	}
	
	@Test
	public void testUpdate() {  //修改操作
		Connection connection = null;
		Statement statement = null;
		try {
			//1.获取连接对象
			connection = DBUtil.getConn();
			//2.根据连接对象，得到statement
			statement = connection.createStatement();
			//3.执行修改语句
			String sql = "update accounts set passw = '123456789' where account = 'songda'";
			//这里返回的结果为影响的行数，如果大于零，则表示操作成功
			int result = statement.executeUpdate(sql);
			if (result > 0) {
				System.out.println("修改成功");
			} else {
				System.out.println("修改失败");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.release(connection);
		}
	}
}