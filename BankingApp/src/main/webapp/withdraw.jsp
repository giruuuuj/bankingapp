<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<%
    if (request.getMethod().equalsIgnoreCase("post")) {
        int accountId = Integer.parseInt(request.getParameter("accountId"));
        double amount = Double.parseDouble(request.getParameter("amount"));

        try {
            // Check if sufficient balance is available
            String sql = "SELECT balance FROM accounts WHERE account_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, accountId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                double balance = rs.getDouble("balance");
                if (balance >= amount) {
                    // Update account balance
                    sql = "UPDATE accounts SET balance = balance - ? WHERE account_id = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setDouble(1, amount);
                    pstmt.setInt(2, accountId);
                    pstmt.executeUpdate();

                    // Record transaction
                    sql = "INSERT INTO transactions (account_id, type, amount) VALUES (?, 'WITHDRAW', ?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, accountId);
                    pstmt.setDouble(2, amount);
                    pstmt.executeUpdate();

                    out.println("<p>Withdrawal successful!</p>");
                } else {
                    out.println("<p>Error: Insufficient balance!</p>");
                }
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
    <title>Withdraw Money</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>Withdraw Money</h1>
        <form method="post">
            <label for="accountId">Account ID:</label>
            <input type="number" name="accountId" required><br>
            <label for="amount">Amount:</label>
            <input type="number" name="amount" step="0.01" required><br>
            <button type="submit">Withdraw</button>
        </form>
        <a href="index.jsp">Back to Home</a>
    </div>
</body>
</html>