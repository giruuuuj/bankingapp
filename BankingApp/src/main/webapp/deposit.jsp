<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<%
    if (request.getMethod().equalsIgnoreCase("post")) {
        int accountId = Integer.parseInt(request.getParameter("accountId"));
        double amount = Double.parseDouble(request.getParameter("amount"));

        try {
            // Update account balance
            String sql = "UPDATE accounts SET balance = balance + ? WHERE account_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setDouble(1, amount);
            pstmt.setInt(2, accountId);
            pstmt.executeUpdate();

            // Record transaction
            sql = "INSERT INTO transactions (account_id, type, amount) VALUES (?, 'DEPOSIT', ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, accountId);
            pstmt.setDouble(2, amount);
            pstmt.executeUpdate();

            out.println("<p>Deposit successful!</p>");
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Deposit Money</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>Deposit Money</h1>
        <form method="post">
            <label for="accountId">Account ID:</label>
            <input type="number" name="accountId" required><br>
            <label for="amount">Amount:</label>
            <input type="number" name="amount" step="0.01" required><br>
            <button type="submit">Deposit</button>
        </form>
        <a href="index.jsp">Back to Home</a>
    </div>
</body>
</html>