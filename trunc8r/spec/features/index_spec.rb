require 'rails_helper'
require 'benchmark'

feature 'Index' do
  scenario 'Displays the tagline on the index', js: true do
    visit root_path

    expect(page).to have_content 'trunc8r makes your links shorter than you ever thought possible.'
  end

  scenario 'Clicking shorten with no url shows an error', js: true do
    visit root_path
    first('.link_shortener__button').click

    expect(first('.link_shortener__response')).to have_content("Url can't be blank")
  end

  scenario 'Clicking shorten with an invalid url shows an error', js: true do
    visit root_path
    first('.link_shortener__input').set('httpz://google.com')
    first('.link_shortener__button').click

    expect(first('.link_shortener__response')).to have_content('Url must be a valid url')
  end

  scenario 'Entering text that does not partially match http(s) shows an error', js: true do
    visit root_path
    first('.link_shortener__input').set('a')
    expect(first('.link_shortener__response')).to have_content('Url must be a valid url')

    first('.link_shortener__input').set('h')
    expect(page).not_to have_css('.link_shortener__response')

    first('.link_shortener__input').set('https://a')
    expect(page).not_to have_css('.link_shortener__response')
  end

  scenario 'Clicking shorten with an valid url displays a short link', js: true do
    visit root_path
    first('.link_shortener__input').set('https://google.com')
    first('.link_shortener__button').click

    expect(first('.link_shortener__response')).to have_content("Here's your short url:")
  end

  scenario 'Visiting a short url redirects you to the long url', js: true do
    long_url = 'http://example.com'
    visit root_path

    first('.link_shortener__input').set(long_url)
    first('.link_shortener__button').click

    short_url = find('#short_url')['innerHTML']

    visit short_url

    expect(page.current_url).to eq(long_url + '/')
  end
end
