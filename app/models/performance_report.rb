class PerformanceReport < ApplicationRecord
  has_many :executive_reports, dependent: :destroy
  
  attribute :selected_user

  before_create :define_data

  after_create :create_executive_reports

  validates :wanted_year, presence: true
  validates :selected_user, presence: true


  def create_executive_reports
      if selected_user =='all'
        User.where(profile: User.profiles[:Executive]).each do |executive|
          ExecutiveReport.create(user:executive, performance_report: self)
        end
      else
        ExecutiveReport.create(user_id:selected_user, performance_report: self)
      end
      
  end


  def define_data
    self.report_date=Time.now()
  end

  
  
end
