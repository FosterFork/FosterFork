[![Build Status](https://travis-ci.org/FosterFork/FosterFork.svg?branch=master)](https://travis-ci.org/FosterFork/FosterFork)

# About

FosterFork is a web application written in Ruby on Rails. It helps people foster projects and displays them in a map view.
It is intended to be forked and used by people who raise campaigns, alliances, movements and suchlike and aims for connecting
interested parties and allowing them to collaborate.

# Features

Some of the key features of FosterFork are listed below. In order to explore the full functionality, it is highly recommended to
go ahead and install a local version of it (see below).

All texts, locations, phone numbers and suchlike which are visible in the screen shots used on this page are dummies,
auto-generated by the built-in data faker tool. The have no relation to real-world installations of FosterFork.

## Home screen

The home screen is the landing page for every user entering the site, and it looks like this. The entire site is
full internationalized, the language can be changed through a menu in the navigation. More languages can be added easily.

[![home](https://fosterfork.github.io/FosterFork/images/home.png)](https://fosterfork.github.io/FosterFork/images/home.png)

The contents of the dummy text block shown can be controlled through data records in the admin interface (see below).
TextBlock are also used in many other corners of FosterFork, such as the page to show the imprint, a contact page etc.

## Map

By clicking on the map icon in the navigation bar, or on the "Show on map" button on each project, a map view is opened.

[![map](https://fosterfork.github.io/FosterFork/images/map.png)](https://fosterfork.github.io/FosterFork/images/map.png)

Each marker in the map can be clicked, which brings up an overlay describing the project.

## Project view

Each project has a project view attached to it which shows all the relevant details of the project and allows for further actions
such as sharing.

[![project](https://fosterfork.github.io/FosterFork/images/project.png)](https://fosterfork.github.io/FosterFork/images/project.png)

Each project may have a stream of project owner controlled messages attached to it, each of which may allow comments by logged-in users.

[![project-messages](https://fosterfork.github.io/FosterFork/images/project-messages.png)](https://fosterfork.github.io/FosterFork/images/project-messages.png)

## Sign in

Certain actions such as adding new projects, commenting on projects etc require a user to be logged in. The sign in modal for that looks
like this.

[![signin-modal](https://fosterfork.github.io/FosterFork/images/signin-modal.png)](https://fosterfork.github.io/FosterFork/images/signin-modal.png)

## Adding new projects

Each logged in user is allowed to add a new project, which is unapproved in the first place and which must then be approved by an
administrator. The page to add a new project is shown here.

[![new-project](https://fosterfork.github.io/FosterFork/images/new-project.png)](https://fosterfork.github.io/FosterFork/images/new-project.png)

## Admin interface

FosterFork features a rich admin interface to control all details of the records stored in the database. We will only show the dashboard
in the screen shot below, but you'll get the gist:

[![admin-dashboard](https://fosterfork.github.io/FosterFork/images/admin-dashboard.png)](https://fosterfork.github.io/FosterFork/images/admin-dashboard.png)

# Installation

Please checkout out the [Wiki page](https://github.com/FosterFork/FosterFork/wiki/Installation) about installation.

# Configuration

Please checkout out the [Wiki page](https://github.com/FosterFork/FosterFork/wiki/Configuration) about configuration.

# License

All code in this repository is released under the [GNU Affero General Public License](https://www.gnu.org/licenses/agpl-3.0.en.html)
unless explicitly stated differently. Please refer to the `LICENSE` file for more detailed information.

# Contribute

To contribute, please clone the project and send [pull requests through GitHub](https://github.com/FosterFork/FosterFork/pulls).

Please make sure the test suite (run `rspec spec` on the command line) passes after your changes, and please add new tests
for new features.

# Bugs and suggestions

Please use the [Issue tracker on GitHub](https://github.com/FosterFork/FosterFork/issues) to submit ideas and bug reports.
