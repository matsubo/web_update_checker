require 'spec_helper'

describe WebUpdateChecker do

  let(:url) { 'http://example.com/' }
  let(:regex) { /<h1>(.*)<\/h1>/ }

  before do
    WebUpdateChecker::Checker.new(url).cleanup
  end

  let(:mail) do
    mail = Mail.new do
      from    'TODO@example.com'
      to      'TODO@example.com'
      subject 'Web site is updated!'
      body     url
    end

    mail.delivery_method :smtp, {
      address:   'localhost',
      port:      25,

      #      address:   'smtp.gmail.com',
      #      port:      587,
      #      user_name: '<TODO>',
      #      password:  '<TODO>',
      #      authentication: 'plain',
      #      enable_starttls_auto: true
    }

  end


  it 'should have a version number' do
    expect(WebUpdateChecker::VERSION).to_not be_nil
  end

  it 'should initialize temporary file' do
    expect(WebUpdateChecker::Checker.new(url).execute).to be_nil
  end


  it 'should be return as same contents' do
    expect(WebUpdateChecker::Checker.new(url).execute).to be_falsey
  end


  it 'should be return as different contents' do

    url = 'http://www.yahoo.co.jp/'
    expect(WebUpdateChecker::Checker.new(url).execute).to be_falsey
    expect(WebUpdateChecker::Checker.new(url).execute).to be_truthy

  end

  #  it 'should be send a notification mail' do
  #
  #    WebUpdateChecker::Checker.new(url, regex, mail).execute.should be_true
  #
  #  end
  #

end
