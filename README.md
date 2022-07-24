# HasJam

Website of the Hascord #stem-comp-sci hackathons.

## Environment Variables

- Create a `.env` file with the necessary info based on the outline provided in `sample.env`

## Run Locally

### Client

Please install the latest Node.JS version available for your platform. Then do the following steps:

1) Clone the repository
2) Move into the project directory with `cd HasJam/Client`
3) Install dependencies with `yarn install`
4) Start the server with `yarn run dev`

### API

We recommend running the API server locally via Docker, as Swift can be fairly finicky with non-macOS platforms. Not to say running Swift on Windows and Linux is impossible—official builds are available for each on [The Swift Project's homepage](https://swift.org/). However, the Dockerfile will provide the best development experience, complete with development database et al, out of the box without much in the way of hassle.

If you decide to run via local, non-Docker builds, please look at the following steps:

1) Install **Swift 5.6** onto your local machine (guides available on [Swift.org](https://swift.org/))
2) Install the latest PostgreSQL version as well
3) Clone the repository
4) Move into the project directory with `cd HasJam`
5) Install dependencies with `swift package resolve`
6) Start the server with `vapor run`

Docker instructions are as follows:

1) Clone the repository
2) Move into the project directory with `cd HasJam`
3) Run `docker compose up`
