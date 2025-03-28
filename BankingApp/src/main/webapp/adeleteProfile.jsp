<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>

<%
int accountId = Integer.parseInt(request.getParameter("id"));

try {
    String sql = "DELETE FROM profiles WHERE account_id = ?";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, accountId);
    pstmt.executeUpdate();

    sql = "DELETE FROM accounts WHERE account_id = ?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, accountId);
    pstmt.executeUpdate();

    response.sendRedirect("admin.jsp");
} catch (SQLException e) {
    e.printStackTrace();
    out.println("<p class='error'>Error deleting profile.</p>");
}
%>