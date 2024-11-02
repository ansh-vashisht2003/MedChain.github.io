<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%
HttpSession session1 = request.getSession(false);
String name = (session1 != null) ? (String) session1.getAttribute("name") : null;
String id1 = (session1 != null) ? String.valueOf(session1.getAttribute("id")) : null;
String phoneNumber = (session1 != null) ? (String) session1.getAttribute("phone_number") : null;
int id = Integer.parseInt(id1);
if (name == null) {
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
int orderId = action != null && (action.equals("accept") || action.equals("remove")) ? Integer.parseInt(request.getParameter("orderId")) : -1;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

    // Handle action
    if (action != null && orderId != -1) {
        if (action.equals("accept")) {
            // Update order status to Accepted
            String updateSql = "UPDATE orders SET status = 'Accepted', supplying_chemist_id = ?, supplying_chemist_name = ?, supplying_chemist_phone = ? WHERE order_id = ?";
            ps = conn.prepareStatement(updateSql);
            ps.setInt(1, id); // Assuming userId is supplying chemist ID
            ps.setString(2, name);
            ps.setString(3, phoneNumber);
            ps.setInt(4, orderId);
            ps.executeUpdate();
        } else if (action.equals("remove")) {
            // Hide the order from the user's view
            String hideSql = "INSERT INTO hidden_orders (id, order_id) VALUES (?, ?) ON DUPLICATE KEY UPDATE order_id = order_id"; // Prevent duplicates
            ps = conn.prepareStatement(hideSql);
            ps.setInt(1, id);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        }
    }

    // Query to get pending orders excluding those hidden by the user
    String sql = "SELECT o.order_id, o.requesting_chemist_name, o.requesting_chemist_phone, " +
                 "o.medicine_name, o.price, o.quantity " +
                 "FROM orders o " +
                 "LEFT JOIN hidden_orders h ON o.order_id = h.order_id AND h.id = ? " +
                 "WHERE o.status = 'Pending' AND h.order_id IS NULL";

    ps = conn.prepareStatement(sql);
    ps.setInt(1, id);
    rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Form</title>
    <style>
        /* Styles for the page */
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
        .accept {
            background-color: #28a745;
        }
        .remove {
            background-color: #dc3545;
        }
        .accept:hover {
            background-color: #218838;
        }
        .remove:hover {
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
                <li><a href="dashbaord.jsp">Home</a></li>
                <li><a href="order.jsp">Order Now</a></li>
                <li><a href="past.jsp">Past Orders</a></li>
                 <li><a href="tot.jsp">Orders</a></li>
                <li><a href="contact.jsp">Profile</a></li>
            </ul>
        </nav>
    </header>
    <h2>Pending Orders</h2>
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
                    <a href="?action=accept&orderId=<%= orderId %>" class="accept">✔</a>
                    <a href="?action=remove&orderId=<%= orderId %>" class="remove">✖</a>
                </td>
            </tr>
            <%
                }
                if (!hasOrders) {
                    out.println("<tr><td colspan='7' style='text-align:center;'>No pending orders available.</td></tr>");
                }
            %>
        </tbody>
    </table>
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
