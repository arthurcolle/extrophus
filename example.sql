select places.id, places.name, places.loc as loc, earth_distance(ll_to_earth(-77, 39.1), ll_to_earth(loc[0], loc[1])) as distance from places order by distance ASC;


select places.id, places.name, places.loc as loc, earth_distance(ll_to_earth(39.056270, -77.129953), ll_to_earth(loc[0], loc[1])) as distance from places order by distance ASC;


insert into places (id, name, loc) values (7, '401 nina place', POINT(39.056270, -77.129953));
insert into places (id, name, loc) values (6, '4800 berwyn house road', POINT(38.990928, -76.929503));