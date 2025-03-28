<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<%
    if (request.getMethod().equalsIgnoreCase("post")) {
        int loanId = Integer.parseInt(request.getParameter("loanId"));
        String action = request.getParameter("action"); // approve or reject

        try {
            String sql = "UPDATE loans SET status = ? WHERE loan_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, action.toUpperCase());
            pstmt.setInt(2, loanId);
            pstmt.executeUpdate();

            out.println("<p>Loan application " + action + "ed successfully!</p>");
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Loan Applications</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>Loan Applications</h1>
        <table border="1">
            <tr>
                <th>Loan ID</th>
                <th>Account ID</th>
                <th>Loan Type</th>
                <th>Amount</th>
                <th>Interest Rate</th>
                <th>Tenure</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            <%
                try {
                    String sql = "SELECT * FROM loans";
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        int loanId = rs.getInt("loan_id");
                        int accountId = rs.getInt("account_id");
                        String loanType = rs.getString("loan_type");
                        double amount = rs.getDouble("amount");
                        double interestRate = rs.getDouble("interest_rate");
                        int tenure = rs.getInt("tenure");
                        String status = rs.getString("status");
            %>
            <tr>
                <td><%= loanId %></td>
                <td><%= accountId %></td>
                <td><%= loanType %></td>
                <td>$<%= amount %></td>
                <td><%= interestRate %>%</td>
                <td><%= tenure %> months</td>
                <td><%= status %></td>
                <td>
                    <form method="post" style="display:inline;">
                        <input type="hidden" name="loanId" value="<%= loanId %>">
                        <input type="hidden" name="action" value="approve">
                        <button type="submit">Approve</button>
                    </form>
                    <form method="post" style="display:inline;">
                        <input type="hidden" name="loanId" value="<%= loanId %>">
                        <input type="hidden" name="action" value="reject">
                        <button type="submit">Reject</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            %>
        </table>
        <a href="index.jsp">Back to Home</a>
    </div>
</body>
</html>