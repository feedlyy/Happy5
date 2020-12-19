# HOW TO INSTALL

##### Prerequisites

The setups steps expect following tools installed on the system.

- Ruby [2.7.0p0]
- Rails [6.1.0]

[comment]: <> (#### Database design)

[comment]: <> (![Database]&#40;https://user-images.githubusercontent.com/33906363/85913738-84f1d080-b861-11ea-8e50-8fca856a01ab.png&#41;)

##### 1. Clone the repository

```bash
git clone https://github.com/feedlyy/Happy5.git
```

##### 2. Install all dependencies

```bash
1. run yarn install
2. run bundle install
```

##### 3. Database setup 
Database for this project are PostgreSQL

Create the database, this will create database with name happy5
```ruby
rake db:create
```

Or edit this from database.yml according to your setup

```bash
default: 
port: 5432 (your db port)
username: postgres (your username for postgre)
password: postgres (your password for postgre)

development:
  <<: *default
  database: happy5 (your database name)
```

Migrate the migrations

```ruby
rake db:migrate
```

Run the seeder
```ruby
rake db:seed
```
Those will generate data:
```
- username: user1, password: pwduser1
- username: user2, password: pwduser2
- username: user3, password: pwduser3
- username: user4, password: pwduser4
```

##### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s or rails s
```

And now you can visit the site with the URL http://localhost:3000

# EXTRA

##### 1. Authentication
This project use jwt authentication, 
so please login first to '/auth/login'.
After you loggin using username and password, 
you will get a token for you use in your header as Authorization.
List that protected are:
```bash
1. resource :user
2. post '/send' -> send chat to user
3. post '/reply' -> reply chat
4. get '/read' -> read incoming chat
5. get '/list' -> list all chat
```

##### 2. Validation
Every post method requires param, and there will be validation
if the param is missing. hint: 
```bash
Make sure you access '/read' for see the incoming message before
you reply the other message ('/reply') otherwise you will be get error.
```

##### 3. Pagination
This project also have pagination on get method, limited
by 3 each data, so please
include param "page" for see the other results.