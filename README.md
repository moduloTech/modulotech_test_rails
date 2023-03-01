# Modulotech Rails technical test

This is the base for your Ruby on Rails technical test to become a [modulohacker](https://www.modulotech.fr).

## Wording

This project is a blank slate for a clone of [Airbnb](https://www.airbnb.com).

This is a Rails 7 project using import map for Javascript assets and Sprockets for CSS assets.

It is preconfigured with PostgreSQL, Bootstrap 5, Turbo and Stimulus.

It was generated using Modulotech's template: this includes Dockerfile, docker-compose.yml, Rubocop and Bundler-audit.

## Instructions

1. Fork this project.
2. Implement all `TODO` present in the code.
3. Ensure your application is fully functional.
4. Ensure the Rubocop is green.

## Evaluation

Modulotech works with Docker for development environment and deploys using Kubernetes.

Your technical test **will** be run under Docker.

*If you do not know about Docker, I advise you to [get Docker](https://docs.docker.com/get-docker/) and take some minutes
to [get started](https://docs.docker.com/get-started/).*

- If your project does not work on Docker, you lose points.
- If you did not implement all the `TODO`, you lose points.
- If your project is not Rubocop-compliant, you lose points.
- If your implementation of the `TODO` is good, you win points.
- If you implement unexpected features, you win points.
- If your UI/UX is good, you win points.

Your goal is to win the maximum of points and to impress me!

You are free to add, remove and replace **any** gem **except Modulorails, Pg and Rails (obviously)**.
