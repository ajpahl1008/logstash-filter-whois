# encoding: utf-8
require 'spec_helper'
require "logstash/filters/whois"

describe LogStash::Filters::WhoIs do
  describe "Set to Hello World" do
    let(:config) do <<-CONFIG
      filter {
        whois {
          apikey => "ABC"
          url => "http://www.mtv.com"
        }
      }
    CONFIG
    end

    sample("url" => "fail") do
      expect(subject.get("target_url")).to eq('PASS')
    end
  end
end
