# frozen_string_literal: true

# == Schema Information
#
# Table name: results
#
#  id         :bigint(8)        not null, primary key
#  date       :date             not null
#  number     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class Result < ApplicationRecord
end
