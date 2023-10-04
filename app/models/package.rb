# == Schema Information
#
# Table name: packages
#
#  id         :integer          not null, primary key
#  delivered  :boolean          default(FALSE)
#  desc       :text             not null
#  expected   :date             not null
#  notes      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :integer          not null
#
# Indexes
#
#  index_packages_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  owner_id  (owner_id => users.id)
#
class Package < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  scope :missing_packages, -> { where(delivered: false) }
  scope :delivered_packages, -> { where(delivered: true) }
end
