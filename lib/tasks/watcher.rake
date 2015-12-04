# rake watcher

require "net/http"
require "uri"
require "rrd"

task :watcher => :environment do
  def dorequest(http, uri)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    response.code
  end

  def dohead(http, uri)
    request = Net::HTTP::Head.new(uri.request_uri)
    response = http.request(request)
    response.code
  end

  test = Watcher.all
  rrd = RRD::Base.new("myrrd.rrd")

  test.each do |w|
    uri = URI.parse(w.apiurl)
    http_ = Net::HTTP.new(uri.host, uri.port)
    http_.use_ssl = true if uri.scheme == 'https'
    http_.verify_mode = OpenSSL::SSL::VERIFY_NONE if uri.scheme == 'https'

    http_.start do |http|
      ts = Time.now()
      webrc = dohead(http, uri)
      twebserver = Time.now()
      apirc = dorequest(http, uri)
      tapi = Time.now()
      puts "#{Time.now} #{webrc} #{apirc} #{w.apiurl} #{twebserver - ts} #{tapi - twebserver}"
    end
  end
end
