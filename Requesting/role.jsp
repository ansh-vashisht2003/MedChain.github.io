<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Database connection
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String message = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Medicine", "root", "password");
        
        // Perform any necessary operations for requesting chemist role
        // Example: Fetch available medicines or handle requests
        
    } catch (Exception e) {
        message = "An error occurred: " + e.getMessage();
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Requesting Chemist Dashboard</title>
    <link rel="stylesheet" href="../styles.css">
</head>
<body>
    <h1>Requesting Chemist Dashboard</h1>
    <p><%= message %></p>
    <a href="signup.jsp">Sign Up</a>
    <a href="login.jsp">Login</a>
    <p>Perform actions related to requesting medicine here.</p>
    <!-- Add buttons or forms for specific operations -->
</body>
</html>
