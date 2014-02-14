require "web_update_checker/version"

# ruby standard
require "net/http"
require "uri"
require 'fileutils'

# gem
require 'mail'

module WebUpdateChecker

  class Checker

    #
    # @param [String] url to Checker
    # @param [Regex] Regex of to match comparing text
    # @param [Mail] instance of Mail
    #
    def initialize(url, regex = nil, mail = nil)
      @url  = url
      @regex = regex
      @mail = mail
      @tmp_file_last    = '/tmp/site_last.txt'
      @tmp_file_current = '/tmp/site_current.txt'
    end


    #
    # @param [Bool] true if changed, false if no change, nil if first time.
    #
    def execute

      uri = URI.parse(@url)


      uri = URI(@url)
      req = Net::HTTP::Get.new(uri.path)

      response = Net::HTTP.start(
        uri.host, uri.port, 
        :use_ssl => uri.scheme == 'https', 
        :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |https|
          https.request(req)
        end



        matched_body = nil
        if @regex
          match = @regex.match(response.body)
          if match.nil?
            raise "Regex does not match"
          end
          matched_body = match[1]
        else
          matched_body = response.body
        end


        unless File.exist?(@tmp_file_last)
          # first time
          File.write(@tmp_file_last,    matched_body)
          File.write(@tmp_file_current, matched_body)
          return nil
        else
          # 2nd time
          File.write(@tmp_file_current, matched_body)
        end


        result = nil
        unless FileUtils.compare_file(@tmp_file_last, @tmp_file_current)
          @mail.deliver! if @mail
          result = true
        else
          result = false
        end

        File.write(@tmp_file_last,    matched_body)

        return result

    end


  def cleanup
    File.unlink(@tmp_file_last)    if File.exists?(@tmp_file_last)
    File.unlink(@tmp_file_current) if File.exists?(@tmp_file_current)
  end


  end

end
