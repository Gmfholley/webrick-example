# Description

Practice making a simple WEBrick server with some rails-y practices.

1. CSV/File as data store
1. MVC pattern
1. Resourceful routes

Warning: Do not run in prod!

## Running locally

1. Install pry/ruby

    ```sh
    $ bundle install
    ```
1.  Create an empty CSV file for the data store.
    ```sh
    $ touch db/Game.csv
    ```
1. Run the server
    ```sh
    $ bin/serve
    ```
   Go to http://localhost:8000 to begin seeing changse
