require "rails_helper"

describe "The Waiting on section" do
  it "displays each package delivery description", points: 1 do
    
    user_jacob = User.new
    user_jacob.email = "jacob_#{rand(100)}@example.com"
    user_jacob.password = "password"
    user_jacob.save

    visit "/users/sign_in"

    within(:css, "form") do
      fill_in "Email", with: user_jacob.email
      fill_in "Password", with: user_jacob.password
      click_on "Log in"
    end

    visit("/")

    date = 3.days.from_now

    within(:css, "form") do
      fill_in "Description", with: "New phone"
      fill_in "Supposed to arrive on", with: date
      fill_in "Details", with: "This package is important!"
      click_on "Log delivery"
    end
  
    within(:css, "div.waiting_on") do
      expect(page).to have_text(/New phone/)
    end
  end
end

describe "The Waiting on section" do
  it "displays the expected arrival date for each package", points: 1 do
    
    user_jacob = User.new
    user_jacob.email = "jacob_#{rand(100)}@example.com"
    user_jacob.password = "password"
    user_jacob.save

    visit "/users/sign_in"

    within(:css, "form") do
      fill_in "Email", with: user_jacob.email
      fill_in "Password", with: user_jacob.password
      click_on "Log in"
    end

    visit("/")

    date = 3.days.from_now.to_date

    within(:css, "form") do
      fill_in "Description", with: "New phone"
      fill_in "Supposed to arrive on", with: date
      fill_in "Details", with: "This package is important!"
      click_on "Log delivery"
    end

    within(:css, "div.waiting_on") do
      expect(page).to have_text(/Supposed to arrive on\s*#{date.to_s}/)
    end
  end
end

describe "The Waiting on section" do
  it "has a button to mark a delivery as received with the text 'Mark as received'", points: 1, hints: h("copy_must_match") do
    
    user_jacob = User.new
    user_jacob.email = "jacob_#{rand(100)}@example.com"
    user_jacob.password = "password"
    user_jacob.save

    visit "/users/sign_in"

    within(:css, "form") do
      fill_in "Email", with: user_jacob.email
      fill_in "Password", with: user_jacob.password
      click_on "Log in"
    end

    visit("/")

    date = 3.days.from_now

    within(:css, "form") do
      fill_in "Description", with: "New phone"
      fill_in "Supposed to arrive on", with: date
      fill_in "Details", with: "This package is important!"
      click_on "Log delivery"
    end

    expect(page).to have_tag("button", :text => /Mark as received/)
  end
end

describe "The Waiting on section" do
  it "has buttons to move each delivery packages to the \"Received\" section", points: 2 do
    
    user_jacob = User.new
    user_jacob.email = "jacob_#{rand(100)}@example.com"
    user_jacob.password = "password"
    user_jacob.save

    visit "/users/sign_in"

    within(:css, "form") do
      fill_in "Email", with: user_jacob.email
      fill_in "Password", with: user_jacob.password
      click_on "Log in"
    end

    visit("/")
    
    date = 3.days.from_now

    within(:css, "form") do
      fill_in "Description", with: "New phone"
      fill_in "Supposed to arrive on", with: date
      fill_in "Details", with: "This package is important!"
      click_on "Log delivery"
    end

    within(:css, "div.waiting_on") do
      click_on "Mark as received"
    end

    waiting_on_div = find("div.waiting_on")
    expect(waiting_on_div).to_not have_content(/New phone/)

    received_section_div = find("div.received")
    expect(received_section_div).to have_text(/New phone/)
  end
end
