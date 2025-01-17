let dbname = "extomato"; // replace with your uniqname

function cleanUp() {
    db.getCollectionNames().forEach((col) => {
        if (col != "users") db.getCollection(col).drop();
    });
}

(function () {
    load("query5.js");
    print("=== Test5 === (This test can take up to a minute)");
    let test5 = oldest_friend(dbname);
    printjson(test5); // uncomment this line to print the query5 output
    if (Object.keys(test5).length == 798) {
        if (test5.hasOwnProperty(799)) {
            let ans5 = test5[799];
            if (test5[799] == 51) {
                print("Local test passed! Partially correct.");
            } else {
                print("Local test failed!");
                print("Expected oldest friend for user 799 to be 51, you found", ans5, ".");
            }
        } else {
            print("Local test failed!");
            print("Expected oldest friend for user 799 to be 51. You found no oldest friend for user 799.");
        }
    } else {
        print("Local test failed!");
        print("Expected 798 users, you found", Object.keys(test5).length, "users.");
    }
    cleanUp();
})();
