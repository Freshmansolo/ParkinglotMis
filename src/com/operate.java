package com;

import java.util.List;
import java.io.IOException;
//import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.ArrayList;
import java.sql.*;

/**
 * Servlet implementation class operate
 */
@WebServlet("/operate")
public class operate extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.service(request, response);
		String method=request.getParameter("method");
		if(method.equals("regist"))
		{
			zhuce(request,response);
			//			response.getWriter().append("okkk").append(request.getContextPath());
		}
		if(method.equals("login"))
		{
			login(request,response);
			//			response.getWriter().append("okkk").append(request.getContextPath());
		}
		if(method.equals("add"))
		{
			add(request,response);
		}
		if(method.equals("change"))
		{
			change(request,response);
		}
		if(method.equals("search"))
		{
			search(request,response);
		}
	}

//注册
	private void zhuce(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String account=request.getParameter("account");
		String passw=request.getParameter("code");
		Connection con = DBUtil.getConn();
		PreparedStatement stmt=null;
		
		String sql = "insert into accounts(account,passw)values(?,?)";
		String sql2 = "select account from accounts where account = '"+account+"'";
		//System.out.println(sql2);
		try {
			stmt =con.prepareStatement(sql2);
			ResultSet rs = stmt.executeQuery();
			
			//获取rs集合中数据的个数保存在row中
			rs.last();
			int row=rs.getRow();
			rs.beforeFirst();
			//System.out.println(row);
			
			//row为0数据库中无此用户名，反之则说明用户名存在
			if(row==0) {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, account);
				stmt.setString(2, passw);
				//stmt.execute();
				int i=stmt.executeUpdate();
				if(i==1) {
					request.setAttribute("message", "注册成功！");
					request.getRequestDispatcher("index.jsp").forward(request,response);
				}
				else
				{
					request.setAttribute("message", "注册失败！");
					request.getRequestDispatcher("regist.jsp").forward(request,response);
				}
				stmt.close();
				con.close();
			}
			else {
				request.setAttribute("message", "用户名已存在！");
				request.getRequestDispatcher("regist.jsp").forward(request,response);
			}
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		
//		try {
//			stmt = con.prepareStatement(sql);
//			stmt.setString(1, account);
//			stmt.setString(2, passw);
//			//stmt.execute();
//			int i=stmt.executeUpdate();
//			if(i==1) {
//				request.setAttribute("message", "注册成功！");
//				request.getRequestDispatcher("index.jsp").forward(request,response);
//			}
//			else
//			{
//				request.setAttribute("message", "注册失败！");
//				request.getRequestDispatcher("index.jsp").forward(request,response);
//			}
//			stmt.close();
//			con.close();
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}

	}
//登录
	private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String account=request.getParameter("account");
		String passw=request.getParameter("code");
		Connection con = DBUtil.getConn();
		PreparedStatement stmt=null;
		String sql = "select * from accounts";
		try {
			stmt = con.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery(sql);
			List<String> list1=new ArrayList<String>();
			List<String> list2=new ArrayList<String>();
			List<String> list3=new ArrayList<String>();
			while(rs.next())
			{
				list1.add(rs.getString(1));
				list2.add(rs.getString(2));
				list3.add(rs.getString(3));
			}
			boolean flag=false;
			for(int i=0;i<list1.size();i++)
			{
				if(list1.get(i).equals(account))
				{
					flag=true;
					if(list2.get(i).equals(passw))
					{
						if(list3.get(i).equals("1"))
						{
							request.getRequestDispatcher("main.jsp").forward(request,response);
						}
						else
						{
							request.getRequestDispatcher("showpersonal.jsp").forward(request,response);
						}
					}
					else
					{
						request.setAttribute("message", "密码错误！");
						request.getRequestDispatcher("index.jsp").forward(request,response);
					}
				}

			}
			if(flag==false) 
			{
				request.setAttribute("message", "该用户名不存在！");
				request.getRequestDispatcher("index.jsp").forward(request,response);
			}
			rs.close();
			stmt.close();
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
//车辆入库
	private void add(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//request.setCharacterEncoding("utf-8");
		String num=request.getParameter("num");
		num=new String(num.getBytes("ISO-8859-1"),"UTF-8");//服务器默认使用 ISO-8859-1 编码接受参数，手动转为UTF-8
		String location=request.getParameter("location");
		//System.out.println(num);//测试由add.jsp页面传来的num乱码问题
		Connection con=DBUtil.getConn();
		PreparedStatement stmt=null;
		String sql3="select * from parkingorder where state=0";
		try {
			stmt=con.prepareStatement(sql3);
			ResultSet rs=stmt.executeQuery(sql3);
			List<String> empty=new ArrayList<String>();
			while(rs.next())
			{
				empty.add(rs.getString(1));
			}
			boolean tag_t=false;
			for(int i=0;i<empty.size();i++) {
				if(empty.get(i).equals(location))
				{
					tag_t=true;
				}
			}
			if(tag_t==false)
			{
				request.setAttribute("message", "输入停车位置序号超出范围！");
				request.getRequestDispatcher("add.jsp").forward(request,response);
			}
			else
			{
				String sql="insert into parkinginfo(num,location)values(?,?)";
				try {
					stmt=con.prepareStatement(sql);
					stmt.setString(1, num);
					stmt.setString(2, location);
					//stmt.execute();
					int i=stmt.executeUpdate();
					if(i==1) {
						String sql2="update parkingorder set state=1 where listnum="+location;
						stmt=con.prepareStatement(sql2);
						stmt.executeUpdate();
						request.setAttribute("message", "入库成功！");
						request.getRequestDispatcher("main.jsp").forward(request,response);
					}
					else
					{
						request.setAttribute("message", "入库失败！");
						request.getRequestDispatcher("add.jsp").forward(request,response);
					}
					stmt.close();
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			
			
			}
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}	
//修改车辆信息
	private void change(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//request.setCharacterEncoding("utf-8");
		String realnum=request.getParameter("realnum");
		realnum=new String(realnum.getBytes("ISO-8859-1"),"UTF-8");
		System.out.println(realnum);
		String reallocation=request.getParameter("reallocation");
		System.out.println(reallocation);
		String num=request.getParameter("num");
		num=new String(num.getBytes("ISO-8859-1"),"UTF-8");
		System.out.println(num);
		String location=request.getParameter("location");
		System.out.println(location);
		List<String> empty=new ArrayList<String>();
		//System.out.println(realnum+reallocation+num+location);//检测传值是否正确
		Connection con = DBUtil.getConn();
		PreparedStatement stmt=null;
		String sql4="select * from parkingorder where state=0";
		try {
			stmt=con.prepareStatement(sql4);
			ResultSet rs=stmt.executeQuery(sql4);
			while(rs.next())
			{
				empty.add(rs.getString(1));
			}
			empty.add(reallocation);
			System.out.println(empty.size());
			boolean tag_t=false;
			tag_t=empty.contains(location);
			System.out.println(tag_t);
//			for(int i=0;i<empty.size();i++) 
//			{
//				//System.out.println(empty.get(i));
//				if(empty.get(i).equals(location))
//				{
//					tag_t=true;
//				}
//			}
			if(tag_t==false)
			{
				
				request.setAttribute("message", "输入停车位置序号超出范围！");
				request.getRequestDispatcher("display.jsp").forward(request,response);
			}
			if(tag_t==true)
			{
				String sql = "update parkinginfo set num='"+num+"',location='"+location+"' where num='"+realnum+"' ";
				try {
					stmt = con.prepareStatement(sql);
					int i=stmt.executeUpdate(sql);
					//System.out.println(i);
					if(i==1) {
						String sql2="update parkingorder set state=0 where listnum='"+reallocation+"'";
						stmt=con.prepareStatement(sql2);
						stmt.executeUpdate();
						String sql3="update parkingorder set state=1 where listnum='"+location+"'";
						stmt=con.prepareStatement(sql3);
						stmt.executeUpdate();
						request.setAttribute("message", "修改成功！");
						request.getRequestDispatcher("display.jsp").forward(request,response);
					}
					else
					{
						request.setAttribute("message", "修改失败！");
						request.getRequestDispatcher("change.jsp").forward(request,response);
					}
					stmt.close();
					con.close();
					} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
//查询车辆信息
	private void search(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String carcard=request.getParameter("carcard");
		carcard=new String(carcard.getBytes("ISO-8859-1"),"UTF-8");
		//System.out.print(carcard); //检测传值是否正确
		Connection con = DBUtil.getConn();
		PreparedStatement stmt=null;
		String sql="select * from parkinginfo where num='"+carcard+"'";
		try {
			stmt = con.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery(sql);
			if(rs.next())
			{
					request.setAttribute("message","车牌号为："+rs.getString(1)+"停车位置："+rs.getString(2));
					request.getRequestDispatcher("showpersonal.jsp").forward(request,response);
			}
			else
			{
				request.setAttribute("message",("车牌号为："+carcard+"不存在，请核对！"));
				request.getRequestDispatcher("showpersonal.jsp").forward(request,response);
			}
			rs.close();
			stmt.close();
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public operate() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}




