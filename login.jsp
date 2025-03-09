<%-- 
    Document   : login
    Created on : 19 Feb 2025, 1:31:43 pm
    Author     : Meet
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

    <%@ page import="java.sql.*" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Database credentials
    String dbURL = "jdbc:mysql://localhost:3306/jdbc"; 
    String dbUser = "root"; 
    String dbPass = "";

    try {
        // Load MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish connection
        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // Prepare SQL statement to prevent SQL injection
        String sql = "SELECT * FROM login WHERE username = ? AND password = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, password);

        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
             session.setAttribute("username", username); // Store user session
        //response.sendRedirect("welcome.jsp"); // Redirect to welcome page
            out.println("<script>alert('Login successfull'); window.location='index.html';</script>");
        }else{
            out.println("<script>alert('Invalid username or password!'); window.location='index.html';</script>");
        }

        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("Database connection error: " + e.getMessage());
    }

%>

    </body>
</html>
