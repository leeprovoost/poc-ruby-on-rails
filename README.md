# music-app

Playground to test Ruby on Rails

# Development

Create new Github repository using the name music-app. Initialise for Ruby language.

Check out repo: `git clone it@github.com:leeprovoost/music-app.git`

Generate skeleton app:
```
cd music-app
rails new .  (don't overwrite .gitignore)
rm README.rdoc
```

Add models:
```
rails g scaffold Dj artist_name:string
rails g scaffold Track title:string dj:references duration:string
```

Install and configure Imagemagick: 
```brew install imagemagick```

Retrieve install path of Imagemagick (in my case /usr/local/bin/convert): 
```which convert``` 

Add Paperclip path to `config/environments/development.rb`:
```
# Paperclip
Paperclip.options[:command_path] = "/usr/local/bin/"
```

Add Paperclip (https://github.com/thoughtbot/paperclip) gem to Gemfile
```
# Paperclip
gem "paperclip", "~> 4.2"
```
Install gem:
```
bundle install
```

Update Track model (`app/models/track.rb`):
```
class Track < ActiveRecord::Base
 	belongs_to :dj

  	has_attached_file :audio
	validates_attachment_content_type :audio, :content_type => [ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ]
end
```

Generate migration for Paperclip:
```
rails generate paperclip track audio
```



## Useful links

http://stackoverflow.com/questions/1751537/paperclip-validates-attachment-content-type-for-mp3-triggered-when-attaching-mp3



