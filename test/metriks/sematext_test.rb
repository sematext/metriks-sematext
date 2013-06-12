# Copyright 2013 Sematext Group, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'test/unit'
require 'mocha/setup'
require 'metriks'
require 'metriks/sematext'

class SematextReporterTest < Test::Unit::TestCase
  def build_reporter(options={})
    @client = Sematext::Metrics::Client.sync('token')
    @reporter = Metriks::Sematext::Reporter.new({
      :client => @client,
      :registry => @registry
    }.merge(options))
  end

  def setup
    @registry = Metriks::Registry.new
    @reporter = build_reporter
  end
  
  def teardown
    @reporter.stop
    @registry.stop
  end
  
  def test_write
    @registry.meter('metriks-meter').mark
    @registry.counter('metriks-counter').increment
    @registry.timer('metriks-timer').update(1.5)
    @registry.histogram('metriks-histogram').update(1.5)
    @registry.utilization_timer('metriks-utilization-timer').update(1.5)

    @client.expects(:send_batch).with() { |datapoints|
      assert_include datapoints, {
        :name => 'metriks-meter',
        :value => 1,
        :agg_type => :avg,
        :filter1 => "aggregation=avg",
        :filter2 => "type=count"
      }
      assert_include datapoints, {
        :name => 'metriks-counter',
        :value => 1,
        :agg_type => :avg,
        :filter1 => "aggregation=avg"
      }
      assert_include datapoints, {
        :name => 'metriks-timer',
        :value => 1.5,
        :agg_type => :max,
        :filter1 => "aggregation=max"
      }
      assert_include datapoints, {
        :name => 'metriks-histogram',
        :value => 1.5,
        :agg_type => :max,
        :filter1 => "aggregation=max"
      }
      assert_include datapoints, {
        :name => 'metriks-utilization-timer',
        :value => 1.5,
        :agg_type => :min,
        :filter1 => "aggregation=min"
      }
      assert_include datapoints, {
        :name => 'metriks-utilization-timer',
        :value => 1.5,
        :agg_type => :avg,
        :filter1 => "aggregation=avg",
        :filter2 => "type=time"
      }
      true      
    }

    @reporter.write
  end

  private
  def assert_include(collection, element)
    assert_block("Element #{element} not found.") do
      collection.include? element
    end
  end
end

