require 'spec_helper'

feature 'Page preview' do
  context 'with logged in user' do
    background do
      create_user 'test@example.com'
      login_as 'test@example.com'
    end

    context 'with pages' do
      background do
        @page = create :page, name: 'nl1', locale: 'nl'
      end

      scenario 'see both languages', js: true do
        visit "/cmtool/pages/#{@page.id}"

      end
    end
  end
end
