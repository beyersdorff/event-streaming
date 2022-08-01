CREATE STREAM MEETUP_EVENTS(
  "utc_offset" BIGINT,
  "venue" STRUCT<"country" VARCHAR,
    "city" VARCHAR,
    "address_1" VARCHAR,
    "name" VARCHAR,
    "lon" DOUBLE,
    "lat" DOUBLE
  >,
  "rsvp_limit" INT,
  "venue_visibility" VARCHAR,
  "visibility" VARCHAR,
  "maybe_rsvp_count" INT,
  "description" VARCHAR,
  "mtime" BIGINT,
  "event_url" VARCHAR,
  "yes_rsvp_count" INT,
  "payment_required" VARCHAR,
  "name" VARCHAR,
  "id" BIGINT,
  "time" BIGINT,
  "group" STRUCT<"join_mode" VARCHAR,
    "country" VARCHAR,
    "city" VARCHAR,
    "name" VARCHAR,
    "group_lon" DOUBLE,
    "id" BIGINT,
    "state" VARCHAR,
    "urlname" VARCHAR,
    "category" STRUCT<"name" VARCHAR,
      "id" INT,
      "shortname" VARCHAR
    >,
    "group_photo" STRUCT<"highres_link" VARCHAR,
      "photo_link" VARCHAR,
      "photo_id" BIGINT,
      "thumb_link" VARCHAR
    >,
    "group_lat" DOUBLE
  >,
  "status" VARCHAR
) WITH (KAFKA_TOPIC='meetup_events', VALUE_FORMAT='JSON');

SELECT "id" FROM MEETUP_EVENTS_GERMANY EMIT CHANGES LIMIT 5;

CREATE STREAM MEETUP_EVENTS_GERMANY AS
    SELECT *
      FROM MEETUP_EVENTS
      WHERE `group`->`country`='de';

CREATE STREAM MEETUP_EVENTS_MUNICH AS
    SELECT *
      FROM MEETUP_EVENTS
      WHERE `group`->`city`='Munich' OR `group`->`city`='München';