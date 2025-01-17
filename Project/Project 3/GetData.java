import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.TreeSet;
import java.util.Vector;

import org.json.JSONObject;
import org.json.JSONArray;

public class GetData {

    static String prefix = "project3.";

    // You must use the following variable as the JDBC connection
    Connection oracleConnection = null;

    // You must refer to the following variables for the corresponding 
    // tables in your database
    String userTableName = null;
    String friendsTableName = null;
    String cityTableName = null;
    String currentCityTableName = null;
    String hometownCityTableName = null;

    // DO NOT modify this constructor
    public GetData(String u, Connection c) {
        super();
        String dataType = u;
        oracleConnection = c;
        userTableName = prefix + dataType + "_USERS";
        friendsTableName = prefix + dataType + "_FRIENDS";
        cityTableName = prefix + dataType + "_CITIES";
        currentCityTableName = prefix + dataType + "_USER_CURRENT_CITIES";
        hometownCityTableName = prefix + dataType + "_USER_HOMETOWN_CITIES";
    }

    // TODO: Implement this function
    @SuppressWarnings("unchecked")
    public JSONArray toJSON() throws SQLException {

        // This is the data structure to store all users' information
        JSONArray users_info = new JSONArray();

        try (Statement stmt = oracleConnection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY)) {
            // Your implementation goes here....
            String user_query = "SELECT USER_ID, FIRST_NAME, LAST_NAME, GENDER, YEAR_OF_BIRTH, MONTH_OF_BIRTH, DAY_OF_BIRTH FROM " + userTableName;
            ResultSet user_rs = stmt.executeQuery(user_query);

            while (user_rs.next()) {
                JSONObject user = new JSONObject();
                user.put("user_id", user_rs.getInt("USER_ID"));
                user.put("first_name", user_rs.getString("FIRST_NAME"));
                user.put("last_name", user_rs.getString("LAST_NAME"));
                user.put("gender", user_rs.getString("GENDER"));
                user.put("YOB", user_rs.getInt("YEAR_OF_BIRTH"));
                user.put("MOB", user_rs.getInt("MONTH_OF_BIRTH"));
                user.put("DOB", user_rs.getInt("DAY_OF_BIRTH"));

                JSONArray friends = new JSONArray();
                try (Statement friendstmt = oracleConnection.createStatement()){
                    String friends_query = "SELECT USER2_ID FROM " + friendsTableName + " WHERE USER1_ID = " + user_rs.getString("USER_ID");
                    ResultSet friends_rs = friendstmt.executeQuery(friends_query);
                    while (friends_rs.next()) {
                        friends.put(friends_rs.getInt("USER2_ID"));
                    }
                    friends_rs.close();
                }
                user.put("friends", friends);

                JSONObject hometown = new JSONObject();
                try (Statement hometownstmt = oracleConnection.createStatement()){
                    String hometown_query = 
                        "SELECT C.CITY_NAME, C.STATE_NAME, C.COUNTRY_NAME " + 
                        "FROM " + cityTableName + " C " +
                        "JOIN " + hometownCityTableName + " H ON C.CITY_ID = H.HOMETOWN_CITY_ID " +
                        "WHERE H.USER_ID = " + user_rs.getString("USER_ID");
                    ResultSet hometown_rs = hometownstmt.executeQuery(hometown_query);
                    while (hometown_rs.next()) {
                        hometown.put("city", hometown_rs.getString("CITY_NAME"));
                        hometown.put("state", hometown_rs.getString("STATE_NAME"));
                        hometown.put("country", hometown_rs.getString("COUNTRY_NAME"));
                    }
                    hometown_rs.close();
                }
                user.put("hometown", hometown);

                JSONObject current = new JSONObject();
                try (Statement currentstmt = oracleConnection.createStatement()){
                    String current_query = 
                        "SELECT C.CITY_NAME, C.STATE_NAME, C.COUNTRY_NAME " + 
                        "FROM " + cityTableName + " C " +
                        "JOIN " + currentCityTableName + " H ON C.CITY_ID = H.CURRENT_CITY_ID " +
                        "WHERE H.USER_ID = " + user_rs.getString("USER_ID");
                    ResultSet current_rs = currentstmt.executeQuery(current_query);
                    while (current_rs.next()) {
                        current.put("city", current_rs.getString("CITY_NAME"));
                        current.put("state", current_rs.getString("STATE_NAME"));
                        current.put("country", current_rs.getString("COUNTRY_NAME"));
                    }
                    current_rs.close();
                }
                user.put("current", current);

                users_info.put(user);
            }
            user_rs.close();
            stmt.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }

        return users_info;
    }

    // This outputs to a file "output.json"
    // DO NOT MODIFY this function
    public void writeJSON(JSONArray users_info) {
        try {
            FileWriter file = new FileWriter(System.getProperty("user.dir") + "/output.json");
            file.write(users_info.toString());
            file.flush();
            file.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
