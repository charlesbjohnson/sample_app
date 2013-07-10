require 'spec_helper'

describe "Static Pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_content(heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'Sample App' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_title(full_title(' | Home')) }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        50.times { FactoryGirl.create(:micropost, user: user) }
        sign_in user
        visit root_path
      end
      after { Micropost.delete_all }

      it { should have_content(user.microposts.count) }
      it { should have_selector('div.pagination') }

      it "should render the user's feed" do
        user.feed.paginate(page: 1) do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end
  end

  describe "Help page" do
    before { visit help_path }
    heading_and_title = 'Help'
    let(:heading)    { heading_and_title }
    let(:page_title) { heading_and_title }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    heading_and_title = 'About Us'
    let(:heading) { heading_and_title }
    let(:page_title) { heading_and_title }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    heading_and_title = 'Contact'
    let(:heading) { heading_and_title }
    let(:page_title) { heading_and_title }

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About Us'))

    click_link "Help"
    expect(page).to have_title(full_title('Help'))

    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))

    click_link "Home"
    expect(page).to have_title(full_title(''))

    click_link "Sign up now!"
    expect(page).to have_title(full_title('Sign up'))

    click_link "sample app"
    expect(page).to have_title(full_title(''))
  end
end
