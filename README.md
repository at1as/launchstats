# Launchstats

Easily search through historical and upcoming rocket launch data

## Demo

Try it on [Heroku](https://launchstats.herokuapp.com/stats/search)


## Data

Uses [LaunchLibrary](http://launchlibrary.net/1.2/docs/api.html) to provide details about:

* Launch Name
* Rocket Family
* Launch Pad
* Launch Date
* Mission Details
* etc


## Screenshot

<img src="https://at1as.github.io/github_repo_assets/launchstats1.png" width="550px">


## Usage 

Built on Elixir 1.3 and Erlang/OTP 19. Ensure these exist on your system

* Install elixir dependencies `mix deps.get`
* Install js dependencies `npm install`
* Start server `mix phoenix.server`

Visit [`localhost:4000`](http://localhost:4000) from your browser


