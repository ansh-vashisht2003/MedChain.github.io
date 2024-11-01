<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession session1 = request.getSession(false);
    String name = (session1 != null) ? (String) session1.getAttribute("name") : null;
    String id = (session1 != null) ? String.valueOf(session1.getAttribute("id")) : null;
    String username = (session1 != null) ? (String) session1.getAttribute("username") : null;
    String password = (session1 != null) ? (String) session1.getAttribute("password") : null;
    String phoneNumber = (session1 != null) ? (String) session1.getAttribute("phone_number") : null;
    String email = (session1 != null) ? (String) session1.getAttribute("email") : null;

    if (name == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Details</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #E8F0F2; /* Light cyan background */
            color: #2C3E50; /* Dark gray text color */
        }

        header {
            position: relative;
            text-align: center;
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #34495E; /* Dark blue-gray for navbar */
            padding: 10px 20px;
        }

        .logo {
            color: #F4D03F; /* Gold logo color */
            font-size: 24px;
            font-weight: bold;
        }

        .nav-links {
            list-style: none;
            display: flex;
        }

        .nav-links li {
            margin: 0 15px;
        }

        .nav-links a {
            color: #F4F6F6; /* Light white text */
            text-decoration: none;
            transition: color 0.3s;
        }

        .nav-links a:hover {
            color: #85C1E9; /* Light blue hover effect */
        }

        .container {
            padding: 20px;
            max-width: 800px;
            margin: 40px auto;
            background: lightblue;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        h1, h2 {
            color: #2C3E50; /* Consistent heading color */
        }

        .detail {
            margin: 10px 0;
            font-size: 18px;
            color: #555;
            display: flex;
            justify-content: space-between;
            border-bottom: 1px solid #f0f0f0;
            padding-bottom: 8px;
        }

        .detail span {
            font-weight: bold;
            color: #34495E; /* Dark blue-gray */
        }

        footer {
            text-align: center;
            padding: 10px 0;
            background: #34495E;
            color: #F4F6F6;
            position: relative;
            bottom: 0;
            width: 100%;
        }

        .logout-button {
            display: block;
            margin-top: 30px;
            width: 100%;
            padding: 12px;
            background-color: #34495E;
            color: #ffffff;
            text-align: center;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            box-shadow: 0 5px 10px rgba(52, 73, 94, 0.3);
            transition: background-color 0.3s, transform 0.3s;
        }

        .logout-button:hover {
            background-color: #2C3E50;
            transform: translateY(-3px);
        }

        .logout-button:active {
            transform: translateY(1px);
        }
    </style>
</head>
<body>
    <header>
        <nav>
            <div class="logo">Requesting Dashboard</div>
            <ul class="nav-links">
                <li><a href="dashboard.jsp">Home</a></li>
                <li><a href="order.jsp">Order Now</a></li>
                <li><a href="past.jsp">Past Orders</a></li>
                <li><a href="contact.jsp">Profile</a></li>
            </ul>
        </nav>
    </header>
    
    <div class="container">
        <h1>Contact Details</h1>
        <div class="detail"><span>ID:</span> <%= id %></div>
        <div class="detail"><span>Name:</span> <%= name %></div>
        <div class="detail"><span>Username:</span> <%= username %></div>
        <div class="detail"><span>Password:</span> <%= password %></div>
        <div class="detail"><span>Phone Number:</span> <%= phoneNumber %></div>
        <div class="detail"><span>Email:</span> <%= email %></div>
        <a href="../index.jsp" class="logout-button">Logout</a>
    </div>

    <footer>
        <p>&copy; 2024 MedChain Delivery. All rights reserved.</p>
    </footer>
</body>
</html>
