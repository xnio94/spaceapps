# GreenEarth

you can download the app from playstor https://bit.ly/324gLy2

## about the app

The GreenEarth mobile application can help you switch to solar power energy and be more earth friendly It uses the Power api provided by NASA to compute how much you can save (in a period of 10 years) if you switch to solar energy

## detailed description

saving the environment can go hands by hands with saving money. our idea is to convince people that by saving their assets they are actually saving the world and making it a better place to live in.

our aim is to convince people to use cleaner and environmental friendly means of generating electricity by showing them how much money they could save if they switch to solar panels . and that's by a simple computation of how much it will save them, comparing to their usual consumption.

anyone and anywhere on the globe can use our mobile application by a single click has access at his fingertips to energy that he/she could produce by solar panels and how much it will save him/her .all it needs to do is to he give the application the monthly energy consumption.

## the idea behind the application:

we connect our application with the a NASA API called: NASA POWER DATA SETS power.larc.nasa.gov that contains geospatially enabled solar, meteorology and cloud related parameters formulated for assessing and designing renewable energy systems

from this API we extract two parameters according to the coordinates of the user location on the earth :

DNR(Direct Normal Radiation) : indicates the average energy a horizontal area of 1 meter square gets in one day from the direct incidence of solar rays.
DIFF(Diffuse Radiation On A Horizontal Surface): indicates the average daily energy a horizontal area of 1 meter square gets from the the diffused solar rays by the clouds.
their sum is an estimation of the the total energy a potential solar panel of one meter square could get in average.

then we ask the user to write down how much energy(in kWh) it costs him monthly and by a simple computation we can estimate how many solar panels and the capacity of the battery he would need to cover all his/her needs and their acquisition and maintenance cost in 10 years and how much he/she would save by adopting the solar panels .

we think that our application will convince the average consumer to adopt solar panels then saving energy and contributing to the fight against the global warming.

## want to add improvements

This app was devoloped using the framwork flutter 
to try the app install flutter from the officiel website https://flutter.dev/
then cd to the project directory and end execute "flutter run"

## about the framwork
A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
