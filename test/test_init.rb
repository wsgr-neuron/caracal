ENV["CONSOLE_DEVICE"] ||= "stdout"
ENV["LOG_TAGS"] ||= "_all,_untagged"
ENV["LOG_LEVEL"] ||= "_min"

ENV["TEST_BENCH_DETAIL"] ||= ENV["D"]

require_relative "../init"

require "pp"
require "test_bench"; TestBench.activate

require "docx/fixtures"

require "caracal/controls"
Controls = Caracal::Controls
