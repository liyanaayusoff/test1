<%@ page import="java.sql.*" %>
<%
    String connectionString = "jdbc:mysql://localhost/nawanii";
    String username = "root";
    String password = "";
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(connectionString, username, password);
        statement = connection.createStatement();
        resultSet = statement.executeQuery("SELECT * FROM inventory");

        while (resultSet.next()) {
            String productName = resultSet.getString("invName");
            int productInventoryLevel = resultSet.getInt("invQty");
            int minInvLevel = resultSet.getInt("minInvLevel");

            if (productInventoryLevel <= minInvLevel) {
                out.println("<script src='https://code.jquery.com/jquery-3.4.1.min.js'></script>");
                out.println("<script src='../push.js/push.min.js'></script>");
                out.println("<script src='../push.js/serviceWorker.min.js'></script>");
                out.println("<script>");
                out.println("Push.create('Nawanii Empire Inventory Alert', {");
                out.println("body: 'Inventory level for " + productName + " has reached " + productInventoryLevel + "',");
                out.println("icon: '../image/logo.JPG',");
                out.println("timeout: 8000,");
                out.println("onClick: function () {");
                out.println("window.focus();");
                out.println("this.close();");
                out.println("}");
                out.println("});");
                out.println("</script>");
            }
        }
    } catch (Exception ex) {
        out.println("Error: " + ex.getMessage());
    } finally {
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (Exception ex) {
            out.println("Error: " + ex.getMessage());
        }
    }
%>
