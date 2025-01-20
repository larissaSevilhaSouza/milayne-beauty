module RailsAdmin
  module Config
    module Fields
      module Types
        class Datetime < RailsAdmin::Config::Fields::Base
          register_instance_option :datepicker_options do
            {
              allowInput: true,
              enableTime: true,
              altFormat: flatpickr_format,
              defaultHour: ::Time.now.hour,
              defaultMinute: ::Time.now.min,
            }
          end
        end
      end
    end
  end
end