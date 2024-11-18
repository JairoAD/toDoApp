<%@page import="database.DataBaseHelper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    String txtemail = request.getParameter("txtemail");
    String txtpwd = request.getParameter("txtpwd");
    String path;
    DataBaseHelper dt = new DataBaseHelper();

    int userID = dt.validateLogin(txtemail, txtpwd);
    if (userID != 0) { 
        session.setAttribute("userID", userID);
        path = "/index.jsp";
    } else {
        path = "/Login.jsp?error=Incorrect credentials";
    }

    dt.Close();
    RequestDispatcher dispatcher = request.getRequestDispatcher(path);
    dispatcher.forward(request, response);
%>