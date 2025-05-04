#!/usr/bin/env ruby
require 'rspec'

# This wrapper makes InSpec tests discoverable by RSpec-based test explorers
# by converting InSpec controls to RSpec describe blocks

describe "Kitchen-Terraform Integration Tests" do
  context "GitHub Repository Plan" do
    it "should validate Terraform plan with InSpec" do
      # Run the actual InSpec command
      result = system("bundle exec kitchen verify")
      expect(result).to be_truthy
    end
  end
  
  context "Plan JSON Validation" do
    it "should generate valid plan JSON" do
      plan_path = 'kitchen-terraform-plan.json'
      expect(File.exist?(plan_path)).to be_truthy
      
      if File.exist?(plan_path)
        require 'json'
        plan_content = File.read(plan_path)
        expect { JSON.parse(plan_content) }.not_to raise_error
      end
    end
  end
end
