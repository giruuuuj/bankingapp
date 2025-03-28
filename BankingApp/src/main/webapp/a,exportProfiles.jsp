<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ include file="dbConnection.jsp" %>

<%
response.setContentType("text/csv");
response.setHeader("Content-Disposition", "attachment; filename=profiles.csv");

try {
    String sql = "SELECT a.account_id, a.name, a.email, p.full_name, p.address, p.phone, p.date_of_birth " +
                 "FROM accounts a JOIN profiles p ON a.account_id = p.account_id";
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(sql);

    PrintWriter writer = response.getWriter();
    writer.println("Account ID,Name,Email,Full Name,Address,Phone,Date of Birth");

    while (rs.next()) {
        writer.println(
            rs.getInt("account_id") + "," +
            rs.getString("name") + "," +
            rs.getString("email") + "," +
            rs.getString("full_name") + "," +
            rs.getString("address") + "," +
            rs.getString("phone") + "," +
            rs.getString("date_of_birth")
        );
    }
} catch (SQLException e) {
    e.printStackTrace();
    out.println("<p class='error'>Error exporting profiles.</p>");
}
%>