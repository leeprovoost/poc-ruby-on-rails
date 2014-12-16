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





