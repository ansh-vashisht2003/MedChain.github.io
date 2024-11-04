<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String message = "";
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (username != null && password != null) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Medicine", "root", "password");
            
            // Check credentials in requesting_chemist table
            ps = con.prepareStatement("SELECT id, name, username, password, phone_number, email FROM supplying_chemist WHERE username = ? AND password = ?");
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                // Store user details in session
                HttpSession session11 = request.getSession();
                session11.setAttribute("id", rs.getInt("id"));
                session11.setAttribute("name", rs.getString("name"));
                session11.setAttribute("username", rs.getString("username"));
                session11.setAttribute("password", rs.getString("password"));
                session11.setAttribute("phone_number", rs.getString("phone_number"));
                session11.setAttribute("email", rs.getString("email"));
                
                // Redirect to dashboard
                response.sendRedirect("dashboard.jsp");
                return;
            } else {
                message = "Invalid username or password. Please try again.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "An error occurred: " + e.getMessage();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Supplying Chemist Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to bottom right, #83a4d4, #b6fbff);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            padding: 20px;
        }
        h1 {
            color: #3a8dc5;
            margin-bottom: 20px;
        }
        form {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }
        input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #0056b3;
        }
        p {
            text-align: center;
            color: #555;
        }
        .message {
            color: #dc3545; /* Red for error messages */
            text-align: center;
        }
    </style>
</head>
<body>
    <h1>Supplier Login</h1>
    <form action="login.jsp" method="post">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
    </form>
    <p class="message"><%= message %></p>
    <p>Don't have an account? <a href="signup.jsp">Sign up here</a></p>
</body>
</html>
