# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'fitbit_client'
require 'minitest/autorun'
require 'simplecov'
require 'vcr'

SimpleCov.start

VCR.configure do |config|
  config.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  config.hook_into :faraday
end

def client
  @client ||= FitbitClient::Client.new('token', 'refresh_token', client_id: '1234567', client_secret: 'qwertyuiopoiuytr123456')
end
