// Query 6
// Find the average friend count per user.
// Return a decimal value as the average user friend count of all users in the users collection.

function find_average_friendcount(dbname) {
    db = db.getSiblingDB(dbname);

    const users = db.users.find({}, { user_id: 1, friends: 1 }).toArray();
    
    let totalFriends = 0;
    let totalUsers = users.length;

    users.forEach(user => {
        totalFriends += user.friends.length;
    });

    let averageFriendCount = totalUsers > 0 ? totalFriends / totalUsers : 0;

    return averageFriendCount;
}