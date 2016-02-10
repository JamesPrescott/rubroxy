require 'spec_helper'
require 'rubroxy'

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
  before :all do
    @proxy = Proxy.new('localhost', 8080)
  end

  it 'should set default logging level' do
    expect(@proxy.server.config[:Logger].level).to be 1
  end

  after :all do
    @proxy.stop_server
  end
end

describe 'Proxy with content handler' do
  before :all do
    @proxy = Proxy.new('localhost', 8080, 3)
    @handler = proc do |req, res|
      res.body = 'test' if req['content-type'] == 'text/html'
    end
  end

  after :all do
    @proxy.stop_server
  end

  it 'should be okay with Proc handler' do
    @proxy.add_rules(@handler)
    expect(@proxy.server.config[:ProxyContentHandler].class).to be Proc
  end
end
