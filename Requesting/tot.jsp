<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession session1 = request.getSession(false);
    String chemistId = (session1 != null) ? String.valueOf(session1.getAttribute("id")) : null;

    if (chemistId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pending Requests</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #E9F2F5;
            margin: 0;
            padding: 0;
        }

       nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #34495E; /* Dark blue-gray for navbar */
          
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
            max-width: 1000px;
            margin: auto;
        }

        .welcome-message, .about-section, .order-services {
            background-color: #FFFFFF;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        h1, h2 {
            color: #2C3E50;
        }

        p {
            color: #555;
            line-height: 1.6;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #ffffff;
            border-radius: 10px;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #34495E;
            color: #F7F9F9;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #e1eaf4;
        }

        .no-data {
            text-align: center;
            font-style: italic;
            color: #7D8793;
        }
         header {
            position: relative;
            text-align: center;
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
                <li><a href="contact.jsp">Profile</a></li>
            </ul>
        </nav>
    </header>

    <div class="container">
        <div class="welcome-message">
           
            <p>We are here to make your pharmacy operations smoother and more efficient. Easily request essential medicines, keep track of your inventory needs, and get reliable assistance whenever you need it. Access the latest in pharmaceutical supplies with just a few clicks!</p>
        </div>

       

        <div class="order-services">
            <h2>Pending Requests</h2>

            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Medicine Name</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Order Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Medicine", "root", "password");

                            String sql = "SELECT order_id, medicine_name, quantity, price, order_date, status " +
                                         "FROM orders " +
                                         "WHERE request_id = ? AND status = 'Pending'";
                            pstmt = conn.prepareStatement(sql);
                            pstmt.setInt(1, Integer.parseInt(chemistId));
                            rs = pstmt.executeQuery();

                            boolean hasPendingRequests = false;
                            while (rs.next()) {
                                hasPendingRequests = true;
                    %>
                                <tr>
                                    <td><%= rs.getInt("order_id") %></td>
                                    <td><%= rs.getString("medicine_name") %></td>
                                    <td><%= rs.getInt("quantity") %></td>
                                    <td>Rs.<%= rs.getFloat("price") %></td>
                                    <td><%= rs.getTimestamp("order_date") %></td>
                                    <td><%= rs.getString("status") %></td>
                                </tr>
                    <%
                            }

                            if (!hasPendingRequests) {
                    %>
                                <tr>
                                    <td colspan="6" class="no-data">No pending requests found.</td>
                                </tr>
                    <%
                            }
                        } catch (Exception e) {
                            out.println("<tr><td colspan='6' style='color: red; text-align: center;'>Error: " + e.getMessage() + "</td></tr>");
                        } finally {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
