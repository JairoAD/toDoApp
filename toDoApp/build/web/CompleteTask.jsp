
<%@page import="database.DataBaseHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<%
    int idTask = Integer.parseInt(request.getParameter("taskID"));
    
    String path;
    DataBaseHelper dt = new DataBaseHelper();

    if (dt.completeTask(idTask)) {        
        path = "/index.jsp?msg=Movie saved";
    } else {
        path = "/Login.jsp?msg=Error saving the Movie";
    }

    dt.Close();
    RequestDispatcher dispatcher = request.getRequestDispatcher(path);
    dispatcher.forward(request, response);
%>