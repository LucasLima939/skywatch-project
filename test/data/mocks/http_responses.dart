class HttpResponses {
  static get oAuthWeatherResponse => {"access_token": "access_token", "token_type": "bearer"};
  static get forecastResponse => {
        "version": "3.0",
        "user": "rarolabs_lima_lucas",
        "dateGenerated": "2023-10-23T13:44:46Z",
        "status": "OK",
        "data": [
          {
            "parameter": "t_4m:F",
            "coordinates": [
              {
                "lat": -8.05,
                "lon": -34.900002,
                "dates": [
                  {"date": "2023-10-22T00:00:00Z", "value": 76.1},
                  {"date": "2023-10-23T00:00:00Z", "value": 76.9},
                  {"date": "2023-10-24T00:00:00Z", "value": 76.1},
                  {"date": "2023-10-25T00:00:00Z", "value": 76.3},
                  {"date": "2023-10-26T00:00:00Z", "value": 78.0}
                ]
              }
            ]
          },
          {
            "parameter": "weather_symbol_24h:idx",
            "coordinates": [
              {
                "lat": -8.05,
                "lon": -34.900002,
                "dates": [
                  {"date": "2023-10-22T00:00:00Z", "value": 3},
                  {"date": "2023-10-23T00:00:00Z", "value": 3},
                  {"date": "2023-10-24T00:00:00Z", "value": 2},
                  {"date": "2023-10-25T00:00:00Z", "value": 3},
                  {"date": "2023-10-26T00:00:00Z", "value": 8}
                ]
              }
            ]
          }
        ]
      };
  static get addressResponse => {
        "place_id": 281801698,
        "licence": "Data © OpenStreetMap contributors, ODbL 1.0. http://osm.org/copyright",
        "osm_type": "way",
        "osm_id": 741753433,
        "lat": "37.42202505",
        "lon": "-122.08407788511707",
        "category": "leisure",
        "type": "outdoor_seating",
        "place_rank": 30,
        "importance": 9.99999999995449e-06,
        "addresstype": "leisure",
        "name": "",
        "display_name": "Amphitheatre Parkway, Mountain View, Santa Clara County, California, 94043, United States",
        "address": {
          "road": "Amphitheatre Parkway",
          "city": "Mountain View",
          "county": "Santa Clara County",
          "state": "California",
          "ISO3166-2-lvl4": "US-CA",
          "postcode": "94043",
          "country": "United States",
          "country_code": "us"
        },
        "boundingbox": ["37.4219599", "37.4221426", "-122.0842118", "-122.0839386"]
      };
}
