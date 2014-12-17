# music-app

Playground to test Ruby on Rails. This focuses on file uploads.

## Development

### Set up application foundation

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

Add default page to your routes `config/routes.rb`:
```
MusicApp::Application.routes.draw do

  resources :tracks
  resources :djs

  root to: "tracks#index"
end
```

### Add Paperclip for file uploads

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

### Add Paperclip upload support for tracks

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

Update `app/views/tracks/_form.hmtl.erb`:
```
<%= form_for @track, :url => track_path, :html => { :multipart => true } do |f| %>
  <% if @track.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(@track.errors.count, "error") %> prohibited this track from being saved:</h2>

      <ul>
      <% @track.errors.full_messages.each do |msg| %>
        <li><%= msg %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

  <div class="field">
    <%= f.label :title %><br>
    <%= f.text_field :title %>
  </div>
  <div class="field">
    <%= f.label :dj %><br>
    <%= f.text_field :dj %>
  </div>
  <div class="field">
    <%= f.label :duration %><br>
    <%= f.text_field :duration %>
  </div>
  <div class="field">
    <%= f.label :audio %><br>
    <%= form.file_field :audio %>
  </div>
  <div class="actions">
    <%= f.submit %>
  </div>
<% end %>
```

Allow file to be uploaded in the Tracks controller (`app/controllers/tracks_controller.rb`). Add `:audio` to `params.require`:
```
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track
      @track = Track.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def track_params
      params.require(:track).permit(:title, :dj_id, :duration, :audio)
    end
 ```

Run database migration: 
```
rake db:migrate
```

### Add Soundmanager 2 HTML5 music player

We are going to use Soundmanager 2, which you can download here: http://www.schillmania.com/projects/soundmanager2/doc/download/. 

Add the file `soundmanager2.js` to `app/assets/javascripts`. 

Add the files `demo/bar-ui/css/bar-ui.css` and `demo/bar-ui/script/bar-ui.js` to the respective `apps/assets/stylesheets` and `apps/assets/javascripts` folders.

Add references to your assets in the `app/views/layouts/application.html.erb` file:
```
<head>
  <title>MusicApp</title>
  <%= stylesheet_link_tag    "application", media: "all", "data-turbolinks-track" => true %>
  <%= stylesheet_link_tag    "bar-ui" %>
  <%= javascript_include_tag "application", "data-turbolinks-track" => true %>
  <%= javascript_include_tag "bar-ui" %>
  <%= javascript_include_tag "soundmanager2" %>
  <%= csrf_meta_tags %>
</head>
```

Add the contents of the `image` folder to `app/assets/images`.

Open the file `app/assets/stylesheets/bar-ui.css` and do a replace all of `url(../image/` with `url(/assets/`.

You need to add the following code in your `app/views/tracks/index.html.erb`:
```
<div class="sm2-bar-ui flat">
 <div class="bd sm2-main-controls">
  <div class="sm2-inline-texture"></div>
  <div class="sm2-inline-gradient"></div>
  <div class="sm2-inline-element sm2-button-element">
   <div class="sm2-button-bd">
    <a href="#play" class="sm2-inline-button play-pause">Play / pause</a>
   </div>
  </div>
  <div class="sm2-inline-element sm2-inline-status">
   <div class="sm2-playlist">
    <div class="sm2-playlist-target">
     <noscript><p>JavaScript is required.</p></noscript>
    </div>
   </div>
   <div class="sm2-progress">
    <div class="sm2-row">
    <div class="sm2-inline-time">0:00</div>
     <div class="sm2-progress-bd">
      <div class="sm2-progress-track">
       <div class="sm2-progress-bar"></div>
       <div class="sm2-progress-ball"><div class="icon-overlay"></div></div>
      </div>
     </div>
     <div class="sm2-inline-duration">0:00</div>
    </div>
   </div>
  </div>
  <div class="sm2-inline-element sm2-button-element sm2-volume">
   <div class="sm2-button-bd">
    <span class="sm2-inline-button sm2-volume-control volume-shade"></span>
    <a href="#volume" class="sm2-inline-button sm2-volume-control">volume</a>
   </div>
  </div>
 </div>
 <div class="bd sm2-playlist-drawer sm2-element">
  <div class="sm2-inline-texture">
   <div class="sm2-box-shadow"></div>
  </div>
  <div class="sm2-playlist-wrapper">
    <ul class="sm2-playlist-bd">
     <li><a href="<%= track.audio.url %>">< <%= track.title %></a></li>
    </ul>
  </div>
 </div>
</div>
```

### Add support for uploading track cover art



## Run 

```rails s```

Open browser: `http://localhost:3000`.


## Useful links

* http://stackoverflow.com/questions/1751537/paperclip-validates-attachment-content-type-for-mp3-triggered-when-attaching-mp3
* http://www.schillmania.com/projects/soundmanager2/
* http://stackoverflow.com/questions/6510006/add-a-new-asset-path-in-rails-3-1



