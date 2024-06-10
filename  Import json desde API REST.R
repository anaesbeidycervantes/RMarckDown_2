# Instalar y cargar las librerías necesarias
install.packages(c("httr", "jsonlite", "ggplot2"))
library(httr)
library(jsonlite)
library(ggplot2)

# Definir la URL de la API y obtener los datos
base <- "https://api.covidactnow.org/v2/states.json?"
apiKey <- "apiKey=41fcb59d556143518c33e95ec44c6076"
urlApiCovid <- paste0(base, apiKey)

jsondata <- GET(urlApiCovid)
COVID_list <- fromJSON(rawToChar(jsondata$content), flatten = TRUE)

# Crear el dataframe con los datos obtenidos
df <- data.frame(State = COVID_list$state, Poblacion = COVID_list$population)

# Ordenar los estados por población
df <- df[order(df$Poblacion, decreasing = FALSE), ]

# Ajustar el tamaño del gráfico
options(repr.plot.width=10, repr.plot.height=6)

# Crear el gráfico de barras ordenado con personalizaciones
ggplot(df, aes(x = reorder(State, -Poblacion), y = Poblacion, fill = State)) +
  geom_bar(stat = "identity", width = 0.7, color = "black") +
  labs(title = "Población por Estado", x = "Estado", y = "Población") +
  scale_fill_viridis_d() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  theme_minimal()

# Visualizar el dataframe
View(df)

