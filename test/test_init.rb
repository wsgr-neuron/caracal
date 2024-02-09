ENV["CONSOLE_DEVICE"] ||= "stdout"
ENV["LOG_TAGS"] ||= "_all,_untagged"
ENV["LOG_LEVEL"] ||= "_min"

ENV["TEST_BENCH_DETAIL"] ||= ENV["D"]

require_relative "../init.rb"

require "pp"
require "test_bench"; TestBench.activate

require "caracal/controls"
Controls = Caracal::Controls

require "caracal/fixtures"
Fixtures = Caracal::Fixtures
