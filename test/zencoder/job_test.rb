require 'test_helper'

class Zencoder::JobTest < Test::Unit::TestCase

  context Zencoder::Job do
    setup do
      @api_key = 'abc123'
    end

    context ".create" do
      setup do
        @url = "#{Zencoder.base_url}/jobs"
        @params = {:api_key => @api_key,
                   :input   => "s3://bucket-name/file-name.avi"}
        @params_as_json = MultiJson.encode(@params)
      end

      should "POST to the correct url and return a response" do
        Zencoder::HTTP.stubs(:post).with(@url, @params_as_json, {}).returns(Zencoder::Response.new)
        assert_equal Zencoder::Response, Zencoder::Job.create(@params).class
      end
    end

    context ".list" do
      setup do
        @url = "#{Zencoder.base_url}/jobs"
      end

      should "GET the correct url and return a response" do
        Zencoder::HTTP.stubs(:get).with(@url, {:params => {:api_key => @api_key,
                                                            :page => 1,
                                                            :per_page => 50}}).returns(Zencoder::Response.new)
        assert_equal Zencoder::Response, Zencoder::Job.list(:api_key => @api_key).class
      end
    end

    context ".details" do
      setup do
        @job_id = 1
        @url = "#{Zencoder.base_url}/jobs/#{@job_id}"
      end

      should "GET the correct url and return a response" do
        Zencoder::HTTP.stubs(:get).with(@url, {:params => {:api_key => @api_key}}).returns(Zencoder::Response.new)
        assert_equal Zencoder::Response, Zencoder::Job.details(1, :api_key => @api_key).class
      end
    end

    context ".resubmit" do
      setup do
        @job_id = 1
        @url = "#{Zencoder.base_url}/jobs/#{@job_id}/resubmit"
      end

      should "GET the correct url and return a response" do
        Zencoder::HTTP.stubs(:get).with(@url, {:params => {:api_key => @api_key}}).returns(Zencoder::Response.new)
        assert_equal Zencoder::Response, Zencoder::Job.resubmit(1, :api_key => @api_key).class
      end
    end

    context ".cancel" do
      setup do
        @job_id = 1
        @url = "#{Zencoder.base_url}/jobs/#{@job_id}/cancel"
      end

      should "GET the correct url and return a response" do
        Zencoder::HTTP.stubs(:get).with(@url, {:params => {:api_key => @api_key}}).returns(Zencoder::Response.new)
        assert_equal Zencoder::Response, Zencoder::Job.cancel(1, :api_key => @api_key).class
      end
    end

    context ".delete" do
      setup do
        @job_id = 1
        @url = "#{Zencoder.base_url}/jobs/#{@job_id}"
      end

      should "DELETE the correct url and return a response" do
        Zencoder::HTTP.stubs(:delete).with(@url, {:params => {:api_key => @api_key}}).returns(Zencoder::Response.new)
        assert_equal Zencoder::Response, Zencoder::Job.delete(1, :api_key => @api_key).class
      end
    end
  end
end
