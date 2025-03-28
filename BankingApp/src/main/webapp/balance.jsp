<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<%
    if (request.getMethod().equalsIgnoreCase("post")) {
        int accountId = Integer.parseInt(request.getParameter("accountId"));

        try {
            String sql = "SELECT balance FROM accounts WHERE account_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, accountId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                double balance = rs.getDouble("balance");
                out.println("<p>Account Balance: $" + balance + "</p>");
            } else {
                out.println("<p>Error: Account not found!</p>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Check Balance</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>Check Balance</h1>
        <form method="post">
            <label for="accountId">Account ID:</label>
            <input type="number" name="accountId" required><br>
            <button type="submit">Check Balance</button>
        </form>
        <a href="index.jsp">Back to Home</a>
    </div>
</body>
</html>