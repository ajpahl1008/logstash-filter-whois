# logstash-filter-whois (beta)
This filter connects to WhoIs API services to get registrar information.  
It requires that you register for an API key at https://jsonwhois.com

# Prerequisites
git, ruby

# Download & Compile
```
# git clone http://github.com/ajpahl1008/logstash-filter-whois.github
# cd logstash-filter-whois
# gem clean; gem build logstash-filter-whois.gemspec
```
This will create logstash-filter-whois-6.1.1.gem

# Installation
```
cd ${LOGSTASH_DIR}
bin/logstash-plugin install ${PATH_TO_GEM}
```

# Example Default Logstash Config
```
input {...}

filter {
  whois { 
      apikey=>"YOURAPIKEY"
      dns_field_name = "domain"
   }
}

output {...}
```

# Example output (running in debug)
Starting logstash (with plugin installed) in debug mode
```
bin/logstash -e 'input { stdin{codec => json_lines} } filter { whois { apikey => "YOURAPIKEY" dns_field_name => "domain" } } output {stdout { codec => rubydebug }}'
```
Manually enter a JSON Doc: {"domain":"www.cnn.com"} (Hit enter)
```
Conducting WhoIs Analysis on URL: www.cnn.com
{
           "@timestamp" => 2018-03-11T00:02:09.062Z,
               "domain" => "www.cnn.com",
                 "host" => "AJ-MacBook-Pro-5.local",
    "whois_report_data" => {
                 "expires_on" => "2018-09-21T04:00:00.000Z",
                 "created_on" => "1993-09-22T04:00:00.000Z",
                  "registrar" => {
                     "url" => "www.cscprotectsbrands.com",
                    "name" => "CSC CORPORATE DOMAINS, INC.",
                      "id" => "299",
            "organization" => "CSC CORPORATE DOMAINS, INC."
        },
             "admin_contacts" => [
            [0] {
                         "zip" => "30303",
                       "email" => "tmgroup@turner.com",
                  "created_on" => nil,
                       "state" => "GA",
                     "address" => "One CNN Center",
                         "url" => nil,
                  "updated_on" => nil,
                       "phone" => "+1.4048275000",
                         "fax" => "+1.4048271995",
                "country_code" => "US",
                     "country" => nil,
                        "city" => "Atlanta",
                        "type" => 2,
                          "id" => nil,
                        "name" => "Domain Name Manager",
                "organization" => "Turner Broadcasting System, Inc."
            }
        ],
                "nameservers" => [
            [0] {
                "ipv4" => nil,
                "name" => "ns-47.awsdns-05.com",
                "ipv6" => nil
            },
            [1] {
                "ipv4" => nil,
                "name" => "ns-576.awsdns-08.net",
                "ipv6" => nil
            },
            [2] {
                "ipv4" => nil,
                "name" => "ns-1086.awsdns-07.org",
                "ipv6" => nil
            },
            [3] {
                "ipv4" => nil,
                "name" => "ns-1630.awsdns-11.co.uk",
                "ipv6" => nil
            }
        ],
                 "updated_on" => "2017-02-15T16:01:26.000Z",
                     "status" => "registered",
                 "available?" => false,
                  "domain_id" => "3269879_DOMAIN_COM-VRSN",
                     "domain" => "cnn.com",
         "technical_contacts" => [
            [0] {
                         "zip" => "30303",
                       "email" => "hostmaster@turner.com",
                  "created_on" => nil,
                       "state" => "GA",
                     "address" => "One CNN Center",
                         "url" => nil,
                  "updated_on" => nil,
                       "phone" => "+1.4048275000",
                         "fax" => "+1.4048271593",
                "country_code" => "US",
                     "country" => nil,
                        "city" => "Atlanta",
                        "type" => 3,
                          "id" => nil,
                        "name" => "TBS Server Operations",
                "organization" => "Turner Broadcasting System, Inc."
            }
        ],
        "registrant_contacts" => [
            [0] {
                         "zip" => "30303",
                       "email" => "tmgroup@turner.com",
                  "created_on" => nil,
                       "state" => "GA",
                     "address" => "One CNN Center",
                         "url" => nil,
                  "updated_on" => nil,
                       "phone" => "+1.4048275000",
                         "fax" => "+1.4048271995",
                "country_code" => "US",
                     "country" => nil,
                        "city" => "Atlanta",
                        "type" => 1,
                          "id" => nil,
                        "name" => "Domain Name Manager",
                "organization" => "Turner Broadcasting System, Inc."
            }
        ],
                "registered?" => true
    },
             "@version" => "1"
}

```

Try entering a blank doc: { } (Hit enter)
```
logstash-filter-whois: WARNING: target_domain does not exist in event
{
    "@timestamp" => 2018-03-11T00:01:35.569Z,
          "host" => "hostname.local",
      "@version" => "1"
}
```
