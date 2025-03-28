<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<%
    if (request.getMethod().equalsIgnoreCase("post")) {
        int accountId = Integer.parseInt(request.getParameter("accountId"));
        String loanType = request.getParameter("loanType");
        double amount = Double.parseDouble(request.getParameter("amount"));
        double interestRate = Double.parseDouble(request.getParameter("interestRate"));
        int tenure = Integer.parseInt(request.getParameter("tenure"));

        try {
            String sql = "INSERT INTO loans (account_id, loan_type, amount, interest_rate, tenure) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, accountId);
            pstmt.setString(2, loanType);
            pstmt.setDouble(3, amount);
            pstmt.setDouble(4, interestRate);
            pstmt.setInt(5, tenure);
            pstmt.executeUpdate();

            out.println("<p>Loan application submitted successfully!</p>");
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Apply for Loan</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>Apply for Loan</h1>
        <form method="post">
            <label for="accountId">Account ID:</label>
            <input type="number" name="accountId" required><br>
            <label for="loanType">Loan Type:</label>
            <select name="loanType" required>
                <option value="personal">Personal Loan</option>
                <option value="home">Home Loan</option>
                <option value="car">Car Loan</option>
            </select><br>
            <label for="amount">Loan Amount:</label>
            <input type="number" name="amount" step="0.01" required><br>
            <label for="interestRate">Interest Rate (%):</label>
            <input type="number" name="interestRate" step="0.01" required><br>
            <label for="tenure">Tenure (months):</label>
            <input type="number" name="tenure" required><br>
            <button type="submit">Apply</button>
        </form>
        <a href="index.jsp">Back to Home</a>
    </div>
</body>
</html>