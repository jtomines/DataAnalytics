# Unit 6 | Assignment - What's the Weather Like?

## Tale of Two Versions

For this assignment, I created two version of the WeatherPy assignment.

The first, JTomines_WeatherPy.ipynb, is the original solution using the same set of steps as outlined in the Starter Code.  This includes the following steps:  1) Generate a large number of geographic coordinates, 2) Use CitiPy to find the nearest city for each geographic coordinate generated, and 3) Make requests to the Weather API using the nearest city name, and determine if the Weather API has weather data for that city name knowing that some cities may not have data in the Weather API.

My fundamental concern is that you have to arbitrarily choose a large enough number (in this case I chose 1000) of coordinates, to generate the nearest city names, and hope that there is data for atleast 500 of those cities (minimum required for this assignment).  If you didn't choose a large enough number, you will need to run the script again.

I wanted a solution that once you pressed the "Run" button, it will give you the requisite 500 rows of data needed.

So I created the second version:  JTomines_WeatherPy_Alt.ipynb.  This version does step 1-3 summarized above in a While Loop until 500 rows of city weather data was collected.  This could easily be modified to collect larger amounts of data, in case the required number of rows is increased in the future.


## Bonus Plots

Because the Weather API also includes Sunrise and Sunset times for each city, I thought it would be interesting to include plots that show the relationship between Latitude and Sunrise and Sunset times, as well as the corresponding Duration of Sunlight locations would experience.  I also thought it would be interesting to view how the random generated geographic coordinates would ultimately choose locations and view the actual locations in a scatter plot of the location's actual coordinates.  I also included observations/trends for those 3 additional plots.



Enjoy,

#### Jose Tomines