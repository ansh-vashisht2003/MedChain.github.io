<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    HttpSession session1 = request.getSession(false);
    String name = (session1 != null) ? (String) session1.getAttribute("name") : null;
    Integer requestingChemistId = (session1 != null) ? (Integer) session1.getAttribute("id") : null;
    String message = "";

    if (name == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    if (request.getMethod().equalsIgnoreCase("POST")) {
        String medicineName = request.getParameter("medicine_name");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String requestingChemistAddress = request.getParameter("requesting_chemist_address");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL JDBC Driver
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Medicine", "root", "password"); // Update with your DB credentials

            // Insert order details into orders table
            String query = "INSERT INTO orders (request_id, medicine_name, quantity, requesting_chemist_address, status) VALUES (?, ?, ?, ?, 'Pending')";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, requestingChemistId);
            pstmt.setString(2, medicineName);
            pstmt.setInt(3, quantity);
            pstmt.setString(4, requestingChemistAddress);

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                message = "Order submitted successfully!";
            } else {
                message = "Failed to submit the order.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Error: " + e.getMessage();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Medicine</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background-color: #e0f7fa; /* Light cyan background */
            color: #2c3e50; /* Dark gray text color */
        }

        header {
            background: #00796b; /* Teal background */
            color: white;
            padding: 15px 20px;
            text-align: center;
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
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
            color: #ffffff; /* White text */
            text-decoration: none;
            padding: 5px 10px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .nav-links a:hover {
            background-color: #004d40; /* Darker teal hover */
        }

        .container {
            max-width: 500px;
            padding: 20px;
            background-color: #ffffff; /* White background */
            border-radius: 8px;
            box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
            margin: 40px auto; /* Center the container */
        }

        h1 {
            text-align: center;
            color: #00796b; /* Teal color for heading */
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }

        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: border 0.3s;
        }

        input[type="text"]:focus, input[type="number"]:focus {
            border-color: #00796b; /* Focus border color */
            outline: none;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #00796b; /* Teal button */
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #004d40; /* Darker teal on hover */
        }

        .message, .error {
            text-align: center;
            margin-top: 10px;
            padding: 10px;
            border-radius: 4px;
        }

        .message {
            color: green;
            background-color: #c8e6c9; /* Light green background */
        }

        .error {
            color: red;
            background-color: #ffcdd2; /* Light red background */
        }
    </style>
</head>
<body>
    <header>
        <nav>
            <div class="logo">Requesting Dashboard</div>
            <ul class="nav-links">
                <li><a href="dashboard.jsp">Home</a></li>
                <li><a href="#">Order Now</a></li>
                <li><a href="past.jsp">Past Orders</a></li>
                <li><a href="contact.jsp">Profile</a></li>
            </ul>
        </nav>
    </header>
    <div class="container">
        <h1>Order Medicine</h1>

        <!-- Display messages -->
        <% if (message != null && !message.isEmpty()) { %>
            <p class="<%= message.startsWith("Error") ? "error" : "message" %>"><%= message %></p>
        <% } %>

        <!-- Form for entering medicine details -->
        <form method="post">
            <label for="medicine_name">Medicine Name:</label>
            <input type="text" id="medicine_name" name="medicine_name" required>

            <label for="quantity">Quantity:</label>
            <input type="number" id="quantity" name="quantity" min="1" required>

            <label for="requesting_chemist_address">Address:</label>
            <input type="text" id="requesting_chemist_address" name="requesting_chemist_address" required>

            <button type="submit">Submit Order</button>
        </form>
    </div>
</body>
</html>

