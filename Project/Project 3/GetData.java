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
        JSONArray users_info = new JSONArray();

        try (Statement stmt = oracleConnection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY)) {
            // Query to get user information
            String query = "SELECT u.user_id, u.name, u.age, c.city_name AS current_city, h.city_name AS hometown_city " +
                           "FROM " + userTableName + " u " +
                           "LEFT JOIN " + currentCityTableName + " cc ON u.user_id = cc.user_id " +
                           "LEFT JOIN " + cityTableName + " c ON cc.city_id = c.city_id " +
                           "LEFT JOIN " + hometownCityTableName + " hc ON u.user_id = hc.user_id " +
                           "LEFT JOIN " + cityTableName + " h ON hc.city_id = h.city_id";

            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                JSONObject user = new JSONObject();
                user.put("user_id", rs.getString("user_id"));
                user.put("name", rs.getString("name"));
                user.put("age", rs.getInt("age"));
                user.put("current_city", rs.getString("current_city"));
                user.put("hometown_city", rs.getString("hometown_city"));

                // Query to get friends of the user
                String friendsQuery = "SELECT f.friend_id FROM " + friendsTableName + " f WHERE f.user_id = '" + rs.getString("user_id") + "'";
                ResultSet friendsRs = stmt.executeQuery(friendsQuery);
                JSONArray friends = new JSONArray();
                while (friendsRs.next()) {
                    friends.put(friendsRs.getString("friend_id"));
                }
                user.put("friends", friends);

                users_info.put(user);
            }
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
