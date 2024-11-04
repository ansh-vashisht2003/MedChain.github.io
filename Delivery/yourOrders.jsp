<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%
HttpSession session1 = request.getSession(false);
if (session1 == null || session1.getAttribute("name") == null) {
    response.sendRedirect("login.jsp");
    return;
}

String name = (String) session1.getAttribute("name");
String id1 = String.valueOf(session1.getAttribute("id"));
String phoneNumber = (String) session1.getAttribute("phone_number");

int id = -1;
try {
    id = Integer.parseInt(id1);
} catch (NumberFormatException e) {
    response.sendRedirect("login.jsp");
    return;
}

String jdbcURL = "jdbc:mysql://localhost:3306/Medicine";
String dbUser = "root";
String dbPassword = "password";

Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

String action = request.getParameter("action");
int orderId = (action != null && action.equals("accept")) ? Integer.parseInt(request.getParameter("orderId")) : -1;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

    if (action != null && orderId != -1) {
        if (action.equals("accept")) {
            String updateSql = "UPDATE orders SET status = 'Shipped', delivery_person_id = ?, delivery_person_name = ?, delivery_person_phone = ? WHERE order_id = ?";
            ps = conn.prepareStatement(updateSql);
            ps.setInt(1, id);
            ps.setString(2, name);
            ps.setString(3, phoneNumber);
            ps.setInt(4, orderId);
            ps.executeUpdate();
        }
    }

    String sql = "SELECT o.order_id, o.medicine_name, o.quantity, o.price, " +
                 "o.requesting_chemist_name, o.requesting_chemist_phone, o.requesting_chemist_address, " +
                 "o.supplying_chemist_name, o.supplying_chemist_phone " +
                 "FROM orders o " +
                 "WHERE o.status = 'Accepted'";
    ps = conn.prepareStatement(sql);
    rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accepted Orders</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
         * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4; /* Light gray for contrast */
            color: #333;
        }

        header {
            position: relative;
            background: linear-gradient(to bottom, #333, #555);
            padding: 15px 0;
            text-align: center;
            color: #fff;
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
        }

        .logo {
            font-size: 30px;
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
            color: #fff;
            text-decoration: none;
            font-size: 18px;
            transition: color 0.3s;
        }

        .nav-links a:hover {
            color: #ffdd57;
        }
        h2 {
            margin: 20px 0;
            color: #2575fc;
        }

        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px 15px;
            text-align: center;
        }

        th {
            background-color: #6a11cb;
            color: #fff;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        button {
            background-color: #2575fc;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #1e63d0;
        }

        form {
            display: inline;
        }

        .no-orders {
            text-align: center;
            padding: 20px;
            font-size: 1.2rem;
            color: #666;
        }
    </style>
</head>
<body>
<header>
    <nav>
        <div class="logo">Delivery Dashboard</div>
        <ul class="nav-links">
            <li><a href="dashboard.jsp">Home</a></li>
            <li><a href="yourOrders.jsp">Your Orders</a></li>
            <li><a href="past.jsp">Orders Delivered</a></li>
            <li><a href="thankYou.jsp">Logout</a></li>
        </ul>
    </nav>
</header>
<center><h2>Accepted Orders</h2></center>
<table>
    <thead>
        <tr>
            <th>Order No</th>
            <th>Medicine Name</th>
            <th>Quantity</th>
            <th>Price</th>
            <th>Requesting Chemist Name</th>
            <th>Phone Number</th>
            <th>Address</th>
            <th>Supplier Name</th>
            <th>Supplier Phone</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%
            boolean hasOrders = false;
            while (rs.next()) {
                hasOrders = true;
                int orderIdDb = rs.getInt("order_id");
                String medicineName = rs.getString("medicine_name");
                int quantity = rs.getInt("quantity");
                float price = rs.getFloat("price");
                String reqName = rs.getString("requesting_chemist_name");
                String reqPhone = rs.getString("requesting_chemist_phone");
                String reqAddress = rs.getString("requesting_chemist_address");
                String suppName = rs.getString("supplying_chemist_name");
                String suppPhone = rs.getString("supplying_chemist_phone");
        %>
        <tr>
            <td><%= orderIdDb %></td>
            <td><%= medicineName %></td>
            <td><%= quantity %></td>
            <td><%= price %></td>
            <td><%= reqName %></td>
            <td><%= reqPhone %></td>
            <td><%= reqAddress %></td>
            <td><%= suppName %></td>
            <td><%= suppPhone %></td>
            <td>
                <form method="post">
                    <input type="hidden" name="action" value="accept">
                    <input type="hidden" name="orderId" value="<%= orderIdDb %>">
                    <button type="submit">Accept</button>
                </form>
            </td>
        </tr>
        <%
            }
            if (!hasOrders) {
                out.println("<tr><td colspan='10' class='no-orders'>No accepted orders available.</td></tr>");
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
