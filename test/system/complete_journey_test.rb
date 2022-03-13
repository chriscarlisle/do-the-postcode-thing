require "application_system_test_case"

class CompleteJourneyTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit "/"
  
    ["SE1 7QD", "SE1 7QA", "SH24 1AA", "SH24 1AB"].each do |postcode|
      fill_in "postcode", with: postcode
      click_on "Check!"
      assert_text "No!"
      click_on "Close"
    end

    visit "http://admin:password@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}/admin/serviced_postcodes"
    
    click_on "New"
    fill_in "serviced_postcode_postcode", with: "SH24 1AA"
    click_on "Create Serviced postcode"
    
    click_on "Serviced postcodes"
    click_on "New"
    fill_in "serviced_postcode_postcode", with: "SH24 1AB"
    click_on "Create Serviced postcode" 

    click_on "Serviced lsoas"
    click_on "New"
    fill_in "serviced_lsoa_lsoa_prefix", with: "Southwark"
    click_on "Create Serviced lsoa"

    click_on "Serviced lsoas"
    click_on "New"
    fill_in "serviced_lsoa_lsoa_prefix", with: "Lambeth"
    click_on "Create Serviced lsoa"

    visit "/"
    ["SE1 7QD", "SE1 7QA", "SH24 1AA", "SH24 1AB"].each do |postcode|
      fill_in "postcode", with: postcode
      click_on "Check!"
      assert_text "Yes!"
      click_on "Close"
    end
  end
end
