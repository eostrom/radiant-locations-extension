## Testing ##

The Locations extension has two sets of tests:  specs (using RSpec)
and features (using Cucumber).  Specs test individual pieces of the
extension; features confirm that the extension as a whole is working
as expected.

To run the specs, use

    rake spec:extensions EXT=locations

To run the features, use

    rake radiant:extensions:locations:features

However, as of Radiant 0.6.9, running in the test environment will
automatically load the BasicExtension fixture, which sets up a route
that interferes with integration testing.  To prevent this, add the
following line to config/environment.rb (in your application
directory, not the extension directory):

    config.extensions = [ :locations ] if config.environment == 'test'

## Sample ##

    <r:location:map div="customers-map">
      <!-- defines a map with location markers -->
      <!-- contents will be replaced by an interactive map, if JS is on -->
      <div>
        <r:location:map:static /><!-- embedded image -->
      </div>
      <ul>
        <r:find url="/customers">
          <r:children:each>
            <r:location>
              <!-- defines a location marker on the map -->
              <!-- location is stored in attributes of the page object -->
              <!-- contents are rendered in fallback text AND marker bubble -->
              <li>
                <h2><r:link />
                <p><r:content part="blurb"/></p>
                <r:location:unless_map>
                  <!-- show only in fallback text -->
                  <p>Location: <r:location:link></p>
                  <!-- address/coords, link to offsite map -->
                </r:location:unless_map>
              </li>
            </r:location>
          </r:children:each>
        </r:find>
      </ul>
    </r:location:map>
