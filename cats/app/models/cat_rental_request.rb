class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, inclusion: ["PENDING", "APPROVED", "DENIED"]
  validate :temporally_possible
  validate :conflicting_request

  belongs_to :cat

  def approve!
    CatRentalRequest.transaction do
      update!(status: "APPROVED")
      overlapping_pending_requests.each(&:deny!)
    end
  end

  def deny!
    update!(status: "DENIED")
  end

  def pending?
    status == "PENDING"
  end

  def temporally_possible
    if (end_date - start_date).to_i < 0
      errors.add(:temporal, "You are not a time traveler")
    end
  end

  def overlapping_requests
    CatRentalRequest.where("start_date BETWEEN :sd AND :ed OR end_date BETWEEN :sd AND :ed", ed: end_date, sd: start_date)
      .where(cat_id: cat_id).where.not(id: id)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: "PENDING")
  end

  def conflicting_request
    unless overlapping_approved_requests.empty?
      errors.add(:temporal, "Cat not available for these dates")
    end
  end
end
