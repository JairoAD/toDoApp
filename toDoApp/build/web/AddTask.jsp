<%@page import="database.DataBaseHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<%
    String path;

    Integer userID = (session != null) ? (Integer) session.getAttribute("userID") : null;

    if (userID == null) {
       
        path = "/Login.jsp?error=You must log in first.";
    } else {
        String title = request.getParameter("title");
        String description = request.getParameter("description");

        DataBaseHelper dt = new DataBaseHelper();
        
        if (dt.addTask(title, description, userID)) {        
            path = "/index.jsp";
        } else {
            path = "/Login.jsp?error=Failed to add task.";
        }
        dt.Close();
    }

    RequestDispatcher dispatcher = request.getRequestDispatcher(path);
    dispatcher.forward(request, response);
%>