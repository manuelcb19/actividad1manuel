const { onRequest } = require("firebase-functions/v2/https");
const admin = require("firebase-admin");
admin.initializeApp();
const logger = require("firebase-functions/logger");

exports.insertElement = onRequest(async (request, response) => {
  try {
    // Obtén los datos de la solicitud HTTP
    const data = request.body; // Asumiendo que los datos se envían en el cuerpo de la solicitud POST

    // Inserta los datos en la raíz de la base de datos
    const result = await admin.database().ref().push(data);

    // Obtiene el ID del elemento insertado
    const elementId = result.key;

    // Log para registrar en Firebase
    logger.info(`Elemento con ID ${elementId} fue insertado correctamente.`, { structuredData: true });

    // Envía una respuesta al cliente
    response.status(200).send(`Elemento con ID ${elementId} fue insertado correctamente.`);
  } catch (error) {
    console.error('Error al insertar el elemento:', error);

    // Log para registrar en Firebase
    logger.error('Error al insertar el elemento en la base de datos.', { error: error });

    response.status(500).send('Error al insertar el elemento en la base de datos.');
  }
});
