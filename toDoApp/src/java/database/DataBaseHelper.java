package database;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DataBaseHelper {

    Connection conn;

    public void Close() {
        try {
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(DataBaseHelper.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public DataBaseHelper() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/toDoDB?useUnicode=true&characterEncoding=UTF-8", "root", "Admin$1234");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DataBaseHelper.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int validateLogin(String txtEmail, String txtPwd) throws SQLException {
        Statement statement = conn.createStatement();
        String sql = "SELECT * FROM toDoDB.users WHERE email = '" + txtEmail + "' AND password = '" + txtPwd + "'";
        ResultSet resultset = statement.executeQuery(sql);
        int id;
        if (resultset.next()) {
            id = resultset.getInt("userID");
            return id;
        } else {
            return 0;
        }
    }

    public boolean registerUser(String name, String email, String password) throws SQLException {
        try {
            Statement statement = conn.createStatement();
            String sql = "INSERT INTO Users (name, email, password) VALUES ('"
                    + name + "', '"
                    + email + "', '"
                    + password + "');";
            statement.executeUpdate(sql);
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public boolean validateEmail(String txtEmail) throws SQLException {
        Statement statement = conn.createStatement();
        String sql = "SELECT * FROM toDoDB.Users WHERE email = '" + txtEmail + "'";
        ResultSet resultset = statement.executeQuery(sql);
        while (resultset.next()) {
            return true;
        }
        return false;
    }

    public boolean addTask(String title, String description, int userID) throws SQLException {
        try {
            Statement statement = conn.createStatement();
            String sql = "INSERT INTO Tasks (title, description, userID, is_completed) "
                    + "VALUES ('" + title + "', '" + description + "', " + userID + ", FALSE);";
            statement.executeUpdate(sql);
            return true;
        } catch (SQLException ex) {
            return false;
        }
    }

    public boolean completeTask(int taskID) throws SQLException {
        try {
            Statement statement = conn.createStatement();
            String sql = "UPDATE Tasks SET is_completed = TRUE WHERE id = "  + taskID + ";";
            statement.executeUpdate(sql);
            return true;
        } catch (SQLException ex) {
            return false;
        }
    }

    public ResultSet getTasks(int userID) throws SQLException {
        Statement statement = conn.createStatement();
        String sql = "SELECT t.id, t.title, t.description, t.creation_date, u.name, t.is_completed "
                + "FROM Tasks t "
                + "JOIN Users u ON t.userID = u.userID "
                + "ORDER BY t.creation_date DESC;";

        ResultSet resultset = statement.executeQuery(sql);
        return resultset;
    }

    public ResultSet searchTasks(int userID, String search) throws SQLException {
        Statement statement = conn.createStatement();
        String sql = "SELECT t.id, t.title, t.description, t.creation_date, u.name, t.is_completed "
                + "FROM Tasks t "
                + "JOIN Users u ON t.userID = u.userID "
                + "WHERE t.title LIKE '%" + search + "%'"
                + "ORDER BY t.creation_date DESC;";
        ResultSet resultset = statement.executeQuery(sql);
        return resultset;
    }

    public ResultSet getUser(int userID) throws SQLException {
        Statement statement = conn.createStatement();
        String sql = "SELECT "
                + "u.name, "
                + "u.email "
                + "FROM toDoDB.Users u "
                + "WHERE u.userID = " + userID + ";";

        return statement.executeQuery(sql);
    }
}
