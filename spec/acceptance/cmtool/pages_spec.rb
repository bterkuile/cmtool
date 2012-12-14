require 'acceptance/acceptance_helper'

feature 'Pages index', %q{
  In order have pages
  As a user
  I want to see pages 
} do

  scenario 'visit root' do
    visit '/cmtool'
    page.current_path.should == '/users/sign_in'
  end
  context 'with logged in user' do
    background do
      create_user 'test@example.com'
      login_as 'test@example.com'
    end
    context 'without pages' do
      scenario 'list pages as root' do
        visit '/cmtool'
        page.should have_link 'New Page'
      end
    end

    context 'with pages' do
      background do
        @nl1 = create :page, name: 'nl1', locale: 'nl'
        @nl11 = create :page, name: 'nl11', locale: 'nl', parent_id: @nl1.id
        @nl111 = create :page, name: 'nl111', locale: 'nl', parent_id: @nl11.id
        @nl12 = create :page, name: 'nl12', locale: 'nl', parent_id: @nl1.id

        @en1 = create :page, name: 'en1', locale: 'en'
      end

      scenario 'see both languages' do
        visit '/cmtool'
        page.should have_link 'nl1'
        page.should have_link '- nl11'
        page.should have_link '- - nl111'
        page.should have_link '- nl12'
        page.should have_link 'en1'
      end
    end
  end
end
