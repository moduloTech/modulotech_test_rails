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
5. Create a merge request from your project to the original one.

Your project must run under Docker, you must use PostgreSQL.

You are free to add as many controllers, actions, models, views and routes as you want but you can not remove 
what is originally present in this template. 

You are free to add, remove and replace **any** gem **except Modulorails, Devise, Pg and Rails (obviously)**.

## Evaluation

Your merge request will be evaluated directly on Github.

If your merge request is approved, you win an interview. If it is declined, this is the end of the process for you.

*Your merge request will never be merged for obvious reasons. ;)*

### Caveat

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

Practical commands:
```
rubocop -A # install the gem or extension

bundle exec rspec
```

Dependencies local: https://github.com/janko/image_processing
```
Mac: brew install imagemagick vips
Linux: sudo apt install imagemagick libvips

copy ex-env .env
```
