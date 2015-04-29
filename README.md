# Hello Jason Portfolio

Written with [Ruby](https://www.ruby-lang.org/en/)+[Middleman](http://middlemanapp.com) and based on the [middleman-bss starter theme](https://github.com/hello-jason/middleman-bss)

**Included packages:**

* [Middleman](http://middlemanapp.com/)
* [Slim](http://slim-lang.com/)
* [Sass](http://sass-lang.com/)
* [Livereload](https://github.com/middleman/middleman-livereload)

**Included features:**

* Autoprefixer
* CSS reset
* Image compression
* Asset minification

## Setup in development

* Install [rbenv](https://github.com/sstephenson/rbenv) and [ruby-build](https://github.com/sstephenson/ruby-build#installing-as-an-rbenv-plugin-recommended)

* Clone project and cd into project directory

```bash
git clone git@gitlab.immense.net:sweets-and-treats/magento-transactional-emails.git && cd magento-transactional-emails
```

* Install Ruby version set in `.ruby-version`

```
rbenv install && rbenv rehash
```

* Set local ruby (this number should reflect the ruby version that was just installed)

```
rbenv local 2.2.2
```

* Install JavaScript runtime
You need a JS runtime. I suggest installing [Nodejs](http://nodejs.org/) via [node version manager (nvm)](https://github.com/creationix/nvm).

* Install gems

```
gem install bundler && bundle install
```

* Install node packages

```
npm install
```

* Copy `source/environment_variables.rb.sample` to `source/environment_variables.rb`

* Set `site_url_production` and `site_url_development` in `source/environment_variables.rb`

* Start Middleman server

```bash
bundle exec middleman
```

## Building

Build the project, then run premailer:

```bash
bundle exec middleman build
gulp
```

Copy the contents of each template in `premailer/email-templates` to their respective WYSIWYG box in Magento > System > Transactional Emails

# TODO

* Rake task to build, premailer
* Finish rest of email templates
