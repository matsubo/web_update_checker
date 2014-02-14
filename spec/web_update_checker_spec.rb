require 'spec_helper'

describe WebUpdateChecker do

  before(:all) do
    @url = 'http://example.com/'
    WebUpdateChecker::Checker.new(@url).cleanup
  end

  before(:each) do

    @regex = /<h1>(.*)<\/h1>/

    @mail = Mail.new do
      from    'TODO@example.com'
      to      'TODO@example.com'
      subject 'Web site is updated!'
      body     @url
    end

    @mail.delivery_method :smtp, {
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
    WebUpdateChecker::VERSION.should_not be_nil
  end

  it 'should initialize temporary file' do

    WebUpdateChecker::Checker.new(@url).execute.should be_nil

  end


  it 'should be return as same contents' do

    WebUpdateChecker::Checker.new(@url).execute.should be_false

  end


  it 'should be return as different contents' do

    url = 'http://www.yahoo.co.jp/'
    WebUpdateChecker::Checker.new(url).execute.should be_true

  end


#  it 'should be send a notification mail' do
#
#    WebUpdateChecker::Checker.new(@url, @regex, @mail).execute.should be_true
#
#  end
#

  after(:all) do
  end

end
