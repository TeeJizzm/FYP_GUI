import datetime
from astral.sun import sun
from astral import LocationInfo as locationinfo

city = locationinfo("London", "England", "Europe/London", 51.5, -1.19)


print(f"Information for {city.name} {city.region} \n")
print(f"Timezone: {city.timezone} \n")
print(f'Latitude: {city.latitude:.02f}; Longitude: {city.longitude:.02f} \n')

s = sun(city.observer, date=datetime.date.today())

sunset = (s["sunset"]).replace(tzinfo=None)
sunrise = (s["sunrise"]).replace(tzinfo=None)

print(f"Sunset: {sunset.hour}:{sunset.minute}")
print(f"Sunrise: {sunrise.hour}:{sunrise.minute}")
