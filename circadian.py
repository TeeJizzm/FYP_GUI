import datetime
from astral.sun import sun
from astral import LocationInfo as locationinfo

f = open("sunimes.csv", "w")
f.write("Date, Dawn, Sunrise, Sunset, Dusk\n")


city = locationinfo("London", "England", "Europe/London", 51.5, -1.19)


print(f"Information for {city.name} {city.region} \n")
print(f"Timezone: {city.timezone} \n")
print(f'Latitude: {city.latitude:.02f}; Longitude: {city.longitude:.02f} \n')


startDate = datetime.date(2020,1,1)
endDate = datetime.date(2021,1,1)
delta = datetime.timedelta(days=1)


while startDate < endDate:
	s = sun(city.observer, startDate)

	dawn = (s["dawn"]).replace(tzinfo=None)
	sunset = (s["sunset"]).replace(tzinfo=None)
	sunrise = (s["sunrise"]).replace(tzinfo=None)
	dusk = (s["dusk"]).replace(tzinfo=None)

	f.write(f"{startDate.year}-{startDate.month}-{startDate.day},")
	f.write(f"{dawn.hour}:{dawn.minute},")
	f.write(f"{sunrise.hour}:{sunrise.minute},")
	f.write(f"{sunset.hour}:{sunset.minute},")
	f.write(f"{dusk.hour}:{dusk.minute}\n")

	startDate += delta

f.close()
