DROP TRIGGER Order_Friend_Pairs;

ALTER TABLE
    Albums DROP CONSTRAINT fk_cover_photo;

ALTER TABLE
    Photos DROP CONSTRAINT fk_album;

DROP SEQUENCE program_seq;

DROP SEQUENCE city_seq;

DROP SEQUENCE user_seq;

DROP TRIGGER program_id_trigger;

DROP TRIGGER city_id_trigger;

DROP TRIGGER user_id_trigger;

DROP TABLE Tags;

DROP TABLE Photos;

DROP TABLE Albums;

DROP TABLE Participants;

DROP TABLE User_Events;

DROP TABLE Education;

DROP TABLE Programs;

DROP TABLE Messages;

DROP TABLE User_Hometown_Cities;

DROP TABLE User_Current_Cities;

DROP TABLE Cities;

DROP TABLE Friends;

DROP TABLE Users;