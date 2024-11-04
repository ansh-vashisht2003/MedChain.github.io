<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%
HttpSession session11 = request.getSession(false);
if (session11 == null || session11.getAttribute("name") == null) {
    response.sendRedirect("login.jsp");
    return;
}

// Retrieve session attributes safely
String name = (String) session11.getAttribute("name");
String id1 = String.valueOf(session11.getAttribute("id"));
String phoneNumber = (String) session11.getAttribute("phone_number");

// Ensure the ID is parsed only if it's valid
int id = -1;
try {
    id = Integer.parseInt(id1);
} catch (NumberFormatException e) {
    response.sendRedirect("login.jsp");
    return;
}

// Database connection variables
String jdbcURL = "jdbc:mysql://localhost:3306/Medicine"; // Adjust the URL as needed
String dbUser = "root"; // Replace with your DB user
String dbPassword = "password"; // Replace with your DB password

Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

// Action handling
String action = request.getParameter("action");
int orderId = action != null && (action.equals("deliver") || action.equals("cancel")) ? Integer.parseInt(request.getParameter("orderId")) : -1;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

    // Handle action
    if (action != null && orderId != -1) {
        String updateSql = null;
        if (action.equals("deliver")) {
            updateSql = "UPDATE orders SET status = 'Delivered' WHERE order_id = ?";
        } else if (action.equals("cancel")) {
            updateSql = "UPDATE orders SET status = 'Cancelled' WHERE order_id = ?";
        }

        if (updateSql != null) {
            ps = conn.prepareStatement(updateSql);
            ps.setInt(1, orderId);
            ps.executeUpdate();

            // Close statement to prevent issues before continuing
            ps.close();
        }
    }

    // Query to get only orders with the 'Shipped' status
    String sql = "SELECT o.order_id, o.requesting_chemist_name, o.requesting_chemist_phone, " +
                 "o.medicine_name, o.price, o.quantity " +
                 "FROM orders o " +
                 "WHERE o.status = 'Shipped'";

    ps = conn.prepareStatement(sql);
    rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shipped Orders</title>
    <style>
        /* Add your CSS styles */
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

        h2 {
            color: #1e88e5;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            max-width: 800px;
            border-collapse: collapse;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #1e88e5;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #e3f2fd;
        }
        .action-buttons {
            display: flex;
            gap: 5px;
        }
        .action-buttons a {
            text-decoration: none;
            padding: 8px 12px;
            border-radius: 4px;
            color: white;
            font-weight: bold;
        }
        .deliver {
            background-color: #28a745;
        }
        .cancel {
            background-color: #dc3545;
        }
        .deliver:hover {
            background-color: #218838;
        }
        .cancel:hover {
            background-color: #c82333;
        }
        @media (max-width: 600px) {
            table {
                width: 100%;
                font-size: 14px;
            }
            h2 {
                font-size: 20px;
            }
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
    <center><br><br>
    <h2>Shipped Orders</h2>
    <table>
        <thead>
            <tr>
                <th>Order ID</th>
                <th>Requesting Chemist Name</th>
                <th>Phone Number</th>
                <th>Medicine Name</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                boolean hasOrders = false;
                while (rs.next()) {
                    hasOrders = true;
                    orderId = rs.getInt("order_id");
                    String chemistName = rs.getString("requesting_chemist_name");
                    String chemistPhone = rs.getString("requesting_chemist_phone");
                    String medicineName = rs.getString("medicine_name");
                    float price = rs.getFloat("price");
                    int quantity = rs.getInt("quantity");
            %>
            <tr>
                <td><%= orderId %></td>
                <td><%= chemistName %></td>
                <td><%= chemistPhone %></td>
                <td><%= medicineName %></td>
                <td><%= price %></td>
                <td><%= quantity %></td>
                <td class="action-buttons">
                    <a href="?action=deliver&orderId=<%= orderId %>" class="deliver">Deliver</a>
                    <a href="?action=cancel&orderId=<%= orderId %>" class="cancel">Cancel</a>
                </td>
            </tr>
            <%
                }
                if (!hasOrders) {
                    out.println("<tr><td colspan='7' style='text-align:center;'>No shipped orders available.</td></tr>");
                }
            %>
        </tbody>
    </table>
    </center>
<%
} catch (Exception e) {
    e.printStackTrace();
    out.println("<p>Error: " + e.getMessage() + "</p>");
} finally {
    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
    if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
}
%>
</body>
</html>
