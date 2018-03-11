require "logstash/filters/base"
require "logstash/namespace"
require "rest-client"
require "json"

class LogStash::Filters::WhoIs < LogStash::Filters::Base

  config_name "whois"
  config :apikey, :validate => :string, :default => ""
  config :wait_time, :validate => :number, :default => 0.5
  config :dns_field_name, :validate => :string, :default => "target_domain"

  public
  def register

  end

  public
  def filter(event)

    if !event.get(dns_field_name).nil?
       target_domain =  event.get(dns_field_name)
       puts "Conducting WhoIs Analysis on URL: #{target_domain}"
       @logger.debug? && @logger.debug("Conducting WhoIs Analysis on Specificed Domain Name : #{target_domain}")

       url = "https://jsonwhois.com/api/v1/whois?domain=#{target_domain}"

       response = RestClient.get url, {content_type: :json, accept: :json, authorization: "Token token=#{apikey}"}

       @logger.debug? && @logger.debug(puts JSON.parse(response))

      # Report results
      event.set("whois_report_data",JSON.parse(response) )

    else
      puts "logstash-filter-whois: WARNING: target_domain does not exist in event"
    end

    filter_matched(event)
  end
end
