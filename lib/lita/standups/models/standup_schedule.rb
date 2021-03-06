require "lita/standups/models/standup"

module Lita
  module Standups
    module Models
      class StandupSchedule < Base

        include Ohm::Callbacks
        include Ohm::Timestamps
        include Ohm::DataTypes

        attribute :repeat
        attribute :day_of_week
        attribute :time, Type::Time
        attribute :recipients, Type::Array
        attribute :channel

        reference :standup, "Lita::Standups::Models::Standup"

        def cron_line
          [
            time.min,
            time.hour,
            "*",
            "*",
            cron_line_week,
            "UTC"
          ].join(" ")
        end

        def cron_line_week
          return "*" if daily?
          return "1,2,3,4,5" if workdays?
          return day_of_week_index if weekly?
        end

        def day_of_week_index
          %w(sunday monday tuesday wednesday thursday friday saturday).index(day_of_week)
        end

        def summary
          day_text = weekly? ? " on #{day_of_week}" : ""
          "ID: #{id} - running standup #{standup.name} (ID: #{standup.id}) #{repeat}#{day_text} at #{time.strftime("%H:%M")}"
        end

        def description
          [
            "ID: #{id}",
            "Standup: #{standup.name} (ID: #{standup.id})",
            "Recipients: #{recipients.join(", ")}",
            "Running #{repeat} " + (weekly? ? "on #{day_of_week} " : "") + "at #{time.strftime("%H:%M")}",
            "Sending the result on #{channel}"
          ].join("\n")
        end

        def daily?
          repeat == "daily"
        end

        def weekly?
          repeat == "weekly"
        end

        def workdays?
          repeat == "workdays"
        end

      end
    end
  end
end
