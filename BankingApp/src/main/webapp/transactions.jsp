<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<%
    if (request.getMethod().equalsIgnoreCase("post")) {
        int accountId = Integer.parseInt(request.getParameter("accountId"));

        try {
            String sql = "SELECT * FROM transactions WHERE account_id = ? ORDER BY transaction_date DESC";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, accountId);
            ResultSet rs = pstmt.executeQuery();
%>
            <h2>Transaction History</h2>
            <table border="1">
                <tr>
                    <th>Transaction ID</th>
                    <th>Type</th>
                    <th>Amount</th>
                    <th>Date</th>
                </tr>
                <%
                    while (rs.next()) {
                        int transactionId = rs.getInt("transaction_id");
                        String type = rs.getString("type");
                        double amount = rs.getDouble("amount");
                        Timestamp date = rs.getTimestamp("transaction_date");
                %>
                <tr>
                    <td><%= transactionId %></td>
                    <td><%= type %></td>
                    <td>$<%= amount %></td>
                    <td><%= date %></td>
                </tr>
                <%
                    }
                %>
            </table>
<%
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Transaction History</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>Transaction History</h1>
        <form method="post">
            <label for="accountId">Account ID:</label>
            <input type="number" name="accountId" required><br>
            <button type="submit">View Transactions</button>
        </form>
        <a href="index.jsp">Back to Home</a>
    </div>
</body>
</html>