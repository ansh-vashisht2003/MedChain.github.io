<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession session11 = request.getSession(false);
    String name = (session11 != null) ? (String) session11.getAttribute("name") : null;
    String id = (session11 != null) ? String.valueOf(session11.getAttribute("id")) : null;
    String username = (session11 != null) ? (String) session11.getAttribute("username") : null;
    String password = (session11 != null) ? (String) session11.getAttribute("password") : null;
    String phoneNumber = (session11 != null) ? (String) session11.getAttribute("phone_number") : null;
    String email = (session11 != null) ? (String) session11.getAttribute("email") : null;

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
        body {
            font-family: 'Roboto', sans-serif;
            background: #F0F4F8; /* Light, calming background */
            color: #333;
            margin: 0;
        }

        header {
            background: linear-gradient(90deg, #2D6A4F, #52B788); /* Green gradient */
            padding: 15px;
            color: #FFF;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        nav {
            display: flex;
            justify-content: space-around;
            background: #74C69D;
            padding: 10px 0;
        }

        .nav-links {
            list-style: none;
            display: flex;
            gap: 20px;
        }

        .nav-links li {
            display: inline;
        }

        .nav-links a {
            color: #FFF;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 15px;
            background: #2D6A4F;
            border-radius: 5px;
            transition: background 0.3s, transform 0.2s;
        }

        .nav-links a:hover {
            background: #52B788;
            transform: scale(1.05);
        }

        main {
            padding: 20px;
            max-width: 1100px;
            margin: auto;
        }

        section {
            margin: 20px 0;
            padding: 30px;
            background: #FFF;
            border-radius: 12px;
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
            border-left: 5px solid #52B788;
        }
      

        .container {
            padding: 20px;
            max-width: 800px;
            margin: 40px auto;
            background: #74C69D;
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
        <h1>Welcome to the Platform, <%= name %>!</h1>
    </header>
    
    <nav>
        <ul class="nav-links">
            <li><a href="dashboard.jsp">Overview</a></li>
        <%--     <li><a href="#services">Services</a></li>
          <li><a href="#contact">Contact</a></li>   --%> 
            <li><a href="order.jsp">Order Requests</a></li>
            <li><a href="supplyHistory.jsp">Supply History</a></li>
            <li><a href="profile.jsp">Profile</a></li>
           
        </ul>
    </nav>
    
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
