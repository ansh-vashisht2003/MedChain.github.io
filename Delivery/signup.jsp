<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String message = "";
    String name = request.getParameter("name");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    String phone_number = request.getParameter("phone_number");

    if (name != null && username != null && password != null && email != null && phone_number != null) {
        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Medicine", "root", "password");
            
            // Insert into supplying_chemist table
            ps = con.prepareStatement("INSERT INTO delivery_person (name, username, password, email, phone_number) VALUES (?, ?, ?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, username);
            ps.setString(3, password);
            ps.setString(4, email);
            ps.setString(5, phone_number);
            
            int result = ps.executeUpdate();
            if (result > 0) {
                message = "Registration successful! You can now login.";
                response.sendRedirect("login.jsp"); // Redirect to login page after successful registration
            } else {
                message = "Registration failed. Please try again.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "An error occurred: " + e.getMessage();
        } finally {
            try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Delivery Person Signup</title>
    <link rel="stylesheet" href="../styles.css">
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
            color: #28a745;
            text-align: center;
        }
    </style>
</head>
<body>
    <h1>Delivery Person Signup</h1>
    <form action="signup.jsp" method="post">
        <input type="text" name="name" placeholder="Full Name" required>
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="text" name="phone_number" placeholder="Phone Number" required>
        <button type="submit">Register</button>
    </form>
    <p class="message"><%= message %></p>
    <p>Already have an account? <a href="login.jsp">Login here</a></p>
</body>
</html>
