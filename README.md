# wrapid-db

![Alt text] (./schematic/diagram.png "Optional title")

##API

###Queries

####1. Get Extra profile

get_extra_profile -> (user_id: TEXT) -> TABLE()
```
SELECT * FROM get_extra_profile('theraccoun@gmail.com');
```

####2. Get Extra Form from Mapped Profile

map_extra_profile_fields -> (user_id: TEXT) -> TABLE()
```
SELECT * FROM map_extra_profile_fields('theraccoun@gmail.com');
```


###Mutations

####1. Register extra
Adds extra as user and fills out some of profile fields (first name, last name)

register_extra: (user_id: TEXT, password_salt: TEXT, first_name: TEXT, last_name: TEXT) -> TABLE(user_id, profile_field_id, input)
```
SELECT user_id, profile_field_id, input) FROM register_extra('text@email.com', 'wrapid', 'Test', 'Guy', 'J');
```
