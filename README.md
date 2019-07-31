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

3. Posgres Debugging
> ### Error: (DBConnection.ConnectionError) tcp connect (localhost:5432): mac os
> #### Detail: 
> This error happens usually if you restarted your Mac OS and the Posgres server hasn’t started up.

> #### Solution:
> You must make sure that the postgresql server is running. The easiest way to this on Mac OS X is through brew.
> Run the command `brew services start postgresql` 
> [elixir - mix ecto.create connection refused - Stack Overflow](https://stackoverflow.com/questions/44358515/mix-ecto-create-connection-refused#44358542)

# Production Guide:
## How to reset production db **WARNING NO BACK IS TAKEN**:
Run the following commands
```
gigalixir ps:remote_console

Ecto.Migrator.run(Profilo.Repo, Application.app_dir(:profilo, "priv/repo/migrations"), :down, [all: true])

Ecto.Migrator.run(Profilo.Repo, Application.app_dir(:profilo, "priv/repo/migrations"), :up, [all: true])

seed_script = Path.join(["#{:code.priv_dir(:profilo)}", "repo", "seeds.exs"])

Code.eval_file(seed_script)
```