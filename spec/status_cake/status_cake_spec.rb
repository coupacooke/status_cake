require 'spec_helper'

if ENV['STATUSCAKE_VERBOSE'] == 'true'
  class StatusCake
    debug_output $stdout
  end
end

describe StatusCake do
  subject do
    StatusCake.new(username: ENV['STATUSCAKE_USER'], api_key: ENV['STATUSCAKE_APIKEY'])
  end

  context "tests" do
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
        test = subject.find_test(170051)
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

    it 'should return blank arrays for no matches' do
      VCR.use_cassette('retrieve_by_name') do
        expect(subject.tests('CUID' => '10395', 'WebsiteName' => 'DOESNOTEXIST')).to eq([])
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

  context "contact groups" do
    it 'should be able to retrieve contact groups' do
      VCR.use_cassette('retrieve_contact_groups') do
        expect(subject.contact_groups.size).to be 2
      end
    end

    it 'should be able to retrieve contact groups by name' do
      VCR.use_cassette('retrieve_contact_groups') do
        expect(subject.contact_groups('GroupName' => 'Test').size).to be 1
      end
    end

    it 'should return blank arrays for no matches' do
      VCR.use_cassette('retrieve_contact_groups') do
        expect(subject.contact_groups('GroupName' => 'DOESNOTEXIST')).to eq([])
      end
    end

    it 'should be able to create a contact group' do
      VCR.use_cassette('create_contact_group') do
        response = subject.update_contact_group({
          'GroupName' => 'Test Contact Group API',
          'Email' => 'test@invalid.com'
        })
        expect(response['Success'] == 'true')
      end
    end

    it 'should be able to update a contact group' do
      VCR.use_cassette('update_contact_group') do
        cg = subject.contact_groups.find { |c| c['GroupName'] == 'Test Contact Group API' }
        expect(cg).not_to be_nil

        response = subject.update_contact_group({
          'ContactID' => cg['ContactID'],
          'GroupName' => 'Test Contact Group API - Updated',
          'Email' => 'test.updated@invalid.com'
        })
        expect(response['Success'] == 'true')

        retrieved_cg = subject.contact_groups.find { |c| c['ContactID'] == cg['ContactID'] }
        expect(retrieved_cg).not_to be_nil
        expect(retrieved_cg['GroupName']).to eq('Test Contact Group API - Updated')
        expect(retrieved_cg['Emails'].first).to eq('test.updated@invalid.com')
      end
    end
  end
end
