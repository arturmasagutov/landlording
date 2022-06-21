# frozen_string_literal: true

module SubscriptionsHelper

  def process_plan(user)
    plan_heading(user) if user.subscription.present?
  end

  private

  def plan_heading(user)
    case user.subscription&.plan
    when 'free'
      { name: 'Free Account', description: free_description }
    when 'premium_trail'
      { name: 'Trial', description: }
    when 'premium_monthly'
      { name: 'Monthly Plan', description: }
    when 'premium_annual'
      { name: 'Annual Plan', description: }
    else
      ''
    end
  end

  def free_description
    'Limited access to our legal document library and online rental application tool,
     Free account.'
  end

  def description
    'Unlimited access to our legal document library and online rental application tool,
     billed monthly.'
  end

end
