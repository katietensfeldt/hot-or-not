# README

- Ruby version 3.0.0

- Postgres database

## Start up instructions

1. Clone the repository on to your local machine.

2. Run `bundle install` to install dependencies.

3. Create a database for the repository with `rails db:create`.

4. Seed the database with initial data using `rails db:seed`.

5. Run `bin/rails credentials:edit` and create a variable called `open_weather`, making the value the app id credential from [Open Weather API](https://openweathermap.org/).

6. To start the server, run `rails s`.

7. Navigate to your GraphQL IDE.

8. You may now run your queries and mutations.

**NOTE on running mutation:** Due to time constraints, I was not able to fully complete the mutation, in that the input will not accept an enum. For 'Farenheit', you must input 0, for 'Celcius', 1, and for 'Kelvin', 3.

**NOTES on running mutation:** When passing inputs into the mutation to update values, you must pass in an input object. For the return, you must pass the 'hotnessSetting' object before selecting its field values.
Ex.

```gql
mutation {
  updateHotnessSettings(input: { units: 0, temp: 50.0 }) {
    hotnessSetting {
      temp
      units
    }
  }
}
```

## My notes

### Issues encountered

- I found this assignment to be challenging, only because I had not worked with GraphQL in a Rails project. Every step required extra time to go over documentation, and cross-referencing.
- A second issue I encountered was finding helpful documentation in dealing with consuming a 3rd party API and placing a GraphQL layer over the top, specifically for Rails. I had to rely on documentation from other languages and convert to my needs.
- From a more technical standpoint, I would have to say the most difficult aspect was getting the enums for TempUnits to work properly. I was able to get the mutation to run by passing in the enum values, but I was unable to get those values to save in the database.
- Another challenging aspect I had was trying to figure out a way to have the hotness settings save without a database. I felt the best solution, given my current knowledge and time was to create a table that would store the hotness settings.

### What would I have done with more time

- Firstly, I would like to have gotten the enums working properly. I was making progress with it, and given more time, I would have gotten it working, but due to time constraints, that's one element I was not able to complete.
- With more time, I would like to expand on the database, creating users with their desired temperature and temp units saved to their account, thereby allowing a user to simply log in and see exactly the data they want to see without having to continuously set the temp and unit. At the moment, if this were a live GraphQL API, it would only work with one temperature and unit type at a time. Another alternative could be to store the hotness settings as a cookie in the browser, or as a session token, thereby eliminating a need to store any data in a database.
- I would have liked to figure out a better way to resolve the data that is returned in the query. At the moment, it runs several loops, so not as efficient as I feel it could be. I feel there is a better way to accomplish this task than running - at most - 2 loops.

### Other

There were a few items within the provided schema that were not completed.

- `OneDayWeather` is missing fields `wind` and `groundLevel`. The `Wind` type was not provided, however, given more time, I would have designed how the type should have looked and included that in the schema. The other field, `groundLevel` was not included, as that was not a piece of data provided by the Open Weather API.

- Type `City` is missing the field `state`, as that was not a piece of data provided by the API. With more time, possibly using the city coordinates, I could have used an alternative API to figure out the city's state or province.
