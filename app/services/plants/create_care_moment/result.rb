module Plants
  class CreateCareMoment
    Result = Struct.new(:success, :errors) do
      def success?
        success
      end

      def errors_messages
        errors.map {|error| error[:message]}.join("\n")
      end
    end
  end
end
