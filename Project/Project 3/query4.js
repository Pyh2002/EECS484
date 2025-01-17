// Query 4
// Find user pairs (A,B) that meet the following constraints:
// i) user A is male and user B is female
// ii) their Year_Of_Birth difference is less than year_diff
// iii) user A and B are not friends
// iv) user A and B are from the same hometown city
// The following is the schema for output pairs:
// [
//      [user_id1, user_id2],
//      [user_id1, user_id3],
//      [user_id4, user_id2],
//      ...
//  ]
// user_id is the field from the users collection. Do not use the _id field in users.
// Return an array of arrays.

function suggest_friends(year_diff, dbname) {
    db = db.getSiblingDB(dbname);

    let pairs = [];

    db.users.find({
        gender: "male"
    }).forEach(userA => {
        db.users.find({
            gender: "female",
            hometown: userA.hometown
        }).forEach(userB => {
            if (Math.abs(userA.YOB - userB.YOB) < year_diff &&
                userA.friends.indexOf(userB.user_id) === -1 &&
                userB.friends.indexOf(userA.user_id) === -1
            ) {
                pairs.push([userA.user_id, userB.user_id]);
            }
        });
    });

    return pairs;
} 
