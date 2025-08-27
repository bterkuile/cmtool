# Cmtool
[<img src="https://secure.travis-ci.org/bterkuile/cmtool.png?branch=master"
alt="Build Status" />](http://travis-ci.org/bterkuile/cmtool)
## About
Cmtool is a CMS to give you a quickstart for a website using CouchDB as
database backend. It is in developing stage, but already used in production.
It is designed as an engine. The thought behind is that you will have to
create your own rails website, but get a lot of stuff for free. These things
are:

*   User management
*   Page management
*   Faq
*   News
*   Newsletter subscriptions
*   Directory manager
*   Image manager


## Setup
To start using Cmtool as website CMS add it to your Gemfile. Since it  depends
on github gems and gem dependencies do not support those you have to
explicitly add two dependencies to your Gemfile:
    gem 'couch_potato' , github: 'bterkuile/couch_potato'
    gem 'simply_stored' , github: 'bterkuile/simply_stored'
    gem 'cmtool'

Make sure that the locales you want to work with are specified in
```config/application.rb```.
```ruby
  config.i18n.default_locale = :en
  config.i18n.available_locales = [:en, :nl]
```

This will add some gems you might like anyway, here a list:

*   bourbon # NOOOOOO
*   jquery-rails
*   sass-rails
*   paperclip
*   email_validator (validates :email, email: true)


### Controllers

in `app/controllers/pages_controller.rb`:

```ruby
class PagesController < ApplicationController
  include Cmtool::Includes::PagesController
end
```

### Securing

Cmtool is looking for an authorize_cmtool method present in the application
controller. Something like:

```ruby
class ApplicationController
  ...

  private

  def authorize_cmtool
    redirect_to main_app.root_path, alert: t('general.unauthorized') unless current_user.present? && current_user.is_admin?
  end
end
```

### Routing

Add the following routes with changes according to your application:
```ruby
ALLOWED_LOCALES = /nl|de|fr|en|es/
devise_for :users, :controllers => {:sessions => 'cmtool/sessions', :passwords => 'cmtool/passwords'}
mount Cmtool::Engine => '/cmtool'
get '/:locale' => 'pages#home', constraints: {locale: ALLOWED_LOCALES}, as: :go_to_locale
get '/sitemap(.:format)' => 'pages#sitemap'
scope '(/:locale)', constraints: {locale: ALLOWED_LOCALES}, defaults: { locale: :nl } do
  root to: 'pages#home'
  get "/:name" => "pages#show", constraints: {name: /.*/},  as: :page
end
get "/*url" => "pages#not_found"
```

### User model
The user model is important. We recommend you to create your own user model:
```ruby
class User
  include Cmtool::User

end
```

This is enough to start using Cmtool. But probably you want to add some
goodies of your own. Remember that this is a SimplyStored model with almost
all the ActiveModel features.

### Page model
The page model allows you to control some interesting things.

in `app/models/page.rb`:
```ruby
class Page
  include Cmtool::Includes::Page

  # Define the layouts you want to use in your website. Be sure to create them in
  # app/views/layouts/...
  # The first specified layout will become the default
  def self.layouts
    %w[application home contact]
  end
end
```

### Controlling the language of the system
If you add a method `cmtool_locale` to your application controller Cmtool will
take this value:
```ruby
class ApplicationController
  before_action :set_locale

  private

  def set_locale
    # Do some magic
    I18n.locale = :en
  end

  def cmtool_locale
    I18n.locale
  end
end
```

### Customize a page
All pages by default are rendered using the view: app/pages/show. So adding
and changing this file will change all displayed pages without their own
specific page. To create a specific page, create a page with the name of the
page you created in the Admin section. If for example you have created a page
with the name: about Then you can give this page a custom look using the view:
`app/views/about.html.slim` 

### The menu and getting pages

### Customize your 404
You can customize what is shown when a page cannot be found. There is a
standard view app/pages/404.html.erb with the following content:

    <%= render template: 'pages/show' %>

Overwrite this to get another page as show. To controll the content of the 404
page, create a page in the Admin area having the name: 404.  You can make a
404 page for every language in this manner. Here you can also give a custom
layout if you do not want to use the default layout.
