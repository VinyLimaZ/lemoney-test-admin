# frozen_string_literal: true

module Offers
  module StateHandler
    extend ActiveSupport::Concern

    included do
      def toggle_state
        self[:enabled] = disabled? ? true : false
      end

      def disabled?
        self[:enabled] == false
      end

      def not_started?
        !started?
      end

      def finished?
        return false if ends_at.blank?

        ends_at < Date.current
      end

      def started?
        starts_at <= Date.current
      end
    end
  end
end
