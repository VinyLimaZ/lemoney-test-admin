![build status](https://vinylimaz.semaphoreci.com/badges/lemoney-test-admin.svg)

# README

## What are all this sheeet?

Hello guys, I'm Vinicius and that's my solution to the problem you
brought to me :D

## Versions
* Ruby version
2.6.5
* Rails version
6.0.2
* Postgres
12.2

# How to?

- First `bundle install`
- Second `rails db:create db:migrata db:setup`
- Third `yarn install --check-files` (I have had to remove this, but the time is
    short to see how to do this, so we have to deal with it)
- Fourth `rspec`
- Fifth `rails s`

## For lazy people like all oldscholl programmers and I, even I being a noob

[CLICK HERE TO GO TO ~~narnia~~ Heroku!](https://lemoney-test-admin.herokuapp.com/offers)

## A little explanation about my solution:

- Scaffold to generate project structure;
- Removed some dependencies and files;
- Created a component to help validate the URL (And needs another detail to be
    perfect, but this handle good the problem);
- Created another component to take care of the state enable/disable and to know
    which offers state;
- Added a decorator to translate the state in word;
- Added feat specs;

==============================================================

Enjoy and hire me, please (͡ ° ͜ʖ ͡ °)

==============================================================


