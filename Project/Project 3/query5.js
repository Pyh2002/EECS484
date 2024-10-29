// Query 5
// Find the oldest friend for each user who has a friend. For simplicity,
// use only year of birth to determine age, if there is a tie, use the
// one with smallest user_id. You may find query 2 and query 3 helpful.
// You can create selections if you want. Do not modify users collection.
// Return a javascript object : key is the user_id and the value is the oldest_friend id.
// You should return something like this (order does not matter):
// {user1:userx1, user2:userx2, user3:userx3,...}

function oldest_friend(dbname) {
    db = db.getSiblingDB(dbname);

    let all_friends = [];
    db.users.find({}, { user_id: 1, friends: 1, YOB: 1, _id: 0 }).forEach(user => {
        const userId = user.user_id;
        user.friends.forEach(friendId => {
            all_friends.push({ user_id: userId, friends: friendId, YOB: user.YOB });
            all_friends.push({ user_id: friendId, friends: userId, YOB: user.YOB });
        });
    });

    let results = {};

    // Group friends by user_id
    let groupedFriends = {};
    all_friends.forEach(entry => {
        if (!groupedFriends[entry.user_id]) {
            groupedFriends[entry.user_id] = [];
        }
        groupedFriends[entry.user_id].push(entry);
    });

    // Find the oldest friend for each user
    for (let userId in groupedFriends) {
        let friends = groupedFriends[userId];
        if (friends.length > 0) {
            friends.sort((a, b) => {
                if (a.YOB === b.YOB) {
                    return a.friends - b.friends;
                }
                return a.YOB - b.YOB;
            });
            results[userId] = friends[0].friends;
        }
    }

    return results;
} 
