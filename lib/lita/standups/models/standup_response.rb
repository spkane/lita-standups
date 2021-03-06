require "lita/standups/models/standup_session"

module Lita
  module Standups
    module Models
      class StandupResponse < Base

        include Ohm::Callbacks
        include Ohm::Timestamps
        include Ohm::DataTypes

        attribute :status
        attribute :user_id
        attribute :answers, Type::Array

        reference :standup_session, "Lita::Standups::Models::StandupSession"

        index :status
        index :user_id

        def user
          @user ||= Lita::User.fuzzy_find(user_id)
        end

        def standup
          standup_session.standup
        end

        def questions
          standup.questions
        end

        def before_create
          self.status ||= 'pending'
        end

        def after_save
          standup_session.update_status if finished?
        end

        %w(pending running completed aborted expired).each do |status_name|
          define_method("#{status_name}?") do
            status == status_name
          end
          define_method("#{status_name}!") do
            self.status = status_name
          end
        end

        def finished?
          completed? || aborted? || expired?
        end

        def report_message
          message = "#{user.name} (a.k.a @#{user.mention_name})\n"
          if answers.is_a?(Array)
            questions.map.with_index do |question, index|
              if answers[index]
                message << "> *#{question}*\n"
                answers[index].split("\n").each do |line|
                  message << "> #{line}\n"
                end
              end
              message << "> \n" if index < questions.count - 1
            end
          else
            message << "> *Expired*\n"
          end
          message
        end
      end
    end
  end
end
