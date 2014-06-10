require 'spec_helper'

if ENV['STATUSCAKE_VERBOSE'] == 'true'
  class StatusCake
    debug_output $stdout
  end
end

describe StatusCake do

  context "simple operations" do
    subject do
      StatusCake.new(username: ENV['STATUSCAKE_USER'], api_key: ENV['STATUSCAKE_APIKEY'])
    end

    it 'should be able to create a test' do
      VCR.use_cassette('create_test') do
        response = subject.update_test({
          'WebsiteName'  => 'google.com',
          'WebsiteURL'   => 'https://google.com',
          'CheckRate'    => '300',
          'ContactGroup' => '10395',
          'TestType'     => 'HTTP',
          'Paused'       => 1
        })
        expect(response['Success'] == 'true')
      end
    end

    it 'should be able to retrieve tests' do
      VCR.use_cassette('retrieve_all') do
        expect(subject.tests('CUID' => '10395').size).to eq(2)
      end
    end

    it 'should be able to retrieve a test by id' do
      VCR.use_cassette('retrieve_by_id') do
        test = subject.find(170051)
        expect(test).not_to be_nil
        expect(test['WebsiteName']).to eq('google.com')
      end
    end

    it 'should be able to retrieve a test by name' do
      VCR.use_cassette('retrieve_by_name') do
        test = subject.tests('WebsiteName' => 'google.com', 'CUID' => '10395').first
        expect(test).not_to be_nil
        expect(test['WebsiteName']).to eq('google.com')
      end
    end

    it 'should be able to unpause a test' do
      VCR.use_cassette('unpause_test') do
        response = subject.unpause_test(subject.tests('WebsiteName' => 'google.com', 'CUID' => '10395').first)
        expect(response['Success']).to be true
      end
    end

    it 'should be able to pause a test' do
      VCR.use_cassette('pause_test') do
        response = subject.pause_test(subject.tests('WebsiteName' => 'google.com', 'CUID' => '10395').first)
        expect(response['Success']).to be true
      end
    end

    it 'should be able to delete a test' do
      VCR.use_cassette('delete_test') do
        response = subject.delete_test(subject.tests('WebsiteName' => 'google.com', 'CUID' => '10395').first)
        expect(response['Success']).to be true
      end
    end
  end
end
