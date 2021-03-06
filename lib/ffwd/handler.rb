# $LICENSE
# Copyright 2013-2014 Spotify AB. All rights reserved.
#
# The contents of this file are licensed under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with the
# License. You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.

require_relative 'connection'

module FFWD
  # Handlers are used by output plugins based of the protocol stack.
  class Handler < FFWD::Connection
    def self.new signature, parent, *args
      instance = super(signature, *args)

      instance.instance_eval do
        @parent = parent
      end

      instance
    end

    def unbind
      @parent.unbind
    end

    def connection_completed
      @parent.connection_completed
    end

    def send_all events, metrics; end
    def send_event event; end
    def send_metric metric; end
  end
end
