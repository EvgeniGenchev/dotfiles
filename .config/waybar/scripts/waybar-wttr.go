package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"strings"
	"time"
)

// WeatherCodes maps weather condition codes to emoji.
var WeatherCodes = map[string]string{
	"113": "☀️", "116": "⛅️", "119": "☁️", "122": "☁️", "143": "🌫️",
	"176": "🌦️", "179": "🌨️", "182": "🌧️", "185": "🌧️", "200": "⛈️",
	"227": "🌬️", "230": "🌨️", "248": "🌫️", "260": "🌫️", "263": "🌦️",
	"266": "🌦️", "281": "🌧️", "284": "🌧️", "293": "🌦️", "296": "🌦️",
	"299": "🌧️", "302": "🌧️", "305": "🌧️", "308": "🌧️", "311": "🌧️",
	"314": "🌧️", "317": "🌧️", "320": "🌨️", "323": "🌨️", "326": "🌨️",
	"329": "❄️", "332": "❄️", "335": "❄️", "338": "❄️", "350": "🌧️",
	"353": "🌦️", "356": "🌧️", "359": "🌧️", "362": "🌨️", "365": "🌨️",
	"368": "🌨️", "371": "❄️", "374": "🌨️", "377": "🌨️", "386": "⛈️",
	"389": "⛈️", "392": "🌨️", "395": "❄️",
}

// WeatherData represents the structure of the weather data response.
type WeatherData struct {
	CurrentCondition []struct {
		WeatherCode string `json:"weatherCode"`
		FeelsLikeC  string `json:"FeelsLikeC"`
		WeatherDesc []struct {
			Value string `json:"value"`
		} `json:"weatherDesc"`
		TempF         string `json:"temp_F"`
		WindspeedKmph string `json:"windspeedKmph"`
		Humidity      string `json:"humidity"`
	} `json:"current_condition"`
	Weather []struct {
		Date      string `json:"date"`
		MaxtempF  string `json:"maxtempF"`
		MintempF  string `json:"mintempF"`
		Astronomy []struct {
			Sunrise string `json:"sunrise"`
			Sunset  string `json:"sunset"`
		} `json:"astronomy"`
		Hourly []struct {
			Time         string `json:"time"`
			WeatherCode  string `json:"weatherCode"`
			FeelsLikeC   string `json:"FeelsLikeC"`
			WeatherDesc  []struct {
				Value string `json:"value"`
			} `json:"weatherDesc"`
			Chanceoffog      string `json:"chanceoffog"`
			Chanceoffrost    string `json:"chanceoffrost"`
			Chanceofovercast string `json:"chanceofovercast"`
			Chanceofrain     string `json:"chanceofrain"`
			Chanceofsnow     string `json:"chanceofsnow"`
			Chanceofsunshine string `json:"chanceofsunshine"`
			Chanceofthunder  string `json:"chanceofthunder"`
			Chanceofwindy    string `json:"chanceofwindy"`
		} `json:"hourly"`
	} `json:"weather"`
}

func main() {
	weatherData, err := fetchWeatherData("https://wttr.in/?format=j1")
	if err != nil {
		fmt.Println("Failed to fetch weather data:", err)
		return
	}

	data, err := processData(weatherData)
	if err != nil {
		fmt.Println("Failed to process data:", err)
		return
	}

	fmt.Println("Weather Data:", data)
}

func fetchWeatherData(url string) (*WeatherData, error) {
	resp, err := http.Get(url)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	var data WeatherData
	if err := json.NewDecoder(resp.Body).Decode(&data); err != nil {
		return nil, err
	}

	return &data, nil
}

func processData(data *WeatherData) (map[string]string, error) {
	result := make(map[string]string)
	if len(data.CurrentCondition) == 0 {
		return nil, fmt.Errorf("no current weather data available")
	}

	current := data.CurrentCondition[0]
	weatherCode := current.WeatherCode
	result["text"] = fmt.Sprintf(" %s %s°C", WeatherCodes[weatherCode], current.FeelsLikeC)

	var tooltip bytes.Buffer
	tooltip.WriteString(fmt.Sprintf("<b>%s %s°</b>\n", current.WeatherDesc[0].Value, current.TempF))
	tooltip.WriteString(fmt.Sprintf("Feels like: %s°C\n", current.FeelsLikeC))
	tooltip.WriteString(fmt.Sprintf("Wind: %sKm/h\n", current.WindspeedKmph))
	tooltip.WriteString(fmt.Sprintf("Humidity: %s%%\n", current.Humidity))

	for _, day := range data.Weather {
		date := day.Date
		tooltip.WriteString(fmt.Sprintf("\n<b>%s</b>\n", formatDate(date)))
		tooltip.WriteString(fmt.Sprintf("⬆️ %s° ⬇️ %s° ", day.MaxtempF, day.MintempF))
		tooltip.WriteString(fmt.Sprintf("🌅 %s 🌇 %s\n", day.Astronomy[0].Sunrise, day.Astronomy[0].Sunset))

		for _, hour := range day.Hourly {
			hourEmoji := WeatherCodes[hour.WeatherCode]
			timeFormatted, _ := formatTime(hour.Time)
			tooltip.WriteString(fmt.Sprintf("%s %s %s°C %s, ", timeFormatted, hourEmoji, hour.FeelsLikeC, hour.WeatherDesc[0].Value))
			// Here you should implement the logic to add conditions based on the chance values
			// Similar to the Python script, you would check each chance value and append it to the string
		}
	}

	result["tooltip"] = tooltip.String()
	return result, nil
}

func formatDate(dateStr string) string {
	date, err := time.Parse("2006-01-02", dateStr)
	if err != nil {
		return dateStr // Return original string on error
	}
	return date.Format("Monday, January 2")
}

func formatTime(timeStr string) (string, error) {
	hour, err := strconv.Atoi(timeStr)
	if err != nil {
		return "", err
	}
	return fmt.Sprintf("%02d:00", hour/100), nil
}

