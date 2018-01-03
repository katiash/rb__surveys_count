class Survey < ActiveRecord::Base

    validates :your_name, :dojo_loc, :fave_lang, presence: true
    # ADD LENGTH VALIDATION for any fields:
    validates :comment, presence: true, length: { in: 2..10 }
  
end
