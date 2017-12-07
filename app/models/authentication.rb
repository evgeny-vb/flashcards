# frozen_string_literal: true

# Model responsible for storing oauth authentications
#
class Authentication < ActiveRecord::Base
  belongs_to :user
end
