# rake watcher
#
# App Server Availability (resp v no resp)
# Web Response Time
# API Response Time
# 98th perc Web Response Time
# 98th perc API Response Time
# Exception Perc (non-200) 
#
# http://forums.cacti.net/about25502.html
# http://www.tummy.com/blogs/2010/05/15/getting-95-percentile-numbers-out-of-rrdtool/

require "net/http"
require "uri"
require "rrd"

task :watcher => :environment do
  def create(f, dsname, typ, min, max)
    # create("available", "GAUGE", 0, 1)
    # create("exception", "GAUGE", 0, 1)
    # create("responsetime", "ABSOLUTE", 0, 3000) # 3000ms = 3s 
    # RRA: one day of 5 min intervals
    #      7 days of 30 min ints
    #      31 days of 1 hr ints
    RRD::Wrapper.create f, "--step", "300", "DS:#{dsname}:#{typ}:600:#{min}:#{max}", "RRA:AVERAGE:0.5:300:17280", +
	"RRA:AVERAGE:0.5:1800:336", "RRA:AVERAGE:0.5:3600:744"
  end

  def dorequest(http, uri)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    response.code
  end

  def dopost(http, uri, data)
    puts "\tPOSTing: #{data}"
    request = Net::HTTP::Post.new(uri.request_uri)
    request.body = data
    request.content_type = 'application/json'
    response = http.request(request)
    puts "\tPOST-reply: #{response.body}"
    response.code
  end
  
  def dohead(http, uri)
    request = Net::HTTP::Head.new(uri.request_uri)
    response = http.request(request)
    response.code
  end

  def sanitize(x)
    x.gsub(/[^A-Z0-9a-z]+/, "")
  end

  test = Watcher.all

  test.each do |w|
    w_ = sanitize(w.domain)
    availability = RRD::Base.new(w_ + "-avail.rrd")
    webresptime  = RRD::Base.new(w_ + "-webresp.rrd")
    apiresptime  = RRD::Base.new(w_ + "-apiresp.rrd")
    excepperc  = RRD::Base.new(w_ + "-webresp.rrd")

    uri = URI.parse(w.apiurl)
    http_ = Net::HTTP.new(uri.host, uri.port)
    http_.use_ssl = true if uri.scheme == 'https'
    http_.verify_mode = OpenSSL::SSL::VERIFY_NONE if uri.scheme == 'https'
    http_.read_timeout = 3
    http_.open_timeout = 3

    begin
      http_.start do |http|
        ts = Time.now()
        webrc = dohead(http, uri)
        twebserver = Time.now()
        if w.post
          apirc = dopost(http, uri, w.post)
        else
          apirc = dorequest(http, uri)
        end
        tapi = Time.now()
        puts "#{Time.now} #{webrc} #{apirc} #{w.apiurl} #{twebserver - ts} #{tapi - twebserver}"
      end
    rescue Net::OpenTimeout => error
      puts "#{Time.now} not up  #{w.apiurl}"
    end
  end
end
