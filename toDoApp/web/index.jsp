<%-- 
    Document   : index
    Created on : 29 oct. 2024, 18:16:13
    Author     : Samuel
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="database.DataBaseHelper"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <style>
            html, body {
                height: 100%;
            }
            body {
                display: flex;
                flex-direction: column;
            }
            main {
                flex-grow: 1;
            }
            .completed {
                background-color: #d4edda;
                border-color: #c3e6cb;
            }

        </style>
        <title>JSP Page</title>
    </head>
    <body>    
        <%
            String msg = request.getParameter("msg");
        %>
        <%
            if (session.getAttribute("userID") == null) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp?error=You must log in");
                dispatcher.forward(request, response);
            }

            int userID = (Integer) session.getAttribute("userID");

            DataBaseHelper ds = new DataBaseHelper();

            ResultSet resultset = ds.getTasks(userID);
            ResultSet resultsUser = ds.getUser(userID);
            resultsUser.next();

        %>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container-fluid">
                <a class="navbar-brand" href="index.jsp">toDo App</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="index.jsp">Welcome <%=resultsUser.getString("name")%></a>
                        </li> 
                        <li class="nav-item">
                            <a class="nav-link" href="index.jsp">Home</a>
                        </li>                  
                        <li class="nav-item">
                            <a class="nav-link active" href="SearchTask.jsp">Search</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Login.jsp">Logout</a>
                        </li> 
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container mt-5">
            <h1>Add New Task</h1>
            <form action="AddTask.jsp">
                <div class="mb-3">
                    <label for="title" class="form-label">Title</label>
                    <input type="text" class="form-control" id="title" name="title" required>
                </div>
                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <textarea class="form-control" id="description" name="description" rows="4" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary" >Add Task</button>
            </form>
        </div>

        <main class='container mt-5'>
            <div class="row">
                <%
                    while (resultset.next()) {
                        Timestamp formatDate = resultset.getTimestamp("creation_date");
                        SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy hh:mm a");
                        String creation_date = sdf.format(new Date(formatDate.getTime()));
                        int id = resultset.getInt("id");
                        boolean isCompleted = resultset.getBoolean("is_completed");
                %>
                <div class="card" id="<%= id %>" style="width: 18rem; margin-right: 10px; margin-bottom: 10px; <%= isCompleted ? "background-color: #d4edda;" : "" %>">                 
                    <div class="card-body">
                        <h5 class="card-title"><%= resultset.getString("title")%></h5>
                        <p class="card-text">
                            <strong>Description: </strong> <%= resultset.getString("description")%><br>
                            <strong>Creation date: </strong> <%= creation_date%>
                        </p>
                        <p class="card-text">
                            <strong>User: </strong> <%= resultset.getString("name")%>
                        </p>
                        <div class="d-flex justify-content-end">
                                <button type="submit" class="btn btn-success" onclick="window.location.href='CompleteTask.jsp?taskID=<%= resultset.getInt("id") %>'">
                                    &#10004;
                                </button>
                        </div>
                    </div>
                </div>
                <%}%>
            </div>
        </main>
        <footer class='bg-primary text-white text-center text-lg-start mt-auto'>
            <div class='text-center p-3' style='background-color: rgba(0, 0, 0, 0.2);'>
                © 2024 toDoApp | All rights reserved.
            </div>
        </footer>
    </body>
</html>
