# SmtpURL setup

This gem allows you to configure your smtp settings for mail and 
action mailer using a url.  The intention is to keep those settings
out of your code and allow easily setting them with an environment
variable.

## Installation

Either in your `Gemfile`:

    gem "smtp_url"

Or install it directly onto your system with rubygems:

    gem install smtp_url

Then require in your app:

    require "smtp_url"

## Usage

Use a URL like so:

    smtp://<user>:<password>@<hostname>:<port>/?<options>

Options is a query string of key value pairs and is used for setting
both the domain and authentication options. For example:

    smtp://user:secret@mailserver:587/?domain=test.com&authentication=digest

Only `hostname`, is required. Everything else is optional. It will
default to port 25 if it is not specified.

Set the URL in an enviroment variable in your server setup:

    export SMTP_URL=smtp://user:secret@mailserver:587/?domain=test.com

And then wherever you setup your smtp settings(often config/application.rb) add:

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = SmtpURL.parse ENV["SMTP_URL"]

## License

SmtpURL is MIT Licensed

Copyright (C) 2012 by Daniel Farrell

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

