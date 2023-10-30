🚀 Rick and Morty App

Una aplicación Flutter que permite a los usuarios visualizar una lista de personajes de la serie Rick and Morty, con detalles y una funcionalidad para marcar a los personajes como favoritos. Esta aplicación fue desarrollada como parte de una prueba técnica para desarrolladores mobile Flutter.

📂 Estructura del proyecto

src/
│
├── data/
│ ├── models/ - Modelos de datos.
│ └── repositories/ - Acceso a datos.
│
├── domain/
│ └── repositories/ - Definiciones de repositorios.
│
├── presentation/
│ ├── notifiers/ - Notificadores con Riverpod.
│ ├── providers/ - Proveedores con Riverpod.
│ ├── screen/ - Pantallas.
│ └── widgets/ - Widgets reutilizables.
│
└── services/ - Servicios como el API.

📦 Paquetes utilizados

📌 flutter_riverpod: Para la gestión del estado.
📌 sqflite: Usado para almacenar la lista de favoritos en la base de datos local.

🔍 Funcionalidades

Lista de Personajes: Visualiza todos los personajes de la serie Rick and Morty.
Detalles del Personaje: Accede a más detalles de un personaje al seleccionarlo.
Favoritos: Marca los personajes como favoritos y accede a una lista separada de tus personajes favoritos.
Usuario: Asocia la lista de favoritos a un usuario específico, cuyo nombre se solicita previamente.

💾 Uso de sqflite

Para proporcionar una experiencia personalizada, la aplicación permite a los usuarios guardar sus personajes favoritos. Estos se almacenan localmente en la base de datos usando el paquete sqflite, garantizando que la lista de favoritos del usuario esté disponible incluso sin conexión a internet.

📝 Prueba técnica Desarrollador Mobile

Esta aplicación fue desarrollada como respuesta a la prueba técnica propuesta. La tarea era desarrollar una aplicación que permitiera visualizar una lista de personajes o lugares de la serie Rick and Morty, incluyendo la posibilidad de marcar personajes como favoritos y visualizar una lista de esos favoritos.

Requerimientos técnicos cumplidos:

Aplicación subida a un repositorio Git.
Aplicación de principios SOLID y buenas prácticas de diseño (clean code, clean architecture).
Uso del manejador de estados Riverpod.

💼 Desarrollado por

👤 Steven Patiño Urquijo
