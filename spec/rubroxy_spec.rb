require 'rubroxy'
require 'httparty'

describe 'Basic proxy creation' do
  before :all do
    @proxy = Proxy.new('localhost', 8080, 3)
  end

  after :all do
    @proxy.stop_server
  end

  it 'should be configured to the correct address' do
    expect(@proxy.server.config[:BindAddress]).to eq 'localhost'
  end

  it 'should be configured to the correct port' do
    expect(@proxy.server.config[:Port]).to eq 8080
  end

  it 'should have a logger attached' do
    expect(@proxy.server.config[:Logger].level).to be 3
  end
end

describe 'Proxy creation without defined logging' do
  before :each do
    @proxy = Proxy.new('localhost', 8080)
  end

  it 'should set default logging level' do
    expect(@proxy.server.config[:Logger].level).to be 2
  end

  after :each do
    @proxy.stop_server
  end
end

describe 'Proxy with content handler' do
  before :all do
    @proxy = Proxy.new('localhost', 8080, 2)
    @handler = proc do |req, res|
      res.body = 'test'
    end
  end

  after :each do
    Process.kill('INT', @pid) if @pid
  end

  it 'should be okay with Proc handler' do
    @proxy.add_rules(@handler)
    expect(@proxy.server.config[:ProxyContentHandler].class).to be Proc
  end

  it 'should alter captured responses' do
    @proxy.add_rules(@handler)
    options = { http_proxyaddr: @proxy.server.config[:BindAddress],
                http_proxyport: @proxy.server.config[:Port] }

    @pid = fork { @proxy.start_server }

    response = HTTParty.get('http://qa.sit.dotcom.awseuwest1.itvcloud.zone',
                            options)
    expect(response.body).to eq 'test'
  end
end
