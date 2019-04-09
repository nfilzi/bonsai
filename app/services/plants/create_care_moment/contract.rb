module Plants
  class CreateCareMoment
    class Contract
      attr_reader :errors

      def initialize(plant, care_moment_code)
        @plant            = plant
        @care_moment_code = care_moment_code

        @errors           = []
      end

      def valid?
        @valid
      end

      def validate
        @last_moment = @plant.care_moments.
          where(code: @care_moment_code).
          order('date DESC').
          first

        check_care_moment_needed_for_code

        self
      end

      private

      def check_care_moment_needed_for_code
        @valid = !(@last_moment && Date.today < @last_moment.date + care_moment_specs[:min_frequency_in_days].days)

        unless @valid
          @errors << {
            code:    :no_need_for_care_moment,
            message: "You can't #{@care_moment_code} your plant right now. It's too soon."
          }
        end
      end

      def care_moment_specs
        @care_moment_specs ||= CareMoment::MOMENTS[@care_moment_code.to_sym]
      end
    end
  end
end
