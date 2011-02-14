require 'paperclip_bug_fixes'
class MediaItem < ActiveRecord::Base
  belongs_to :depositor, :class_name => 'User'
  has_many :transcripts, :dependent => :nullify

  scope :are_private, where(:private => true)
  scope :are_public, where(:private => false)

  include Paperclip
  has_attached_file :original,
    :url => "/system/media_item/:attachment/:id/:style/:filename",
    :styles => lambda { |attachment|
      if attachment.instance.format == 'video'
        {
          :video => {
            :format     => :ogg,
            :geometry   => '320x240',
            :processors => [ :kickvideo_video ],
          },
          :poster => {
            :format     => :png,
            :position   => 5,
            :geometry   => '320x240',
            :processors => [ :kickvideo_thumbnailer ],
          },
          :thumbnail => {
            :format     => :png,
            :position   => 5,
            :geometry   => '160x120',
            :processors => [ :kickvideo_thumbnailer ],
          }
        }
      else
        {
          :audio => {
            :format     => :ogg,
            :processors => [ :kickvideo_audio ],
          },
        }
      end
    }

  process_in_background :original

  attr_accessible :title, :description, :recorded_on, :copyright, :license, :private, :format, :original

  FORMATS = %w{audio video}

  validates :format, :presence => true, :inclusion => { :in => FORMATS }
  validates :depositor,     :presence => true

  validates :title,         :presence => true
  validates :description,   :presence => true
  validates :depositor,     :presence => true, :associated => true
  validates :recorded_on,   :presence => true
  validates :copyright,     :presence => true
  validates :license,       :presence => true

  validates_attachment_presence :original
  validates_attached_media :original

end
