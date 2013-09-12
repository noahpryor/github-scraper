# == Schema Information
#
# Table name: gemfiles
#
#  id            :integer          not null, primary key
#  repository_id :integer
#  url           :text
#  contents      :text
#  last_checked  :datetime
#  created_at    :datetime
#  updated_at    :datetime
#

class Gemfile < ActiveRecord::Base
end
