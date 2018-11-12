![LandWise](https://raw.githubusercontent.com/CKDev/resource-equity/master/app/assets/images/landwise-logo.png)

# LandWise - Resource Equity

| *Ruby Version* | *Rails Version* | *PostgreSQL Version* | *Redis Version* |
|----------------|-----------------|----------------------|-----------------|
| 2.5.1          | 5.2.1           | 10.5                 | 3.2.12          |

### System Dependencies

* Redis (volatile instance for cache and persistent for Sidekiq)
* PostgreSQL

### Initial Setup

* Clone this repo to your machine.
* `cd` into root directory
* Run `bundle install`
* Create `config/master.key` and paste in the encryption key (contact any member of this repo to get it, or find it in the CKD Dashlane account)
* Run `bundle exec rake db:create db:migrate db:seed`

### Testing

Rspec is used on this project, which can be run with: `bundle exec rspec`

### Deployment instructions

Deployment is done via Heroku automatically upon pushing to the master branch. See the "Deploy" tab under the resourceequity-staging Heroku account for specific config. Resource Equity operates under a Heroku pipeline, so deploying to production first involves deploying the staging site, then "promoting" the staging environment to production from the pipeline dashboard page.

### Developer Norms/Standards

The purpose of this section is to layout the norms of this project. Future development should follow the standard set forth in this guide.

Rubocop is used on this project, which defines the Ruby styling agreed upon for this project. The rules are bendable, but a best effort should be made to stay within the rubocop checks. At the time of MVP, the Rubocop checks all passed.

### Git Commits

Git commits are like any other piece of code, and should be done with intention. There are two parts to the commit - the
title and the body. The title in Github is limited to 50 characters, so the first line of a commit should also be limited to 50 characters. The body is limited to 72 characters in width, make sure your lines are no longer than 72 characters.

More importantly, a title should have a tag like [CHG], [FEAT], [REFAC], [BUG], [TOOL], etc, so that when a release is made, the corresponding changes are all easily visible. The body of a commit should list the why, not the how. The how should be obvious by the corresponding code changes. The title should be in the active voice, i.e. "Change timeout to two hours", not "Changes timeout to two hours." An easy way to remember this is that the commit title should finish the sentence, "If I pull in this change it will ..."

Commits should be "squashed" into atomic chunks of code, usually corresponding with a full feature or change. WIP commits are not within the code standards of this project. Any checkin should be deployable, without having to consider the surrounding commits.
