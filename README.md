# README

* Ruby version

   ruby 3.1.4

* Configuration

   The application uses https://ipstack.com/ as a service provider for geolocation data. The service provider info is configured in the configuration file:

        config/server_configuration.yml

    e.g.
    
      geo_service_providers:
        default: ipstack

        ipstack:
          api_url: "https://api.ipstack.com/%s?access_key=%s"
          api_access_key: "hfiewhf4375654dfndfndgdggg4534"
          adapter: IpstackAdapter    

* Database creation

   We use MySQL for now. It can be any kind of database. The database is configured in the DB configuration file:

      config/database.yml

   $ bundle exec rake db:create

* Database initialization

   $ bundle exec rake db:migrate

* How to run the test suite

   use Rspec

   $ rspec spec/controllers/geolocations_controller_spec.rb

* the application features

   The application contains 4 Ruby APIs which can add, delete or provide geolocation data on the base of ip address.

     1. add geolocation data in the database for a specific ip address 

         POST /geolocations/xxx.xxx.xxx.xxx

     2. add geolocation data in the database for the current user client ip address

         POST /geolocations

     3. query geolocation data from the database for a specific ip address

         GET /geolocations/xxx.xxx.xxx.xxx

     4. delete geolocation data from the database for a specific ip address

         DELETE /geolocations/xxx.xxx.xxx.xxx



