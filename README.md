## Installation Guide:
1. Install Elixir:
  a. Mac use homebrew: https://elixir-lang.org/install.html
  b. Windows use installer: https://elixir-lang.org/install.html
  
2. Install PosgreSQL:
  a. Mac: https://www.youtube.com/watch?v=5AOkxqFaYEE
  b. Windows: https://www.youtube.com/watch?v=BLH3s5eTL4Y
  
3. Install PosgreSQL client for mac:
  a. https://eggerapps.at/postico/

## Setup Guide
1. `git clone https://github.com/venomnert/Profilo.git`
2. `cd Profilo`
3. `mix deps.get`
4. `mix ecto.create`
5. `mix ecto.migrate`
6. `yarn install`

## Startup Guide
After you have completed the above steps without any error, you can now run phoenix server:
`mix phx.server`

## Troubleshooting
1. How to login into psql locally
> `'psql -U someuser -h 127.0.0.1 database`
[See styuluseater comment](https://stackoverflow.com/questions/18664074/getting-error-peer-authentication-failed-for-user-postgres-when-trying-to-ge)

2. How to resove missing `MAKE` error:
> `sudo apt-get install build-essential`
[See kevinwo comment](https://www.digitalocean.com/community/tutorials/how-to-automate-elixir-phoenix-deployment-with-distillery-and-edeliver-on-ubuntu-16-04)
