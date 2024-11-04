<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    HttpSession session1 = request.getSession(false);
    String name = (session1 != null) ? (String) session1.getAttribute("name") : null;
    String phone_number = (session1 != null) ? (String) session1.getAttribute("phone_number") : null;
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
        int price = Integer.parseInt(request.getParameter("price"));
        String requestingChemistAddress = request.getParameter("requesting_chemist_address");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Medicine", "root", "password");

            String query = "INSERT INTO orders (request_chemist_id, medicine_name, price, requesting_chemist_name, quantity, requesting_chemist_address, requesting_chemist_phone, status) VALUES (?, ?, ?, ?, ?, ?, ?, 'Pending')";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, requestingChemistId);
            pstmt.setString(2, medicineName);
            pstmt.setInt(3, price);
            pstmt.setString(4, name);
            pstmt.setInt(5, quantity);
            pstmt.setString(6, requestingChemistAddress);
            pstmt.setString(7, phone_number);

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
            width: 60%;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff; /* White background */
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #34495E; /* Dark blue-gray */
            margin-bottom: 20px;
            font-size: 32px;
        }

        label {
            display: block;
            font-weight: bold;
            color: #34495E;
            margin-bottom: 8px;
        }

        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
            transition: border-color 0.3s;
        }

        input[type="text"]:focus, input[type="number"]:focus {
            border-color: #3498DB; /* Blue on focus */
            outline: none;
        }

        button {
            width: 100%;
            padding: 15px;
            background-color: #3498DB; /* Blue button */
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #2980B9; /* Darker blue */
        }

        .message, .error {
            text-align: center;
            margin-top: 15px;
            padding: 15px;
            border-radius: 5px;
            font-size: 16px;
        }

        .message {
            color: #27AE60; /* Green text */
            background-color: #D4EFDF; /* Light green background */
        }

        .error {
            color: #E74C3C; /* Red text */
            background-color: #F5B7B1; /* Light red background */
        }
          .logo {
            color: #F4D03F; /* Gold logo color */
            font-size: 24px;
            font-weight: bold;
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
                  <li><a href="tot.jsp">Orders</a></li>
                <li><a href="past.jsp">Past Orders</a></li>
                  <li><a href="pen.jsp"> Pending Orders</a></li>
               
                <li><a href="contact.jsp">Profile</a></li>
            </ul>
        </nav>
    </header>
    <div class="container">
        <h1>Order Medicine</h1>

        <% if (message != null && !message.isEmpty()) { %>
            <p class="<%= message.startsWith("Error") ? "error" : "message" %>"><%= message %></p>
        <% } %>

        <form method="post">
            <label for="medicine_name">Medicine Name:</label>
            <input type="text" id="medicine_name" name="medicine_name" required>

            <label for="quantity">Quantity:</label>
            <input type="number" id="quantity" name="quantity" min="1" required>

            <label for="price">Total Price:</label>
            <input type="number" id="price" name="price" min="1" required>

            <label for="requesting_chemist_address">Address:</label>
            <input type="text" id="requesting_chemist_address" name="requesting_chemist_address" required>

            <button type="submit">Submit Order</button>
        </form>
    </div>
</body>
</html>
