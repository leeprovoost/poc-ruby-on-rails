class Track < ActiveRecord::Base
 	belongs_to :dj

  	has_attached_file :audio
	validates_attachment_content_type :audio, :content_type => [ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ]

  	has_attached_file :track_art, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  	validates_attachment_content_type :track_art, :content_type => /\Aimage\/.*\Z/
end