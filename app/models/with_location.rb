module WithLocation
  def self.included(base)
    base.class_eval do
      has_one :location, :dependent => :destroy # one, for now...
      validates_associated :location
      
      def location_with_hash=(new_location)
        if new_location && new_location.is_a?(Hash)
          new_location = Location.new(new_location)
        end
        send(:location_without_hash=, new_location)
      end
      alias_method_chain :location=, :hash
    end
  end
end
