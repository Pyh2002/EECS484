INSERT INTO
    Users (
        user_id,
        first_name,
        last_name,
        year_of_birth,
        month_of_birth,
        day_of_birth,
        gender
    )
SELECT
    DISTINCT user_id,
    first_name,
    last_name,
    year_of_birth,
    month_of_birth,
    day_of_birth,
    gender
FROM
    project1.Public_User_Information;

INSERT INTO
    Friends (user1_id, user2_id)
SELECT
    DISTINCT user1_id,
    user2_id
FROM
    project1.Public_Are_Friends;

INSERT INTO
    Cities (city_name, state_name, country_name)
SELECT
    DISTINCT current_city,
    current_state,
    current_country
FROM
    project1.Public_User_Information
UNION
SELECT
    DISTINCT hometown_city,
    hometown_state,
    hometown_country
FROM
    project1.Public_User_Information
UNION
SELECT
    DISTINCT event_city,
    event_state,
    event_country
FROM
    project1.Public_Event_Information;

INSERT INTO
    User_Current_Cities (user_id, current_city_id)
SELECT
    DISTINCT Users.user_id,
    Cities.city_id
FROM
    Users,
    Cities,
    project1.Public_User_Information
WHERE
    Users.user_id = project1.Public_User_Information.user_id
    AND Cities.city_name = project1.Public_User_Information.current_city
    AND Cities.state_name = project1.Public_User_Information.current_state
    AND Cities.country_name = project1.Public_User_Information.current_country;

INSERT INTO
    User_Hometown_Cities (user_id, hometown_city_id)
SELECT
    DISTINCT Users.user_id,
    Cities.city_id
FROM
    Users,
    Cities,
    project1.Public_User_Information
WHERE
    Users.user_id = project1.Public_User_Information.user_id
    AND Cities.city_name = project1.Public_User_Information.hometown_city
    AND Cities.state_name = project1.Public_User_Information.hometown_state
    AND Cities.country_name = project1.Public_User_Information.hometown_country;

INSERT INTO
    Programs (institution, concentration, degree)
SELECT
    DISTINCT institution_name,
    program_concentration,
    program_degree
FROM
    project1.Public_User_Information
WHERE
    institution_name IS NOT NULL
    AND program_concentration IS NOT NULL
    AND program_degree IS NOT NULL;

INSERT INTO
    Education (user_id, program_id, program_year)
SELECT
    DISTINCT Users.user_id,
    Programs.program_id,
    program_year
FROM
    Users,
    Programs,
    project1.Public_User_Information
WHERE
    Users.user_id = project1.Public_User_Information.user_id
    AND Programs.institution = project1.Public_User_Information.institution_name
    AND Programs.concentration = project1.Public_User_Information.program_concentration;

-- Changed from program_concentration to concentration
INSERT INTO
    User_Events (
        event_id,
        event_creator_id,
        event_name,
        event_tagline,
        event_description,
        event_host,
        event_type,
        event_subtype,
        event_address,
        event_city_id,
        event_start_time,
        event_end_time
    )
SELECT
    DISTINCT event_id,
    event_creator_id,
    event_name,
    event_tagline,
    event_description,
    event_host,
    event_type,
    event_subtype,
    event_address,
    cities.city_id,
    event_start_time,
    event_end_time
FROM
    project1.Public_Event_Information pub_event
    LEFT JOIN cities ON pub_event.event_city = cities.city_name
    LEFT JOIN cities ON pub_event.event_state = cities.state_name
    LEFT JOIN cities ON pub_event.event_country = cities.country_name;

INSERT INTO
    Albums (
        album_id,
        album_owner_id,
        album_name,
        album_created_time,
        album_modified_time,
        album_link,
        album_visibility,
        cover_photo_id
    )
SELECT
    DISTINCT album_id,
    owner_id,
    album_name,
    album_created_time,
    album_modified_time,
    album_link,
    album_visibility,
    cover_photo_id
FROM
    project1.Public_Photo_Information;

INSERT INTO
    Photos (
        photo_id,
        album_id,
        photo_caption,
        photo_created_time,
        photo_modified_time,
        photo_link
    )
SELECT
    DISTINCT photo_id,
    album_id,
    photo_caption,
    photo_created_time,
    photo_modified_time,
    photo_link
FROM
    project1.Public_Photo_Information;

INSERT INTO
    Tags (
        tag_photo_id,
        tag_subject_id,
        tag_created_time,
        tag_x,
        tag_y
    )
SELECT
    DISTINCT photo_id,
    tag_subject_id,
    tag_created_time,
    tag_x_coordinate,
    tag_y_coordinate
FROM
    project1.Public_Tag_Information;