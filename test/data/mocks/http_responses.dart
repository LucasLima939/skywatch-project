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
}
