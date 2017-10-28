class Dday < ApplicationRecord
    belongs_to :project

    scope :done, -> { where(success: true) }
    scope :left, -> { where(success: false) }

    def done
        self.success
    end
end
