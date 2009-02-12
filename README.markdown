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
