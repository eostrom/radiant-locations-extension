# Locations #

This extension allows each page to be associated with a physical
location (address or coordinates), and helps with the creation of
interactive (Google) maps of sets of pages.  A specific goal is to
enable "unobtrusive" maps, so that users without JavaScript can still
get useful information.

(This extension is unfinished.  The UI for setting locations is
primitive, and as of this writing, the map support is completely
unimplemented.  If you stumbled onto the GitHub repository, well,
sorry - it's coming soon!  Meanwhile, see below for another approach
to Radiant maps.)

## Sample ##

This is the kind of thing the extension should enable.  Details are
subject to change.

    <r:locations:map div="customers-map">
      <!-- defines a map with location markers -->
      <!-- contents will be replaced by an interactive map, if JS is on -->
      <div>
        <r:locations:map:static /><!-- embedded image -->
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

## Related Work ##

Jeffrey Jones's [Google Maps Extension][GME] is another way to add
maps to a Radiant site.  Some significant differences between that
location and this one are:

* GME is ready to use; Locations is unfinished.
* GME is built for Radiant 0.7; Locations is presently compatible
  with 0.6.9.
* In Locations, map markers are directly tied to pages on the site,
  and maps are meant to show sets of pages.  In GME, maps are
  independent of pages.  This gives you more freedom but, in some
  cases, less convenience.  For example, if you hide or delete a
  page from the site, it will automatically disappear from a
  Locations-based map.
* Locations requires the Geokit gem for geocoding, and will probably
  require another gem or plugin for maps.  GME uses GeoRuby, YM4R,
  and the spatial adapter plugin.
* Because the spatial adapter works with geometric data types in the
  underlying database, GME may be limited to MySQL and PostGIS.
  Locations, which just uses two float columns to store coordinates,
  may work with a wider selection of databases.  But who knows?

I haven't used GME, but the code looks good.  Choose the extension
that fits your needs ("has been implemented" is probably key, for the
moment), or build a new one!

  [GME]: http://github.com/rurounijones/radiant-google-maps-extension/
