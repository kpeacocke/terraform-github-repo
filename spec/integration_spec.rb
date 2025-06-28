require 'rspec'
require 'json'

describe "Kitchen-Terraform Integration" do
  it "runs kitchen verify successfully" do
    result = system("bundle exec kitchen verify")
    expect(result).to be_truthy
  end

  it "generates a valid plan JSON file" do
    plan_path = 'kitchen-terraform-plan.json'
    expect(File.exist?(plan_path)).to be_truthy
    content = File.read(plan_path, encoding: "UTF-8")
    expect { JSON.parse(content) }.not_to raise_error
  end

  it "plan JSON has expected top-level keys" do
    plan_path = 'kitchen-terraform-plan.json'
    skip "plan file missing" unless File.exist?(plan_path)
    plan = JSON.parse(File.read(plan_path, encoding: "UTF-8"))
    expect(plan).to include("planned_values", "variables")
  end

  it "plan JSON has at least one github_repository resource" do
    plan_path = 'kitchen-terraform-plan.json'
    skip "plan file missing" unless File.exist?(plan_path)
    plan = JSON.parse(File.read(plan_path, encoding: "UTF-8"))
    rm = plan.dig("planned_values", "root_module")
    resources = []
    resources.concat(rm["resources"] || [])
    if rm.key?("child_modules")
      rm["child_modules"].each { |cm| resources.concat(cm["resources"] || []) }
    end
    expect(resources.any? { |r| r["type"] == "github_repository" }).to be true
  end
end
